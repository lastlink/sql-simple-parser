# sql-simple-parser
sql ddl parser to support extensions for drawio

## Getting started
* how to use:
```typescript
import { SqlSimpleParser } from "@funktechno/sqlsimpleparser"

var sql = `CREATE TABLE "humanresources_department" (
	"departmentid" serial NOT NULL,
	"name" Name NOT NULL,
	"groupname" Name NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("departmentid")
);`

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
					"ForeignKey": [],
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
		}
	],
	"Dialect": "sqlserver",
	"ForeignKeyList": [],
	"PrimaryKeyList": [
		{
			"PrimaryKeyTableName": "humanresources_department",
			"PrimaryKeyName": "departmentid"
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
