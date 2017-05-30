# Copyright (C) 2017 - Andrew Zah (github.com/azah)

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
