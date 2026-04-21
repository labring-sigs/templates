# Logstash

Logstash is part of the [Elastic Stack](https://www.elastic.co/products) along with Beats, Elasticsearch and Kibana. Logstash is a server-side data processing pipeline that ingests data from a multitude of sources simultaneously, transforms it, and then sends it to your favorite "stash." (Ours is Elasticsearch, naturally.). Logstash has over 200 plugins, and you can write your own very easily as well.

For more info, see <https://www.elastic.co/products/logstash>

## Documentation and Getting Started

You can find the documentation and getting started guides for Logstash on the [elastic.co site](https://www.elastic.co/guide/en/logstash/current/getting-started-with-logstash.html)

For information about building the documentation, see the README in <https://github.com/elastic/docs>

## Downloads

You can download officially released Logstash binaries, as well as debian/rpm packages for the supported platforms, from the [downloads page](https://www.elastic.co/downloads/logstash).

## Need Help?

- [Logstash Forum](https://discuss.elastic.co/c/logstash)
- [Logstash Documentation](https://www.elastic.co/guide/en/logstash/current/index.html)
- [Logstash Product Information](https://www.elastic.co/products/logstash)
- [Elastic Support](https://www.elastic.co/subscriptions)

## Logstash Plugins

Logstash plugins are hosted in separate repositories under the [logstash-plugins](https://github.com/logstash-plugins) GitHub organization. Each plugin is a self-contained Ruby gem which gets published to RubyGems.org.

### Writing Your Own Plugin

Logstash is known for its extensibility. There are hundreds of plugins for Logstash and you can write your own very easily. For more info on developing and testing these plugins, please see the [working with plugins section](https://www.elastic.co/guide/en/logstash/current/contributing-to-logstash.html).

### Plugin Issues and Pull Requests

Please open new issues and pull requests for plugins under their own repository.

For example, if you have to report an issue or enhancement for the Elasticsearch output, please do so [here](https://github.com/logstash-plugins/logstash-output-elasticsearch/issues).

Logstash core will continue to exist under this repository and all related issues and pull requests can be submitted there.

## Developing Logstash Core

### Prerequisites

- Install JDK version 21. Make sure to set the `JAVA_HOME` environment variable to the path to your JDK installation directory. For example `set JAVA_HOME=<JDK_PATH>`.
- Install JRuby 10.0.5.0. It is recommended to use a Ruby version manager such as [RVM](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv).
- Install `rake` and `bundler` using `gem install rake` and `gem install bundler`.

### Verify the Installation

To verify your environment, run the following to start Logstash and send your first event:

```sh
bin/logstash -e 'input { stdin { } } output { stdout {} }'
```

This should start Logstash with stdin input waiting for you to enter an event:

```text
hello world
2016-11-11T01:22:14.405+0000 0.0.0.0 hello world
```

## Testing

Most of the unit tests in Logstash are written using [rspec](http://rspec.info/) for the Ruby parts. For the Java parts, Logstash uses [junit](https://junit.org). For testing you can use the `rake` tasks and the `bin/rspec` command.

### Core Tests

1. Run the core tests with:

```sh
./gradlew test
```

2. Run Java-only tests with:

```sh
./gradlew javaTests
```

3. Execute the full suite including integration tests with:

```sh
./gradlew check
```

### Plugin Tests

To run the tests of all currently installed plugins:

```sh
rake test:plugins
```

To install the default set of plugins included in the Logstash package:

```sh
rake test:install-default
```

## Building Artifacts

Built artifacts are placed in the `LS_HOME/build` directory. You can build snapshot packages as tarball or zip:

```sh
./gradlew assembleTarDistribution
./gradlew assembleZipDistribution
```

OSS-only artifacts can be built with:

```sh
./gradlew assembleOssTarDistribution
./gradlew assembleOssZipDistribution
```

## Contributing

All contributions are welcome: ideas, patches, documentation, bug reports, complaints, and even something you drew up on a napkin.

For more information about contributing, see the [CONTRIBUTING](https://github.com/elastic/logstash/blob/main/CONTRIBUTING.md) file.
