#!/usr/bin/perl 

use strict;
use warnings;

# Check input args
my $ARGC = scalar @ARGV;
$ARGC >= 1 or die "Error: not enough arguments.\nUsage is: $0 <filename>\n";

# Open input file
my $filepath = shift;
open(my $fh_r, "<:encoding(UTF-8)", $filepath) or die "Can't open file $filepath. $!"; 

my @lines = ();	# lines as seen from serial monitor
my $words; 	# temporary var to concatenate $word
while(<$fh_r>) {
	my $i=0;
	if (/0x([[:xdigit:]]+)/) {		
		my $hexstr = $1;
		if($hexstr =~ /0a/) { 	
			push @lines, $words;
			$i++;
			$words = "";
		}
		my $word;
		while ($hexstr =~ /(..)/g) {$word .= chr hex $1}
		$words .= $word;
	}
}

chop(@lines); # Remove newline
chop(@lines); # Remove trailing '|'

# @lines is now a csv of x-accel,y-accel,z-accel in m/s^2
# E.g. |0.00|0.00|9.5|
foreach(@lines) { 
	my $line = substr $_, 2;
	$line =~ s/\|/\,/g;
	print "$line\n";

}





