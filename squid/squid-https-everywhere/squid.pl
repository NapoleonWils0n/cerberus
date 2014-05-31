#!/usr/bin/perl  
use strict;
use warnings;
use lib '/etc/squid/https-everywhere';
use HTTPSEverywhere;

# This is a redirector for Squid. It redirects requests to https according to the
# HTTPS Everywhere rulesets.
#
# Installation instructions:
#
# 1.) In /etc/squid/https-everywhere/ place this file, and HTTPSEverywhere.pm
#
# 2.) Create a directory at /etc/squid/https-everywhere/git, cd into that directory and do a:
#     git clone git://git.torproject.org/https-everywhere.git
#
# 3.) Edit /etc/squid/squid.conf and add this line:
#     redirect_program /etc/squid/https-everywhere/squid.pl
#
# 4.) Restart squid.
#
# You should cd in to /etc/squid/https-everywhere/git and do a "git pull" on a regular
# basis, to pull down ruleset changes. Cron it if possible

$|=1;  

my $base = '/etc/squid/https-everywhere/git/https-everywhere';

my $he      = new HTTPSEverywhere( rulesets => ["$base/src/chrome/content/rules"] );    
my $updated = time;

while(<>){  
   my( $url ) = /^(\S+)/;

   ## Re-read the rulesets if it has been more than an hour
     if( $updated < time-3600 ){
        $he->read();
        $updated = time;
     }

   ## Converted version of the url
     my $newurl = $he->convert( $url );

   if( $url eq $newurl ){
      print "$url\n";
   } else {
      print "301:$newurl\n";
   }
}  
