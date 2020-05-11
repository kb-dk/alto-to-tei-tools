#!/usr/bin/perl -w

use strict;

my $source = "../trykkefrihedstekster/";
my $destination = "./data/";

if ( open(SRC,"find $source -name '*.xml' -typr f -print |") ) {

    while(my $file = <SRC>) {
	print $file;
    }

} else {

    die "Cannot find project $source: $!";

}
