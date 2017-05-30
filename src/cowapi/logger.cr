module Cowapi
  # TODO: add support for file logging in addition to STDOUT
  # See crystal.lager (maybe I need to just re-write that old lib of mine?)
  FORMATTER = Logger::Formatter.new do |severity, datetime, progname, message, io|
    case severity
    when "INFO"
      color = "\e[32m"
    when "WARN"
      color = "\e[93m"
    when "ERROR", "FATAL"
      color = "\e[31m"
    end
    resetColor = "\e[0m"

    severity = "[" + severity + "]"

    io << color << severity.rjust(7) << resetColor << " [" << progname
    io << " #" << Process.pid << "]: " << message
  end

  LOG = Logger.new(STDOUT)
  LOG.level = Logger::Severity::DEBUG
  LOG.formatter = FORMATTER
end
