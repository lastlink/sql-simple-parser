/**
 * Main Parser class
 */
export class SqlSimpleParser {
  private dialect: string;
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
  }
  /**
   * Feed chunk of string into parser.
   *
   * @param chunk Chunk of string to be parsed.
   */
  feed(chunk: string): SqlSimpleParser {
    //
    return this;
  }

  ToModel(): any {
    return {}
  }
}
