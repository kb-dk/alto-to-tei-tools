#!/usr/bin/perl -w

use strict;

my $source = "../trykkefrihedens-skrifter/";
my $destination = "./data/";

if ( open(SRC,"find $source -name '*.xml' -type f -print |") ) {

    while(my $file = <SRC>) {
	chomp $file;
	next unless $file =~ m/\d_\d\d\d/;
	next unless $file;
	my $dest_file = $file;
	my $directory = "";
	$dest_file =~ s/$source//;
	($directory,$dest_file) = split /\//, $dest_file;
	if($dest_file =~ m/^(\d+?)_/) {
	    $directory =~ s/_$1//;
	    $dest_file = "$destination$directory/$dest_file";
	    print "mkdir -p $destination$directory; ";
	    print "cp $file $dest_file\n";
	} else {
	    print '# ' . $file . "\n";
	    print "# $dest_file  does not parse\n";
	}
    }

} else {

    die "Cannot find project $source: $!";

}
