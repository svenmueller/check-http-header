#!/usr/bin/perl -w

use strict;
use warnings;
use WWW::Curl::Easy;
use Getopt::Std;

my $plugin_name = 'check_http_header';
my $VERSION             = '0.0.3';

# getopt module config
$Getopt::Std::STANDARD_HELP_VERSION = 1;

# nagios exit codes
use constant EXIT_OK            => 0;
use constant EXIT_WARNING       => 1;
use constant EXIT_CRITICAL      => 2;
use constant EXIT_UNKNOWN       => 3;

# parse cmd opts
my %opts;
getopts('vI:u:t:r:p:', \%opts);
$opts{t} = 60 unless (defined $opts{t});
$opts{u} = "/" unless (defined $opts{u});

if (not (defined $opts{I} and defined $opts{r})) {
        print "ERROR: INVALID USAGE\n";
        HELP_MESSAGE();
        exit EXIT_CRITICAL;
}


      # Setting the options
        my $curl = new WWW::Curl::Easy;
        
        $curl->setopt(CURLOPT_HEADER,1);
	    $curl->setopt(CURLOPT_NOBODY,1);
	    $curl->setopt(CURLOPT_TIMEOUT,$opts{t});
        # ignore all ssl error by default
        $curl->setopt(CURLOPT_SSL_VERIFYHOST, 0);
        $curl->setopt(CURLOPT_SSL_VERIFYPEER, 0);

        $curl->setopt(CURLOPT_URL, "$opts{I}:$opts{p}$opts{u}");

        my $response_body;

        # NOTE - do not use a typeglob here. A reference to a typeglob is okay though.
        open (my $fileb, ">", \$response_body);
        $curl->setopt(CURLOPT_WRITEDATA,$fileb);

        # Starts the actual request
        my $retcode = $curl->perform;

        # Looking at the results...
        if ($retcode == 0) {
                my $response_code = $curl->getinfo(CURLINFO_HTTP_CODE);
                # judge result and next action based on $response_code
	
	  if ($response_body =~ m/$opts{r}/){print "OK REGEXP FOUND \n";exit EXIT_OK ;} 
		else {
		print "REGEXP NOT FOUND \n"; exit EXIT_CRITICAL;
		     }
        } else {
                print("An error happened: ".$curl->strerror($retcode)." ($retcode)\n");
		exit EXIT_UNKNOWN;
        }


sub HELP_MESSAGE
{
        print <<EOHELP
        Retrieve an http/s URL and looks in its header (ACHTUNG HTTP header not content!) Output for a given text.
        Returns CRITICAL is not found, OK if found, UNKNOWN otherwise.

        --help      shows this message
        --version   shows version information

	-I	        IP address or name (use numeric address if possible to bypass DNS lookup).
        -u          URL to GET
        -r <text>   regexp to match in the output of http header 
        -t          Timeout in seconds to wait for the URL to load. If the page fails to l
oad,
                    $plugin_name will exit with UNKNOWN state (default 60)
        -p          Port


EOHELP
;

}

sub VERSION_MESSAGE
{
        print <<EOVM
$plugin_name v. $VERSION
Copyright 2013
KsI  - http://ksimute.trancom.ru
Sven Mueller
Licensed under GPLv2

EOVM
;
}

