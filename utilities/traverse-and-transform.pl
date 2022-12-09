#!/usr/bin/perl -w

use strict;
use Getopt::Long;

my $transform = "./utilities/add-id.xsl";
my $directory = "./tei_dir/";
my $help;

my $result = GetOptions (
    "transform=s"     => \$transform,
    "directory=s"     => \$directory,
    "help" => \$help);



my $saxon = "java -jar " . $ENV{'SAXON_PATH'};


if(open(FIND,"find $directory -name '*.xml' -print | grep -v '/acc' | ")) {
    while(my $file = <FIND>) {
	next if $file =~ /schemas.xml/;
	next if $file =~ /capabiliti.*xml/;
	print $file;
	chomp $file;
	my $out = $file."_shit";
	system "$saxon $file $transform > $out";
	system "xmllint --format $out > $file";
	system "rm $out";
    }
}
