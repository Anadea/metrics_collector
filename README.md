# MetricsCollector

MetricsCollector is a flexible ruby tool designed to collect different metrics from projects.
MetricsCollector automaticaly checks for all required libraries and installs them if you miss anything.
Apart from getting an output at the console you can also download the results in json or csv.
Currently MetricsCollector supports only cloc, brakeman, rubycritic and simplecov. Feel free to contribute.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add metrics_collector

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install metrics_collector

## Usage

Run this rake task after installing gem into your project

    $ rake collect_metrics

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MetricsCollector project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/MetricsCollector/blob/master/CODE_OF_CONDUCT.md).
