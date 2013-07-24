A Nagios/Icinga plugin to check http header for text.

# Background

This code is based on an existing Nagios plugin: http://exchange.nagios.org/directory/Plugins/Websites,-Forms-and-Transactions/check_http_header/details

# Installation

## As file

```
gem install excon
cp check_http_header.rb /usr/lib/nagios/plugins
```

## As Debian package

1. package `excon` as Debian package (use https://github.com/jordansissel/fpm)
1. `dpkg-buildpackage -b`

# Want to improve this?

Send me your changes via pull-request.

# License

GPLv3

# Authors

- Sven Mueller
