#!/usr/bin/perl -w

use strict;

my $saxon = "java -jar " . $ENV{'SAXON_PATH'};
my $sheet = "./utilities/add-id.xsl";

if(open(FIND,"find ./tei_dir/ -name '*.xml' -print |")) {
    while(my $file = <FIND>) {
	next if $file =~ /schemas.xml/;
	next if $file =~ /capabiliti.*xml/;
	print $file;
	chomp $file;
	my $out = $file."_shit";
	system "$saxon $file $sheet > $out";
	system "xmllint --format $out > $file";
	system "rm $out";
    }
}
