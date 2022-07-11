require 'json'
require 'csv'
require_relative 'version'
require_relative 'resolver'
require_relative 'reports_handler'
require_relative 'gem_handlers/BrakemanHandler'
require_relative 'gem_handlers/ClocHandler'
require_relative 'gem_handlers/RubycriticHandler'
require_relative 'gem_handlers/SimplecovHandler'
require_relative 'report_generators/ConsoleGenerator'
require_relative 'report_generators/JsonGenerator'
require_relative 'report_generators/CsvGenerator'
require_relative 'report_generators/SlackNotifier'

module SupportedLibs
  SUPPORTED_LIBRARIES = ['cloc', 'brakeman', 'simplecov', 'rubycritic']
end

module SupportedOutput
  SUPPORTED_OUTPUT = ['csv', 'json', 'console']
end
