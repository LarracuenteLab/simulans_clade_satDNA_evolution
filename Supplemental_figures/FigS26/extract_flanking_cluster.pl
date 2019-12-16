#!/usr/bin/perl
use warnings;
use strict;

my $list = $ARGV[0]; #read in *_repeat_clusters_v4.txt files
my $fasta = $ARGV[1];
my $first = $ARGV[2];
my $second = $ARGV[3];


#Put fasta into hash for parsing#####################
my %seq;
my $hold;
open(FASTA,$fasta);
while(<FASTA>) {
	chomp $_;
	if($_ =~m/>/) {
		my $id=$_;
		$id =~s/>//;
		$seq{$id}=0;
		$hold=$id;
		next;
	}
	else {
		$seq{$hold}=$_;
		next;
	}
}
######################################################


#foreach my $key (keys %seq) {
#	my $value = $seq{$key};
#	print "$key $value\n";
#}


open(LIST,$list);
open(FIRST, '>', $first);
open(SECOND, '>', $second);

while(<LIST>) {
	chomp($_);
	my @array=split("\t",$_);

	my @array2=split(/[:-]/,$array[6]); #change here
	my $chrom=$array2[0];
#	print "$chrom\n";
	
	@array2=split(/[:-]/,$array[2]); #get nearest upstream element coords
	my $upstart=$array2[1];
	my $upend=$array[8];


	@array2=split(/[:-]/,$array[4]); #get nearest downstream element coords
	my $downstart=$array[9];
	my $downend=$array2[2];
	

	if(exists($seq{$chrom})) {
		my $sequence = $seq{$chrom};
		#print "$sequence\n";
		my $updist=$upend-$upstart;
		my $upper = substr($sequence,$upstart-1,$updist+1);

		my $downdist=$downend-$downstart;
		my $lower = substr($sequence,$downstart-1,$downdist+1);
		print FIRST ">$array[6].$array[11].lflank\n$upper\n";
		print SECOND ">$array[6].$array[11].rflank\n$lower\n";
	}
	else {
		print "can't find $chrom in hash\n";
	}
}
