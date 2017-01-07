#!/usr/bin/perl

use strict;
use warnings;
use Text::CSV;

my $file = "$ARGV[0]";
open my $fh, "<", $file or die "$file: $!";

  my $csv = Text::CSV->new ({
      binary    => 1, # Allow special character. Always set this
      auto_diag => 1, # Report irregularities immediately
      });
$csv->getline ($fh); # skipping header
my $CumulativeSh=0;
my $CumulativeSv=0;
my $CumulativeEh=0;
my $CumulativeIv=0;

my $count=0;
while (my $row = $csv->getline ($fh)) {
    #$sum = $sum + $row->[$ARGV[0]];  
    $CumulativeSh = $CumulativeSh + $row->[0];
    $CumulativeSv = $CumulativeSv + $row->[10];
    $CumulativeEh = $CumulativeEh + $row->[1];
    $CumulativeIv = $CumulativeIv + $row->[12];
    
    $count = $count + 1;
    }
my $meanSh=$CumulativeSh/$count;
my $meanSv=$CumulativeSv/$count;
my $meanEh=$CumulativeEh/$count;
my $meanIv=$CumulativeIv/$count;
    print "$meanSh \t $meanSv \t $meanEh \t $meanIv\n";
  close $fh;
