import * as fs from "fs";
import {SqlSimpleParser} from "../src/index"

describe("Example Sql Parsing", () => {
  it("Run Parser Sqlite Ex", async () => {
    const filePath = "examples/chinook-database-2.0.1_sqlite.sql";
    async function runSample() {
      // load sql
      var sql = await fs.readFileSync(filePath, "utf8");
      console.log(sql);

      // run parser
      const parser = new SqlSimpleParser('sqlite')

      // get models
      const models = parser
        .feed(sql)
        .ToModel();

      // write to json file
      await fs.writeFileSync("output-sqlite.json", JSON.stringify(models, null, '\t'));
    }
    await runSample();
    expect(1).toBeTruthy();
  });
  it("Run Parser mysql Ex", async () => {
    const filePath = "examples/adventureworks_mysql.sql";
    async function runSample() {
      // load sql
      var sql = await fs.readFileSync(filePath, "utf8");
      console.log(sql);

      // run parser
      const parser = new SqlSimpleParser('mysql')

      // get models
      const models = parser
        .feed(sql)
        .ToModel();

      // write to json file
      await fs.writeFileSync("output-mysql.json", JSON.stringify(models, null, '\t'));
    }
    await runSample();
    expect(1).toBeTruthy();
  });
  it("Run Parser postgres Ex", async () => {
    const filePath = "examples/adventureworks_pg.sql";
    async function runSample() {
      // load sql
      var sql = await fs.readFileSync(filePath, "utf8");
      console.log(sql);

      // run parser
      const parser = new SqlSimpleParser('postgres')

      // get models
      const models = parser
        .feed(sql)
        .ToModel();

      // write to json file
      await fs.writeFileSync("output-pg.json", JSON.stringify(models, null, '\t'));
    }
    await runSample();
    expect(1).toBeTruthy();
  });
  it("Run Parser postgres Ex", async () => {
    const filePath = "examples/adventureworks_mssql.sql";
    async function runSample() {
      // load sql
      var sql = await fs.readFileSync(filePath, "utf8");
      console.log(sql);

      // run parser
      const parser = new SqlSimpleParser('sqlserver')

      // get models
      const models = parser
        .feed(sql)
        .ToModel();

      // write to json file
      await fs.writeFileSync("output-mssql.json", JSON.stringify(models, null, '\t'));
    }
    await runSample();
    expect(1).toBeTruthy();
  });
});
