#!/usr/bin/perl

use URI;
use URI::QueryParam;

$|=1;
while (<>) {
    chomp;
    @X = split;
    $url = $X[1];
    #check if this is a google redirect url
    if ($url =~ /\/\/.*\.google\.[^\/]+\/url/) {
        my $uri = URI->new($url);
        $url = $uri->query_param("url");
        print $X[0]." 302:$url\n";
    } else {
        print $X[0]." \n";
    }
}
