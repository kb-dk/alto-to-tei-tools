#!/usr/bin/perl -w

use strict;

my $source = "../trykkefrihedstekster/";
my $destination = "./data/";

if ( open(SRC,"find $source -name '*.xml' -type f -print |") ) {

    while(my $file = <SRC>) {
	chomp $file;
	my $dest_file = $file;
	my $directory = "";
	$dest_file =~ s/$source//;
	($directory,$dest_file) = split /\//, $dest_file;
	$dest_file =~ m/^(\d+?)_/;
	$directory =~ s/_$1//;
	$dest_file = "$destination$directory/$dest_file";
	print "mkdir -p $destination$directory; ";
	print "cp $file $dest_file\n";
    }

} else {

    die "Cannot find project $source: $!";

}
