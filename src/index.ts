import {
  AlterTable,
  CONSTRAINT,
  CONSTRAINT_Foreign_Key,
  CONSTRAINT_Primary_Key,
  CreateTable,
  Foreign_Key,
  Primary_Key,
} from "./contants";
import {
  ColumnQuantifiers,
  DatabaseModel,
  ForeignKeyModel,
  PrimaryKeyModel,
  PropertyModel,
  TableModel,
} from "./types";

/*
An attempt to fix sql parser for importing entity diagrams into draw io see
https://github.com/jgraph/drawio/issues/1178
https://drawio-app.com/entity-relationship-diagrams-with-draw-io/

*/

/**
 * Main Parser class
 */
export class SqlSimpleParser {
  private dialect: string;
  private tableList: TableModel[] = [];

  /**
   * Parsed statements.
   */
  private statements: string[] = [];

  /**
   * Remains of string feed, after last parsed statement.
   */
  private remains = "";

  /**
   * Whether preparser is currently escaped.
   */
  private escaped = false;

  /**
   * Current quote char of preparser.
   */
  private quoted = "";
  /**
   * Parser constructor.
   * Default dialect is 'sqlite'.
   * Options: "mysql" | "sqlite" | "postgres" | "sqlserver" .
   *
   * @param dialect SQL dialect ('sqlite').
   */
  constructor(
    dialect: "mysql" | "sqlite" | "postgres" | "sqlserver" = "sqlite"
  ) {
    this.dialect = dialect;
    this.MODE_SQLSERVER =
      this.dialect !== undefined &&
      this.dialect !== null &&
      this.dialect == this.SQLServer;
  }
  private exportedTables = 0;
  private SQLServer = "sqlserver";
  private MODE_SQLSERVER = false;
  private foreignKeyList: ForeignKeyModel[] = [];
  private primaryKeyList: PrimaryKeyModel[] = [];
  /**
   * Feed chunk of string into parser.
   *
   * @param chunk Chunk of string to be parsed.
   */
  feed(chunk: string): SqlSimpleParser {
    //
    var removedComments = chunk
      // remove database comments, multiline, --, and //
      .replace(/\/\*[\s\S]*?\*\/|\/\/|--.*/g, "")
      .trim();
    var cleanedLines = removedComments
      .split("\n")
      // remove empty lines
      .filter((n) => n)
      // remove multiple spaces
      .map((n) => n.replace(/\s+/g, " ").trim());

    // combine lines that are in parenthesis
    var lines: string[] = [];
    var insertSameLine = false;
    cleanedLines.forEach((n) => {
      if (
        (lines.length > 0 &&
          n[0] == "(" &&
          lines[lines.length - 1].toLocaleLowerCase().indexOf(CreateTable) ==
            -1) ||
        insertSameLine
      ) {
        if (lines.length > 0) {
          insertSameLine = true;
          lines[lines.length - 1] += n;
          if (n[0] == ")") insertSameLine = false;
        }
      } else {
        lines.push(n);
      }
    });
    // dx = 0,
    // tableCell = null,
    // cells = [],
    // exportedTables = 0,
    // tableList = [],
    // foreignKeyList = [],
    // rowCell = null;

    var currentTableModel = null;
    //Parse SQL to objects
    for (var i = 0; i < lines.length; i++) {
      // rowCell = null;

      var tmp = lines[i].trim();

      var propertyRow = tmp.toLowerCase().trim();

      if (propertyRow[0] == ")") {
        // close table
        if (currentTableModel) {
          this.tableList.push(currentTableModel);
          currentTableModel = null;
        }
        continue;
      }

      //Parse Table
      if (propertyRow.indexOf(CreateTable) != -1) {
        //Parse row
        var name = tmp
          .replace(this.stringToRegex(`/${CreateTable}/gi`), "")
          .trim();

        //Parse Table Name
        name = this.ParseTableName(name);

        if (currentTableModel !== null) {
          //Add table to the list
          this.tableList.push(currentTableModel);
        }

        //Create Table
        currentTableModel = this.CreateTable(name);
      }
      // Parse Properties
      else if (
        tmp !== "(" &&
        currentTableModel != null &&
        propertyRow.indexOf(AlterTable) == -1
      ) {
        //Parse the row
        var name = tmp.substring(
          0,
          tmp.charAt(tmp.length - 1) === "," ? tmp.length - 1 : tmp.length
        );

        //Attempt to get the Key Type
        var propertyType = name.toLowerCase();
        // .substring(0, AlterTable.length).toLowerCase();

        //Add special constraints
        if (this.MODE_SQLSERVER) {
          if (
            propertyType.indexOf(CONSTRAINT) !== -1 &&
            propertyType.indexOf(Primary_Key) !== -1
          ) {
            propertyType = CONSTRAINT_Primary_Key;
          }

          if (
            propertyType.indexOf(CONSTRAINT) !== -1 &&
            propertyType.indexOf(Foreign_Key) !== -1
          ) {
            propertyType = CONSTRAINT_Foreign_Key;
          }
        }

        //Verify if this is a property that doesn't have a relationship (One minute of silence for the property)
        // TODO: make primary key check a regex match/ contains w/ () space or not
        var normalProperty =
          !propertyType.match(/PRIMARY KEY\s?\(/gi) &&
          propertyType.indexOf(Foreign_Key) == -1 &&
          propertyType.indexOf(CONSTRAINT_Primary_Key) == -1 &&
          propertyType.indexOf(CONSTRAINT_Foreign_Key) == -1;

        const nameSkipCheck = name.toUpperCase().trim();
        //Parse properties that don't have relationships
        if (normalProperty) {
          if (name === "" || name === "" || name === ");") {
            continue;
          }

          let ExtendedProperties: string | null = null;

          if (this.MODE_SQLSERVER) {
            if (
              nameSkipCheck.indexOf(" ASC") !== -1 ||
              nameSkipCheck.indexOf(" DESC") !== -1 ||
              nameSkipCheck.indexOf("EXEC ") !== -1 ||
              nameSkipCheck.indexOf("WITH ") !== -1 ||
              nameSkipCheck.indexOf(" ON") !== -1 ||
              nameSkipCheck.indexOf("ALTER ") !== -1 ||
              // comments already removed
              nameSkipCheck.indexOf("/*") !== -1 ||
              nameSkipCheck.indexOf(" CONSTRAINT") !== -1 ||
              nameSkipCheck.indexOf("SET ") !== -1 ||
              nameSkipCheck.indexOf(" NONCLUSTERED") !== -1 ||
              // no spaces desired
              nameSkipCheck.indexOf("GO") !== -1 ||
              nameSkipCheck.indexOf("REFERENCES ") !== -1
            ) {
              continue;
            }
            //Get delimiter of column name
            //TODO: check for space? or end quantifier
            var firstSpaceIndex =
              name[0] == "[" && name.indexOf("]" + " ") !== -1
                ? name.indexOf("]" + " ")
                : name.indexOf(" ");

            ExtendedProperties = name.substring(firstSpaceIndex + 1).trim();

            //Get full name
            name = name.substring(0, firstSpaceIndex);

            name = this.RemoveNameQuantifiers(name);
          } else {
            const columnQuantifiers = this.GetColumnQuantifiers();
            //Get delimiter of column name
            var firstSpaceIndex =
              name[0] == columnQuantifiers.Start &&
              name.indexOf(columnQuantifiers.End + " ") !== -1
                ? name.indexOf(columnQuantifiers.End + " ")
                : name.indexOf(" ");

            ExtendedProperties = name.substring(firstSpaceIndex + 1).trim();

            //Get full name
            name = name.substring(0, firstSpaceIndex);

            name = this.RemoveNameQuantifiers(name);
          }

          //Create Property
          var propertyModel = this.CreateProperty(
            name,
            currentTableModel.Name,
            null,
            false,
            ExtendedProperties
          );

          //Add Property to table
          currentTableModel.Properties.push(propertyModel);

          if (
            ExtendedProperties.toLocaleLowerCase().indexOf(Primary_Key) > -1
          ) {
            //Create Primary Key
            var primaryKeyModel = this.CreatePrimaryKey(
              name,
              currentTableModel.Name
            );

            //Add Primary Key to List
            this.primaryKeyList.push(primaryKeyModel);
          }
        } else {
          //Parse Primary Key
          if (
            propertyType.indexOf(Primary_Key) != -1 ||
            propertyType.indexOf(CONSTRAINT_Primary_Key) != -1
          ) {
            if (!this.MODE_SQLSERVER) {
              var primaryKey = name
                .replace(/PRIMARY KEY\s?\(/gi, "")
                .replace(")", "");

              //Create Primary Key
              var primaryKeyModel = this.CreatePrimaryKey(
                primaryKey,
                currentTableModel.Name
              );

              //Add Primary Key to List
              this.primaryKeyList.push(primaryKeyModel);
            } else {
              // var start = i + 2;
              // var end = 0;
              if (
                propertyRow.indexOf(Primary_Key) !== -1 &&
                nameSkipCheck.indexOf("CLUSTERED") === -1
              ) {
                var primaryKey = name
                  .replace(/PRIMARY KEY\s?\(/gi, "")
                  .replace(")", "");

                //Create Primary Key
                var primaryKeyModel = this.CreatePrimaryKey(
                  primaryKey,
                  currentTableModel.Name
                );

                //Add Primary Key to List
                this.primaryKeyList.push(primaryKeyModel);
              } else {
                var startIndex = name.toLocaleLowerCase().indexOf("(");
                var endIndex = name.indexOf(")") + 1;
                var primaryKey = name
                  .substring(startIndex, endIndex)
                  .replace("(", "")
                  .replace(")", "")
                  .replace(/ASC/gi, "")
                  .trim();

                const columnQuantifiers = this.GetColumnQuantifiers();
                //Get delimiter of column name
                var firstSpaceIndex =
                  primaryKey[0] == columnQuantifiers.Start &&
                  primaryKey.indexOf(columnQuantifiers.End + " ") !== -1
                    ? primaryKey.indexOf(columnQuantifiers.End + " ")
                    : primaryKey.indexOf(" ");

                var primaryKeyRow =
                  firstSpaceIndex == -1
                    ? primaryKey
                    : primaryKey.substring(firstSpaceIndex + 1).trim();

                //Create Primary Key
                var primaryKeyModel = this.CreatePrimaryKey(
                  primaryKeyRow,
                  currentTableModel.Name
                );

                //Add Primary Key to List
                this.primaryKeyList.push(primaryKeyModel);
                /*
              while (end === 0) {
                var primaryKeyRow = lines[start].trim();

                if (primaryKeyRow.indexOf(")") !== -1) {
                  end = 1;
                  break;
                }

                start++;

                primaryKeyRow = primaryKeyRow.replace(/ASC/gi, "");

                //Parse name
                primaryKeyRow = this.ParseSQLServerName(primaryKeyRow, true);

                //Create Primary Key
                var primaryKeyModel = this.CreatePrimaryKey(
                  primaryKeyRow,
                  currentTableModel.Name
                );

                //Add Primary Key to List
                this.primaryKeyList.push(primaryKeyModel);
              }
              */
              }
            }
          }
        }
        //Parse Foreign Key
        if (
          propertyType.indexOf(Foreign_Key) != -1 ||
          propertyType.indexOf(CONSTRAINT_Foreign_Key) != -1
        ) {
          if (!this.MODE_SQLSERVER || propertyRow.indexOf(AlterTable) == -1) {
            this.ParseMySQLForeignKey(name, currentTableModel);
          } else {
            var completeRow = name;

            if (nameSkipCheck.indexOf("REFERENCES") === -1) {
              var referencesRow = lines[i + 1].trim();
              completeRow =
                "ALTER TABLE [dbo].[" +
                currentTableModel.Name +
                "]  WITH CHECK ADD" +
                " " +
                name +
                " " +
                referencesRow;
            }

            this.ParseSQLServerForeignKey(completeRow, currentTableModel);
          }
        }
      } else if (propertyRow.indexOf(AlterTable) != -1) {
        if (this.MODE_SQLSERVER) {
          //Parse the row
          var alterTableRow = tmp.substring(
            0,
            tmp.charAt(tmp.length - 1) === "," ? tmp.length - 1 : tmp.length
          );
          var referencesRow = lines[i + 1].trim();
          var completeRow = alterTableRow + " " + referencesRow;

          this.ParseSQLServerForeignKey(completeRow, currentTableModel);
        }
      }
    }
    // parse fk and primary keys
    if (this.primaryKeyList.length > 0) {
      this.primaryKeyList.forEach((pk) => {
        // find table index
        var pkTableIndex = this.tableList.findIndex(
          (t) => t.Name.toLocaleLowerCase() == pk.PrimaryKeyTableName.toLocaleLowerCase()
        );

        // find property index
        if (pkTableIndex > -1) {
          var propertyIndex = this.tableList[pkTableIndex].Properties.findIndex(
            (p) => p.Name.toLocaleLowerCase() == pk.PrimaryKeyName.toLocaleLowerCase()
          );
          if (propertyIndex > -1) {
            this.tableList[pkTableIndex].Properties[
              propertyIndex
            ].IsPrimaryKey = true;
          }
        }
      });
    }
    if (this.foreignKeyList.length > 0) {
      this.foreignKeyList.forEach((fk) => {
        // find table index
        var pkTableIndex = this.tableList.findIndex(
          (t) => t.Name.toLocaleLowerCase() == fk.ReferencesTableName.toLocaleLowerCase()
        );

        // var fkTableIndex = this.tableList.findIndex(
        //   (t) => t.Name == fk.PrimaryKeyTableName
        // );

        // find property index
        if (pkTableIndex > -1) {
          var propertyIndex = this.tableList[pkTableIndex].Properties.findIndex(
            (p) => p.Name.toLocaleLowerCase() == fk.PrimaryKeyName.toLocaleLowerCase()
          );
          if (propertyIndex > -1) {
            this.tableList[pkTableIndex].Properties[
              propertyIndex
            ].ForeignKey.push(fk);
            if (!fk.IsDestination) {
              this.tableList[pkTableIndex].Properties[
                propertyIndex
              ].IsForeignKey = true;
            }
          }
        }

        // if (fkTableIndex > -1) {
        //   var propertyIndex = this.tableList[fkTableIndex].Properties.findIndex(
        //     (p) => p.Name == fk.PrimaryKeyName
        //   );
        //   if (propertyIndex > -1) {
        //     this.tableList[fkTableIndex].Properties[propertyIndex].ForeignKey.push(fk)
        //   }
        // }
      });
    }

    return this;
  }

  private stringToRegex(str: string) {
    // Main regex
    const mainResult = str.match(/\/(.+)\/.*/);
    const optionsResult = str.match(/\/.+\/(.*)/);
    if (mainResult && optionsResult) {
      const main = mainResult[1];

      // Regex options
      const options = optionsResult[1];

      // Compiled regex
      return new RegExp(main, options);
    }
    return new RegExp("//(.+)/.*/", "//.+/(.*)/");
  }

  private CreatePrimaryKey(
    primaryKeyName: string,
    primaryKeyTableName: string
  ) {
    var primaryKey: PrimaryKeyModel = {
      PrimaryKeyTableName: primaryKeyTableName,
      PrimaryKeyName: this.RemoveNameQuantifiers(primaryKeyName),
    };

    return primaryKey;
  }

  private CreateProperty(
    name: string,
    tableName: string,
    foreignKey: ForeignKeyModel[] | null,
    isPrimaryKey: boolean,
    columnProps: string
  ) {
    var isForeignKey = foreignKey !== undefined && foreignKey !== null;
    var property: PropertyModel = {
      Name: name,
      ColumnProperties: columnProps,
      TableName: tableName,
      ForeignKey: foreignKey || [],
      IsForeignKey: isForeignKey,
      IsPrimaryKey: isPrimaryKey,
    };

    return property;
  }

  private ParseMySQLForeignKey(name: string, currentTableModel: TableModel) {
    var referencesIndex = name.toLowerCase().indexOf("references");
    var foreignKeySQL = name.substring(0, referencesIndex);
    var referencesSQL = name.substring(referencesIndex, name.length);

    //Remove references syntax
    referencesSQL = referencesSQL.replace(/REFERENCES /gi, "");

    //Get Table and Property Index
    var referencedTableIndex = referencesSQL.indexOf("(");
    var referencedPropertyIndex = referencesSQL.indexOf(")");

    //Get Referenced Table
    var referencedTableName = referencesSQL.substring(0, referencedTableIndex);

    //Get Referenced Key
    var referencedPropertyName = referencesSQL.substring(
      referencedTableIndex + 1,
      referencedPropertyIndex
    );

    //Get ForeignKey
    var foreignKey = foreignKeySQL
      .replace(/FOREIGN KEY\s?\(/gi, "")
      .replace(")", "")
      .replace(" ", "");

    //Create ForeignKey
    var foreignKeyOriginModel = this.CreateForeignKey(
      foreignKey,
      currentTableModel.Name,
      referencedPropertyName,
      referencedTableName,
      true
    );

    //Add ForeignKey Origin
    this.foreignKeyList.push(foreignKeyOriginModel);

    //Create ForeignKey
    var foreignKeyDestinationModel = this.CreateForeignKey(
      referencedPropertyName,
      referencedTableName,
      foreignKey,
      currentTableModel.Name,
      false
    );

    //Add ForeignKey Destination
    this.foreignKeyList.push(foreignKeyDestinationModel);
  }

  private ParseSQLServerForeignKey(
    name: string,
    currentTableModel: TableModel | null
  ) {
    var referencesIndex = name.toLowerCase().indexOf("references");

    if (name.toLowerCase().indexOf(`${Foreign_Key}(`) !== -1) {
      var foreignKeySQL = name
        .substring(
          name.toLowerCase().indexOf(`${Foreign_Key}(`),
          referencesIndex
        )
        .replace(/FOREIGN KEY\(/gi, "")
        .replace(")", "");
    } else {
      var foreignKeySQL = name
        .substring(
          name.toLowerCase().indexOf(`${Foreign_Key}(`),
          referencesIndex
        )
        .replace(/FOREIGN KEY\s?\(/gi, "")
        .replace(")", "");
    }

    var referencesSQL = name.substring(referencesIndex, name.length);
    const nameSkipCheck = name.toUpperCase().trim();
    var alterTableName = name
      .substring(0, nameSkipCheck.indexOf("WITH"))
      .replace(/ALTER TABLE /gi, "");

    if (
      referencesIndex !== -1 &&
      alterTableName !== "" &&
      foreignKeySQL !== "" &&
      referencesSQL !== ""
    ) {
      //Remove references syntax
      referencesSQL = referencesSQL.replace(/REFERENCES /gi, "");

      //Get Table and Property Index
      var referencedTableIndex = referencesSQL.indexOf("(");
      var referencedPropertyIndex = referencesSQL.indexOf(")");

      //Get Referenced Table
      var referencedTableName = referencesSQL.substring(
        0,
        referencedTableIndex
      );

      //Parse Name
      referencedTableName = this.ParseSQLServerName(referencedTableName);

      //Get Referenced Key
      var referencedPropertyName = referencesSQL.substring(
        referencedTableIndex + 1,
        referencedPropertyIndex
      );

      //Parse Name
      referencedPropertyName = this.ParseSQLServerName(referencedPropertyName);

      //Get ForeignKey
      var foreignKey = foreignKeySQL
        .replace(/FOREIGN KEY\s?\(/gi, "")
        .replace(")", "");

      //Parse Name
      foreignKey = this.ParseSQLServerName(foreignKey);

      //Parse Name
      alterTableName = this.ParseSQLServerName(alterTableName);

      //Create ForeignKey
      var foreignKeyOriginModel = this.CreateForeignKey(
        foreignKey,
        alterTableName,
        referencedPropertyName,
        referencedTableName,
        true
      );

      //Add ForeignKey Origin
      this.foreignKeyList.push(foreignKeyOriginModel);

      //Create ForeignKey
      var foreignKeyDestinationModel = this.CreateForeignKey(
        referencedPropertyName,
        referencedTableName,
        foreignKey,
        alterTableName,
        false
      );

      //Add ForeignKey Destination
      this.foreignKeyList.push(foreignKeyDestinationModel);
    }
  }

  private CreateForeignKey(
    primaryKeyName: string,
    primaryKeyTableName: string,
    referencesPropertyName: string,
    referencesTableName: string,
    isDestination: boolean
  ) {
    var foreignKey: ForeignKeyModel = {
      PrimaryKeyTableName: this.RemoveNameQuantifiers(primaryKeyTableName),
      PrimaryKeyName: this.RemoveNameQuantifiers(primaryKeyName),
      ReferencesPropertyName: this.RemoveNameQuantifiers(
        referencesPropertyName
      ),
      ReferencesTableName: this.RemoveNameQuantifiers(referencesTableName),
      IsDestination:
        isDestination !== undefined && isDestination !== null
          ? isDestination
          : false,
    };

    return foreignKey;
  }

  private RemoveNameQuantifiers(name: string) {
    return name.replace(/\[|\]|\(|\"|\'|\`/g, "").trim();
  }

  private ParseTableName(name: string) {
    if (name.charAt(name.length - 1) === "(") {
      name = this.RemoveNameQuantifiers(name);
      // if (!this.MODE_SQLSERVER) {
      //   name = name.substring(0, name.lastIndexOf(" "));
      // } else {
      //   name = this.ParseSQLServerName(name);
      // }
    }

    return name;
  }

  private ParseSQLServerName(name: string, property?: boolean) {
    name = name.replace("[dbo].[", "");
    name = name.replace("](", "");
    name = name.replace("].[", ".");
    name = name.replace("[", "");

    if (property == undefined || property == null) {
      name = name.replace(" [", "");
      name = name.replace("] ", "");
    } else {
      if (name.indexOf("]") !== -1) {
        name = name.substring(0, name.indexOf("]"));
      }
    }

    if (name.lastIndexOf("]") === name.length - 1) {
      name = name.substring(0, name.length - 1);
    }

    if (name.lastIndexOf(")") === name.length - 1) {
      name = name.substring(0, name.length - 1);
    }

    if (name.lastIndexOf("(") === name.length - 1) {
      name = name.substring(0, name.length - 1);
    }

    name = name.replace(" ", "");

    return name;
  }

  private CreateTable(name: string) {
    var table: TableModel = {
      Name: name,
      Properties: [],
    };

    //Count exported tables
    this.exportedTables++;

    return table;
  }

  /**
   * Checks whether character is a quotation character.
   *
   * @param char Character to be evaluated.
   */
  private static isQuoteChar(char: string): boolean {
    return char === '"' || char === "'" || char === "`";
  }
  /**
   * return text quantifiers for dialect
   * @returns json
   */
  GetColumnQuantifiers() {
    let chars: ColumnQuantifiers = {
      Start: '"',
      End: '"',
    };
    if (this.dialect == "mysql") {
      chars.Start = "`";
      chars.End = "`";
    } else if (this.dialect == "sqlserver") {
      chars.Start = "[";
      chars.End = "]";
    }
    return chars;
  }
  ToTableList() {
    return this.tableList;
  }
  ToPrimaryKeyList() {
    return this.primaryKeyList;
  }
  ToForeignKeyList() {
    return this.foreignKeyList;
  }
  ResetModel() {
    this.tableList = [];
    this.primaryKeyList = [];
    this.foreignKeyList = [];
    return this;
  }
  /**
   * return full sql model
   * @returns
   */
  ToModel(): DatabaseModel {
    return {
      TableList: this.tableList,
      Dialect: this.dialect,
      ForeignKeyList: this.foreignKeyList,
      PrimaryKeyList: this.primaryKeyList,
    };
  }
}
