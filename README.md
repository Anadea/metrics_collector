[![GitHub version](https://badge.fury.io/gh/Anadea%2Fmetrics_collector.svg)](https://badge.fury.io/gh/Anadea%2Fmetrics_collector)

<p align="center">
  <img src="https://raw.githubusercontent.com/Anadea/metrics_collector/master/logo/MetricsCollector.png" width="60%" alt="MetricsCollector Logo"/>
</p>

# MetricsCollector

MetricsCollector is a gem for Ruby on Rails designed to collect different metrics from projects,
it provides commands to collect metrics from cloc, brakeman, rubycritic and simplecov.

* [Requirements](#requirements)
* [Installation](#installation)
* [Usage](#usage)
* [Slack](#slack)
* [Google Spreadsheet](#Spreadsheets)
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
`-o`/`--outputs`          | Write output to a specific file formats (see [Supported libraries/outputs](#Supported_libraries/outputs))
`-sl`/`--slack`           | Send metrics to slack channel (see [Slack](#slack))
`-sp`/`--spreadsheet`     | Send metrics to google spreadsheet document (see [Spreadsheets](#spreadsheets))
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

* CSV
* JSON
* Slack channel(s)
* Google Spreadsheets
* Console

## Slack
**Send outputs to slack channel(s)**
```sh
bundle exec metrics_collector --slack xoxp-slack-user-oath-token,CHANNELID2,CHANNELID8
```

## Spreadsheets
**Send outputs to google spreadsheet document**

Pass spreadsheet id and service account's details as an arguments
```sh
bundle exec metrics_collector --spreadsheet spredsheet_id,credentials_path
```

You can also configure client secret in .metrics_collector.yml

```yaml
google_spreadsheet:
  spreadsheet_id: spreadsheet_id
  client_secret:
    type: ''
    project_id: ''
    private_key_id: ''
    ...
```

## Changelog

If you're interested in seeing the changes between each version
of `metrics_collector`, read the [MetricsCollector Changelog](CHANGELOG.md).

## Code of Conduct

Everyone interacting in the MetricsCollector project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/MetricsCollector/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Article

Check out our [article](https://anadea.info/blog/metrics-collector) about the process of creation of MetricsCollector.
