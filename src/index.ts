import { DbEntity } from "./types";

/**
 * Main Parser class
 */
export class SqlSimpleParser {
  private dialect: string;
  private entities: DbEntity[] = [];

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
  }
  /**
   * Feed chunk of string into parser.
   *
   * @param chunk Chunk of string to be parsed.
   */
  feed(chunk: string): SqlSimpleParser {
    //
    let i;
    let char;
    let parsed = "";
    let lastStatementIndex = 0;

    for (i = 0; i < chunk.length; i += 1) {
      char = chunk[i];
      parsed += char;

      if (char === "\\") {
        this.escaped = !this.escaped;
      } else {
        if (!this.escaped && SqlSimpleParser.isQuoteChar(char)) {
          if (this.quoted) {
            if (this.quoted === char) {
              this.quoted = "";
            }
          } else {
            this.quoted = char;
          }
        } else if (char === ";" && !this.quoted) {
          const statement =
            this.remains + parsed.substr(lastStatementIndex, i + 1);
          this.statements.push(statement);
          this.remains = "";
          lastStatementIndex = i + 1;
        }

        this.escaped = false;
      }
    }

    this.remains += parsed.substr(lastStatementIndex);
    return this;
  }

  /**
   * Checks whether character is a quotation character.
   *
   * @param char Character to be evaluated.
   */
  private static isQuoteChar(char: string): boolean {
    return char === '"' || char === "'" || char === "`";
  }

  ToModel(): any {
    return {};
  }
}
