require 'json'
require 'csv'
require_relative 'version'
require_relative 'resolver'
require_relative 'reports_handler.rb'
require_relative 'gem_handlers/BrakemanHandler.rb'
require_relative 'gem_handlers/ClocHandler.rb'
require_relative 'gem_handlers/RubycriticHandler.rb'
require_relative 'gem_handlers/SimplecovHandler.rb'
require_relative 'report_generators/ConsoleGenerator.rb'
require_relative 'report_generators/JsonGenerator.rb'
require_relative 'report_generators/CsvGenerator.rb'

module SupportedLibs
  SUPPORTED_LIBRARIES = "cloc brakeman simplecov rubycritic"
end

module SupportedOutput
  SUPPORTED_OUTPUT = "csv json console"
end
