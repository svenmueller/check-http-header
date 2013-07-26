A Nagios/Icinga plugin to check http header for text.

# Background

This code is based on an existing Nagios plugin: http://exchange.nagios.org/directory/Plugins/Websites,-Forms-and-Transactions/check_http_header/details

# Installation (Ubuntu 12.04)

## As file

```
$ apt-get install libwww-curl-perl # install required libs
$ cp check_http_header.pl /usr/lib/nagios/plugins # copy file to nagios plugin folder
```

## As Debian package

```
$ dpkg-checkbuilddeps # check
$ apt-get install build-essential debhelper libwww-curl-perl # install required libs
$ dpkg-buildpackage -b -uc -us # build debian package
```

# Example

```
$ sudo /usr/bin/perl /usr/lib/nagios/plugins/check_http_header.pl -I 'www.domain.de'  -u '/' -r 'Content-Type: text/html;charset=UTF-8' -p 443
```

# Want to improve this?

Send me your changes via pull-request.

# License

GPLv2

# Authors

- Sven Mueller
