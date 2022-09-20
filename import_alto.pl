#!/usr/bin/perl -w

use strict;

use Getopt::Long;

my $source = "../trykkefrihedens-skrifter/";
my $destination = "./data/";
my $pattern = '^(\d+?)_';

my $result = GetOptions (
    "pattern=s"     => \$pattern,
    "source=s"      => \$source,
    "destination=s" => \$destination);


if ( open(SRC,"find $source -name '*.xml' -type f -print |") ) {

    while(my $file = <SRC>) {
	chomp $file;
	next unless $file =~ m/\d_\d\d\d/;
	next unless $file;
	my $dest_file = $file;
	my $directory = "";
	$dest_file =~ s/$source//;
	($directory,$dest_file) = split /\//, $dest_file;
	if($dest_file =~ m/($pattern)/) {
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


sub usage {

    print <<"END";
    Correct usage:
    $0 <options>
        where options are
        --pattern=<regex> 
	a regex matching the first few characters in an alto file's name
        --source=<directory>
        where to read files
	--destination=<directory>
	where to write files
END

}
