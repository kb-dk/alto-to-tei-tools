#!/usr/bin/perl -w

use strict;

my $saxon = "java -jar ~/saxon/saxon9he.jar";
my $sheet = "../solr-and-snippets/utilities/add-id.xsl";

if(open(FIND,"find . -name '*.xml' -print |")) {
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
