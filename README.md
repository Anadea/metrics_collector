# MetricsCollector

MetricsCollector is a gem for Ruby on Rails designed to collect different metrics from projects,
it provides commands to collect metrics from cloc, brakeman, rubycritic and simplecov.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add metrics_collector

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install metrics_collector

## Usage

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

- ### Supported libraries

```sh
cloc brakeman rubycritic simplecov
```

- ### Supported output formats

```sh
console csv json
```


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MetricsCollector project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/MetricsCollector/blob/master/CODE_OF_CONDUCT.md).
