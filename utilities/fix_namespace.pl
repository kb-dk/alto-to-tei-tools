#!/usr/bin/perl -w

use strict;

if(open(FIND,"find . -name '*.xml' -print |")) {
    while(my $file = <FIND>) {
	next if $file =~ /schemas.xml/;
	next if $file =~ /capabiliti.*xml/;
	print $file;
	chomp $file;
	my $out = $file."_shit";
	system ('sed \'s/xmlns=\"\"/ /g\' $file > $out');
    }
}
