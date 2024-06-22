# sql-simple-parser
sql ddl parser to support extensions for drawio

## Getting started
* `npm install --save @funktechno/sqlsimpleparser`
* how to use:
```typescript
import { SqlSimpleParser } from "@funktechno/sqlsimpleparser"

var sql = `CREATE TABLE "humanresources_department" (
	"departmentid" serial NOT NULL,
	"name" Name NOT NULL,
	"groupname" Name NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("departmentid")
);

CREATE TABLE "humanresources_employeedepartmenthistory" (
  "businessentityid" int(4) NOT NULL,
  "departmentid" int(2) NOT NULL,
  "shiftid" int(2) NOT NULL,
  "startdate" date NOT NULL,
  "enddate" date,
  "modifieddate" timestamp NOT NULL,
  PRIMARY KEY("businessentityid","departmentid","shiftid","startdate"),
  FOREIGN KEY ("departmentid") REFERENCES "humanresources_department"("departmentid")
);
`

// run parser
const parser = new SqlSimpleParser('postgres')

// get models
const models = parser
  .feed(sql)
  .ToModel();
```
* outputs
```json
{
  "TableList": [
    {
      "Name": "humanresources_department",
      "Properties": [
        {
          "Name": "departmentid",
          "ColumnProperties": "serial NOT NULL",
          "TableName": "humanresources_department",
          "ForeignKey": [
            {
              "PrimaryKeyTableName": "humanresources_employeedepartmenthistory",
              "PrimaryKeyName": "departmentid",
              "ReferencesPropertyName": "departmentid",
              "ReferencesTableName": "humanresources_department",
              "IsDestination": true
            }
          ],
          "IsForeignKey": false,
          "IsPrimaryKey": true
        },
        {
          "Name": "name",
          "ColumnProperties": "Name NOT NULL",
          "TableName": "humanresources_department",
          "ForeignKey": [],
          "IsForeignKey": false,
          "IsPrimaryKey": false
        },
        {
          "Name": "groupname",
          "ColumnProperties": "Name NOT NULL",
          "TableName": "humanresources_department",
          "ForeignKey": [],
          "IsForeignKey": false,
          "IsPrimaryKey": false
        },
        {
          "Name": "modifieddate",
          "ColumnProperties": "timestamp NOT NULL",
          "TableName": "humanresources_department",
          "ForeignKey": [],
          "IsForeignKey": false,
          "IsPrimaryKey": false
        }
      ]
    },
    {
      "Name": "humanresources_employeedepartmenthistory",
      "Properties": [
        {
          "Name": "businessentityid",
          "ColumnProperties": "int(4) NOT NULL",
          "TableName": "humanresources_employeedepartmenthistory",
          "ForeignKey": [],
          "IsForeignKey": false,
          "IsPrimaryKey": true
        },
        {
          "Name": "departmentid",
          "ColumnProperties": "int(2) NOT NULL",
          "TableName": "humanresources_employeedepartmenthistory",
          "ForeignKey": [
            {
              "PrimaryKeyTableName": "humanresources_department",
              "PrimaryKeyName": "departmentid",
              "ReferencesPropertyName": "departmentid",
              "ReferencesTableName": "humanresources_employeedepartmenthistory",
              "IsDestination": false
            }
          ],
          "IsForeignKey": true,
          "IsPrimaryKey": true
        },
        {
          "Name": "shiftid",
          "ColumnProperties": "int(2) NOT NULL",
          "TableName": "humanresources_employeedepartmenthistory",
          "ForeignKey": [],
          "IsForeignKey": false,
          "IsPrimaryKey": true
        },
        {
          "Name": "startdate",
          "ColumnProperties": "date NOT NULL",
          "TableName": "humanresources_employeedepartmenthistory",
          "ForeignKey": [],
          "IsForeignKey": false,
          "IsPrimaryKey": true
        },
        {
          "Name": "enddate",
          "ColumnProperties": "date",
          "TableName": "humanresources_employeedepartmenthistory",
          "ForeignKey": [],
          "IsForeignKey": false,
          "IsPrimaryKey": false
        },
        {
          "Name": "modifieddate",
          "ColumnProperties": "timestamp NOT NULL",
          "TableName": "humanresources_employeedepartmenthistory",
          "ForeignKey": [],
          "IsForeignKey": false,
          "IsPrimaryKey": false
        }
      ]
    }
  ],
  "Dialect": "postgres",
  "ForeignKeyList": [
    {
      "PrimaryKeyTableName": "humanresources_employeedepartmenthistory",
      "PrimaryKeyName": "departmentid",
      "ReferencesPropertyName": "departmentid",
      "ReferencesTableName": "humanresources_department",
      "IsDestination": true
    },
    {
      "PrimaryKeyTableName": "humanresources_department",
      "PrimaryKeyName": "departmentid",
      "ReferencesPropertyName": "departmentid",
      "ReferencesTableName": "humanresources_employeedepartmenthistory",
      "IsDestination": false
    }
  ],
  "PrimaryKeyList": [
    {
      "PrimaryKeyTableName": "humanresources_department",
      "PrimaryKeyName": "departmentid"
    },
    {
      "PrimaryKeyTableName": "humanresources_employeedepartmenthistory",
      "PrimaryKeyName": "businessentityid"
    },
    {
      "PrimaryKeyTableName": "humanresources_employeedepartmenthistory",
      "PrimaryKeyName": "departmentid"
    },
    {
      "PrimaryKeyTableName": "humanresources_employeedepartmenthistory",
      "PrimaryKeyName": "shiftid"
    },
    {
      "PrimaryKeyTableName": "humanresources_employeedepartmenthistory",
      "PrimaryKeyName": "startdate"
    }
  ]
}
```
* there are some [example](./examples) sql files
* see test `examples_models.spec` for more use cases

## Supported
* Databases: sqlite, postgres, sqlserver, mysql
* table names, primary keys, foreign keys, column names with extended column information

## Development
* `npm install`
* `npm test` or use vscode debugger **Jest single run**

## Deploy
* `npm publish --access public`
* Testing
  * `npm pack`