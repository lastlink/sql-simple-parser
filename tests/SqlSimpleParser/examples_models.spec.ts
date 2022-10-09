import * as fs from "fs";
import { SqlSimpleParser } from "../../src/index";
import { getExpected, updateExpected } from "../utils/helper";
const dataSource = "ToModel";
describe("Example Sql Parsing", () => {
  it("Run Parser Sqlite Ex", async () => {
    const filePath = "examples/chinook-database-2.0.1_sqlite.sql";
    // load sql
    var sql = await fs.readFileSync(filePath, "utf8");
    // console.log(sql);

    // run parser
    const parser = new SqlSimpleParser("sqlite");

    // get models
    const result = parser.feed(sql).ToModel();

    // write to json file
    const dataKey = expect.getState().currentTestName || "unknown";

    const expectedResult = await getExpected(dataSource, dataKey);

    if (result != expectedResult) {
      await updateExpected(dataSource, dataKey, result);
    }

    // console.log(result);
    expect(result).toStrictEqual(expectedResult);
    // await fs.writeFileSync(
    //   "output-sqlite.json",
    //   JSON.stringify(models, null, "\t")
    // );

    expect(1).toBeTruthy();
  });
  it("Run Parser mysql Ex", async () => {
    const filePath = "examples/adventureworks_mysql.sql";
    // load sql
    var sql = await fs.readFileSync(filePath, "utf8");
    // console.log(sql);

    // run parser
    const parser = new SqlSimpleParser("mysql");

    // get models
    const result = parser.feed(sql).ToModel();

    // write to json file
    const dataKey = expect.getState().currentTestName || "unknown";

    const expectedResult = await getExpected(dataSource, dataKey);

    if (result != expectedResult) {
      await updateExpected(dataSource, dataKey, result);
    }

    // console.log(result);
    expect(result).toStrictEqual(expectedResult);

    // write to json file
    // await fs.writeFileSync(
    //   "output-mysql.json",
    //   JSON.stringify(models, null, "\t")
    // );
    expect(1).toBeTruthy();
  });
  it("Run Parser postgres Ex", async () => {
    const filePath = "examples/adventureworks_pg.sql";
    // load sql
    var sql = await fs.readFileSync(filePath, "utf8");
    // console.log(sql);

    // run parser
    const parser = new SqlSimpleParser("postgres");

    // get models
    const result = parser.feed(sql).ToModel();

    // write to json file
    const dataKey = expect.getState().currentTestName || "unknown";

    const expectedResult = await getExpected(dataSource, dataKey);

    if (result != expectedResult) {
      await updateExpected(dataSource, dataKey, result);
    }

    // console.log(result);
    expect(result).toStrictEqual(expectedResult);

    // write to json file
    // await fs.writeFileSync(
    //   "output-pg.json",
    //   JSON.stringify(models, null, "\t")
    // );
    expect(1).toBeTruthy();
  });
  it("Run Parser sqlserver Ex", async () => {
    const filePath = "examples/adventureworks_mssql.sql";
    // load sql
    var sql = await fs.readFileSync(filePath, "utf8");
    // console.log(sql);

    // run parser
    const parser = new SqlSimpleParser("sqlserver");

    // get models
    const result = parser.feed(sql).ToModel();

    // write to json file
    const dataKey = expect.getState().currentTestName || "unknown";

    const expectedResult = await getExpected(dataSource, dataKey);

    if (result != expectedResult) {
      await updateExpected(dataSource, dataKey, result);
    }

    // console.log(result);
    expect(result).toStrictEqual(expectedResult);

    // write to json file
    // await fs.writeFileSync(
    //   "output-mssql.json",
    //   JSON.stringify(models, null, "\t")
    // );
    expect(1).toBeTruthy();
  });

  it("Run Parser mssql simple", async () => {
    // load sql
    var sql = `CREATE TABLE Persons
    (
        PersonID int NOT NULL,
        LastName varchar(255),
        FirstName varchar(255),
        Address varchar(255),
        City varchar(255),
        Primary Key(PersonId)
    );
    
    CREATE TABLE Orders
    (
        OrderID int NOT NULL PRIMARY KEY,
        PersonID int NOT NULL,
        FOREIGN KEY ([PersonID]) REFERENCES [Persons]([PersonID])
    );`;
    // console.log(sql);

    // run parser
    const parser = new SqlSimpleParser("sqlserver");

    // get models
    const result = parser.feed(sql).WithEnds().ToModel();

    // write to json file
    const dataKey = expect.getState().currentTestName || "unknown";

    const expectedResult = await getExpected(dataSource, dataKey);

    if (result != expectedResult) {
      await updateExpected(dataSource, dataKey, result);
    }

    // console.log(result);
    expect(result).toStrictEqual(expectedResult);

    // write to json file
    // await fs.writeFileSync(
    //   "output-pg_simple.json",
    //   JSON.stringify(models, null, "\t")
    // );
    expect(1).toBeTruthy();
  });

  it("Run Parser postgres simple", async () => {
    // load sql
    var sql = `CREATE TABLE "humanresources_department" (
        "departmentid" serial NOT NULL,
        "name" Name NOT NULL,
        "groupname" Name NOT NULL,
        "modifieddate" timestamp NOT NULL,
        PRIMARY KEY("departmentid")
      );`;
    // console.log(sql);

    // run parser
    const parser = new SqlSimpleParser("postgres");

    // get models
    const result = parser.feed(sql).WithEnds().WithoutEnds().ToModel();

    // write to json file
    const dataKey = expect.getState().currentTestName || "unknown";

    const expectedResult = await getExpected(dataSource, dataKey);

    if (result != expectedResult) {
      await updateExpected(dataSource, dataKey, result);
    }

    // console.log(result);
    expect(result).toStrictEqual(expectedResult);

    // write to json file
    // await fs.writeFileSync(
    //   "output-pg_simple.json",
    //   JSON.stringify(models, null, "\t")
    // );
    expect(1).toBeTruthy();
  });
});
