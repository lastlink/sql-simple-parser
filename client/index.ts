// sqlsimpleparser client
import { SqlSimpleParser } from "../src";

interface Window {
    sqlsimpleparser: SqlSimpleParser;
}

declare let window: Window;
window.sqlsimpleparser = new SqlSimpleParser;