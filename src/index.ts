import {
  DatabaseModel,
  ForeignKeyModel,
  PrimaryKeyModel,
  PropertyModel,
  TableModel,
} from "./types";

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
    var lines = chunk.split("\n"),
      dx = 0,
      tableCell = null,
      cells = [],
      exportedTables = 0,
      // tableList = [],
      foreignKeyList = [],
      rowCell = null;

    var currentTableModel = null;
    //Parse SQL to objects
    for (var i = 0; i < lines.length; i++) {
      rowCell = null;

      var tmp = lines[i].trim();

      var propertyRow = tmp.substring(0, 12).toLowerCase();

      //Parse Table
      if (propertyRow === "create table") {
        //Parse row
        var name = tmp.substring(12).trim();

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
        propertyRow !== "alter table "
      ) {
        //Parse the row
        var name = tmp.substring(
          0,
          tmp.charAt(tmp.length - 1) === "," ? tmp.length - 1 : tmp.length
        );

        //Attempt to get the Key Type
        var propertyType = name.substring(0, 11).toLowerCase();

        //Add special constraints
        if (this.MODE_SQLSERVER) {
          if (
            tmp.indexOf("CONSTRAINT") !== -1 &&
            tmp.indexOf("PRIMARY KEY") !== -1
          ) {
            propertyType = "constrain primary key";
          }

          if (
            tmp.indexOf("CONSTRAINT") !== -1 &&
            tmp.indexOf("FOREIGN KEY") !== -1
          ) {
            propertyType = "constrain foreign key";
          }
        }

        //Verify if this is a property that doesn't have a relationship (One minute of silence for the property)
        var normalProperty =
          propertyType !== "primary key" &&
          propertyType !== "foreign key" &&
          propertyType !== "constrain primary key" &&
          propertyType !== "constrain foreign key";

        //Parse properties that don't have relationships
        if (normalProperty) {
          if (name === "" || name === "" || name === ");") {
            continue;
          }

          if (this.MODE_SQLSERVER) {
            if (
              name.indexOf(" ASC") !== -1 ||
              name.indexOf(" DESC") !== -1 ||
              name.indexOf(" EXEC") !== -1 ||
              name.indexOf(" WITH") !== -1 ||
              name.indexOf(" ON") !== -1 ||
              name.indexOf(" ALTER") !== -1 ||
              name.indexOf("/*") !== -1 ||
              name.indexOf(" CONSTRAIN") !== -1 ||
              name.indexOf(" SET") !== -1 ||
              name.indexOf(" NONCLUSTERED") !== -1 ||
              name.indexOf(" GO") !== -1 ||
              name.indexOf(" REFERENCES") !== -1
            ) {
              continue;
            }
            //Get delimiter of column name
            var firstSpaceIndex = name.indexOf(" ");

            //Get full name
            name = name.substring(0, firstSpaceIndex);

            name = this.ParseSQLServerName(name, true);
          } else {
            //Get delimiter of column name
            var firstSpaceIndex = name.indexOf(" ");

            //Get full name
            name = name.substring(0, firstSpaceIndex);
          }

          //Create Property
          var propertyModel = this.CreateProperty(
            name,
            currentTableModel.Name,
            null,
            false
          );

          //Add Property to table
          currentTableModel.Properties.push(propertyModel);
        }

        //Parse Primary Key
        if (
          propertyType === "primary key" ||
          propertyType === "constrain primary key"
        ) {
          if (!this.MODE_SQLSERVER) {
            var primaryKey = name.replace("PRIMARY KEY (", "").replace(")", "");

            //Create Primary Key
            var primaryKeyModel = this.CreatePrimaryKey(
              primaryKey,
              currentTableModel.Name
            );

            //Add Primary Key to List
            this.primaryKeyList.push(primaryKeyModel);
          } else {
            var start = i + 2;
            var end = 0;
            if (
              name.indexOf("PRIMARY KEY") !== -1 &&
              name.indexOf("CLUSTERED") === -1
            ) {
              var primaryKey = name
                .replace("PRIMARY KEY (", "")
                .replace(")", "");

              //Create Primary Key
              var primaryKeyModel = this.CreatePrimaryKey(
                primaryKey,
                currentTableModel.Name
              );

              //Add Primary Key to List
              this.primaryKeyList.push(primaryKeyModel);
            } else {
              while (end === 0) {
                var primaryKeyRow = lines[start].trim();

                if (primaryKeyRow.indexOf(")") !== -1) {
                  end = 1;
                  break;
                }

                start++;

                primaryKeyRow = primaryKeyRow.replace("ASC", "");

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
            }
          }
        }
        debugger;
        //Parse Foreign Key
        if (
          propertyType === "foreign key" ||
          propertyType === "constrain foreign key"
        ) {
          if (!this.MODE_SQLSERVER) {
            this.ParseMySQLForeignKey(name, currentTableModel);
          } else {
            var completeRow = name;

            if (name.indexOf("REFERENCES") === -1) {
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
      } else if (propertyRow === "alter table ") {
        debugger;
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

    return this;
  }

  private CreatePrimaryKey(
    primaryKeyName: string,
    primaryKeyTableName: string
  ) {
    var primaryKey: PrimaryKeyModel = {
      PrimaryKeyTableName: primaryKeyTableName,
      PrimaryKeyName: primaryKeyName,
    };

    return primaryKey;
  }

  private CreateProperty(
    name: string,
    tableName: string,
    foreignKey: ForeignKeyModel[] | null,
    isPrimaryKey: boolean
  ) {
    var isForeignKey = foreignKey !== undefined && foreignKey !== null;
    var property: PropertyModel = {
      Name: name,
      TableName: tableName,
      ForeignKey: isForeignKey ? foreignKey : [],
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
    referencesSQL = referencesSQL.replace("REFERENCES ", "");

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
      .replace("FOREIGN KEY (", "")
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

    if (name.toLowerCase().indexOf("foreign key(") !== -1) {
      var foreignKeySQL = name
        .substring(name.toLowerCase().indexOf("foreign key("), referencesIndex)
        .replace("FOREIGN KEY(", "")
        .replace(")", "");
    } else {
      var foreignKeySQL = name
        .substring(name.toLowerCase().indexOf("foreign key ("), referencesIndex)
        .replace("FOREIGN KEY (", "")
        .replace(")", "");
    }

    var referencesSQL = name.substring(referencesIndex, name.length);
    var alterTableName = name
      .substring(0, name.indexOf("WITH"))
      .replace("ALTER TABLE ", "");

    if (
      referencesIndex !== -1 &&
      alterTableName !== "" &&
      foreignKeySQL !== "" &&
      referencesSQL !== ""
    ) {
      //Remove references syntax
      referencesSQL = referencesSQL.replace("REFERENCES ", "");

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
        .replace("FOREIGN KEY (", "")
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
      PrimaryKeyTableName: primaryKeyTableName,
      PrimaryKeyName: primaryKeyName,
      ReferencesPropertyName: referencesPropertyName,
      ReferencesTableName: referencesTableName,
      IsDestination:
        isDestination !== undefined && isDestination !== null
          ? isDestination
          : false,
    };

    return foreignKey;
  }

  private ParseTableName(name: string) {
    if (name.charAt(name.length - 1) === "(") {
      if (!this.MODE_SQLSERVER) {
        name = name.substring(0, name.lastIndexOf(" "));
      } else {
        name = this.ParseSQLServerName(name);
      }
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

  ToModel(): DatabaseModel {
    return {
      TableList: this.tableList,
      Dialect: this.dialect,
      ForeignKeyList: this.foreignKeyList,
      PrimaryKeyList: this.primaryKeyList
    };
  }
}
