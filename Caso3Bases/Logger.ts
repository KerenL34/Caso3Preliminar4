export class Logger {
  private logs: string[];

  constructor() {
    this.logs = [];
  }

  public log(message: string): void {
    const logMessage = `[INFO] ${message}`;
    this.logs.push(logMessage);
    console.log(logMessage);
  }

  public error(message: string): void {
    const errorMessage = `[ERROR] ${message}`;
    this.logs.push(errorMessage);
    console.error(errorMessage);
  }

  public getLogs(): string[] {
    return this.logs;
  }
}
