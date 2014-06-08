#!/usr/bin/perl
$start=0;
$data="";
while(<STDIN>)
{
	if ( $start eq 0 && $_ =~ /^\r\n/) { $start = 1; }
	elsif ( $start eq 1 ) { $data = $data . $_; }
}
open(FH, ">file.mp4");
print FH $data;
close(FH);
