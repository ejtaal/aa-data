#!/usr/bin/perl
use strict;
use warnings;
use PDL;

use Text::CSV;
my $csv = Text::CSV->new({ sep_char => ',' });

my $file = $ARGV[0] or die "Need to get CSV file on the command line\n";
my $minstddev = $ARGV[1];

my $sum = 0;
my @data;
my @csv_data;
open(my $data, '<', $file) or die "Could not open '$file' $!\n";
while (my $line = <$data>) {
	chomp $line;

	if ($csv->parse($line)) {
		my @fields = $csv->fields();
		push( @data, $fields[3]);
		push( @csv_data, [@fields]);
	} else {
		warn "Line could not be parsed: $line\n";
	}
}

my $piddle = pdl @data;
my ($mean,$prms,$median,$min,$max,$adev,$rms) = statsover $piddle;
print "mean $mean, prms $prms, median $median, min $min, max $max, adev $adev, rms $rms\n";

my $num_buckets = 40;
my @buckets = (0) x $num_buckets;
my $range = $max - $min;
foreach my $value ( @data) {
	my $buck = int((($value - $min) / $range) * $num_buckets);
	#print "value $value, buck $buck\n";
	$buckets[$buck]++;
}

print "=== Full report: ===\n";
foreach my $index (0 .. $#csv_data) {
	# Calc std dev of this file:
	$csv_data[$index][4] = ($csv_data[$index][3] - $mean) / $prms;
	printf "%5s %s %dx%d %0.2f %0.2f\n", $index+1, $csv_data[$index][0], 
		$csv_data[$index][1], $csv_data[$index][2], $csv_data[$index][3], 
		$csv_data[$index][4];
}

print "=== Distribution: ===\n";
print "no.  ratio  -/+ stddev    path\n";
for (my $i = 0; $i <= $num_buckets; $i++) {
	#printf "%02d. %0.3f %s\n", $i, ($range * $i / $num_buckets + $min), $buckets[$i] x '=';
	my $buck_value = ($range * $i / $num_buckets + $min);
	my $buck_stddev = ($buck_value - $mean) / $prms;
	printf "%02d. %0.3f (%s%05.2f) %s\n", $i, $buck_value, ($buck_stddev > 0 ? '+' : ' '), $buck_stddev,  $buckets[$i] ;
}


print "=== Wide ones out (stddev > 3): ===\n";
foreach my $index (0 .. $#csv_data) {
	# Calc std dev of this file:
	if ($csv_data[$index][4] > 3) { print $index+1; print " "; }
}

print "\n=== Thin ones out (stddev < $minstddev): ===\n";
foreach my $index (0 .. $#csv_data) {
	# Calc std dev of this file:
	if ($csv_data[$index][4] < $minstddev) { print $index+1; print " "; }
}
print "\n";

