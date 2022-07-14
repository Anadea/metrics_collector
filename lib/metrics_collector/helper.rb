require 'json'
require 'csv'
require_relative 'version'
require_relative 'reports_handler'

module SupportedLibs
  SUPPORTED_LIBRARIES = ['cloc', 'brakeman', 'simplecov', 'rubycritic']
end

module SupportedOutput
  SUPPORTED_OUTPUT = ['csv', 'json', 'console']
end
