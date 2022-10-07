import * as fs from "fs";
import {SqlSimpleParser} from "../src/index"

describe("Example Sqlite", () => {
  it("Run Parser", async () => {
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
      await fs.writeFileSync("sqliteOutput.json", JSON.stringify(models));
    }
    await runSample();
    expect(1).toBeTruthy();
  });
});
