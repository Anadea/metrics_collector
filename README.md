[![GitHub version](https://badge.fury.io/gh/Anadea%2Fmetrics_collector.svg)](https://badge.fury.io/gh/Anadea%2Fmetrics_collector)

# MetricsCollector

MetricsCollector is a gem for Ruby on Rails designed to collect different metrics from projects,
it provides commands to collect metrics from cloc, brakeman, rubycritic and simplecov.

* [Requirements](#requirements)
* [Installation](#installation)
* [Usage](#usage)
* [Slack](#slack)
* [Configuration](#configuration)
* [Changelog](#changelog)
* [License](#license)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add metrics_collector

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install metrics_collector

## Requirements
* Ruby 2.4+

## Usage

Command Line Flag         | Description
--------------------------|----------------------------------------------------
`-l`/`--libraries`        | Specify which libraries you specifically want to run to collect metrics
`-o`/`--outputs`          | Write output to a specific file formats (see [Supported libraries/outputs](#Supported-libraries/outputs))
`-sl`/`--slack`           | Send metrics to slack channel (see [Slack](#slack))
`-h`/`--help`             | Show command line flag documentation
`-v`/`--version`          | Show version

- ### Collect all metrics and get output in json, csv and console

    ```sh
    bundle exec metrics_collector
    ```

- ### Get only certain metrics

    Pass libraries as a first arguments

    ```sh
    bundle exec metrics_collector -l cloc,rubycritic
    ```
- ### Different output options

    To get this metrics only in json/csv/console type


    ```sh
    bundle exec metrics_collector -o console,csv
    ```

## Supported libraries/outputs

**Supported libraries**

* [Cloc](https://github.com/AlDanial/cloc)
* [Brakeman](https://github.com/presidentbeef/brakeman)
* [Rubycritic](https://github.com/whitesmith/rubycritic)
* [Simplecov](https://github.com/simplecov-ruby/simplecov)

**Supported output formats**

```sh
console csv json
```

## Slack
**Send outputs to slack channel(s)**
```sh
bundle exec metrics_collector --slack xoxp-slack-user-oath-token,CHANNELID2,CHANNELID8
```

## Changelog

If you're interested in seeing the changes between each version
of `metrics_collector`, read the [MetricsCollector Changelog](CHANGELOG.md).

## Code of Conduct

Everyone interacting in the MetricsCollector project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/MetricsCollector/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
