# frozen_string_literal: true

require_relative "lib/metrics_collector/version"

Gem::Specification.new do |spec|
  spec.name                     = 'metrics_collector'
  spec.version                  = MetricsCollector::VERSION
  spec.authors                  = %w[dgb eum]
  spec.email                    = ['dgb@anadeainc.com']

  spec.summary                  = 'Metrics Collector.'
  spec.description              = 'RoR tool to collect metrics from project.'
  spec.homepage                 = 'http://anadea.info'
  spec.license                  = 'MIT'
  spec.required_ruby_version    = '>= 2.6.0'
  spec.metadata['homepage_uri'] = spec.homepage

  # spec.metadata['allowed_push_host'] = 'TODO: Set to your gem server 'https://example.com''
  # spec.metadata['source_code_uri'] = 'TODO: Put your gem's public repo URL here.'
  # spec.metadata['changelog_uri'] = 'TODO: Put your gem's CHANGELOG.md URL here.'

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split('\x0').reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'brakeman'
  spec.add_dependency 'rubycritic'
  spec.add_dependency 'simplecov'
end
