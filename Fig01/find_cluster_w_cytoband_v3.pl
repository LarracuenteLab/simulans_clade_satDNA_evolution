#!/usr/bin/perl
use warnings;
use strict;

my $cyto = $ARGV[0];
my $gff = $ARGV[1];


my %cyto_hash; #structure: {chrom}{band}=start..end
open(CYTO,$cyto);
while(<CYTO>) {
	my @array=split(",",$_);
	unless($array[2] eq "undef") { #array[2] is chrom:start..end
		my @temp=split(":",$array[2]);
		$cyto_hash{$temp[0]}{$array[0]}=$temp[1];
#		print "$temp[0] $array[0] $temp[1]\n";
	}
}

#foreach my $key (keys %cyto_hash) {
#	foreach my $key2 (keys %{ $cyto_hash{$key} }) {
#		my $value = $cyto_hash{$key}{$key2};
#			print "$key $key2 $value\n";
#	}
#}


my %hash;
my $feat;
open(GFF,$gff);
while(<GFF>) {
	chomp $_;
	my @array=split("\t",$_);
	#contig:start:end=feature name
	
	my $fam=$array[2];
	if($fam eq "Low_complexity" || $fam eq "Simple_repeat") {
		next;
	}

	if($array[8]=~m/\(/ || $array[8]=~m/rich/) { #manually gotta change the labels, as 359, 353, and 360 are all mixed up
		next;
	}

	if($array[8]=~m/Target=/) {
		my @element= split /=/,$array[8]; #split /[=_]+/,$array[8];
		$feat=$element[1];
	}
	else {
		my @element= split(" ",$array[8]);
		$feat=$element[0];
	}

	if($fam=~m/transcript/) { #used for parsing stringtie gene annotations (subsetting lines for only transcripts)
		#my @fix = split /=/,$array[8];
		$feat="Gene";
		#print "HEY";
	}

	if($feat=~m/bp/) { #manually gotta change the labels, as 359, 353, and 360 are all mixed up
		$feat="1.688";
	}

	
	#$hash{$array[0]}{$array[3]}{$array[4]} = $element[1];
	#print "$feat\n";
	$hash{$array[0]}{$array[3]}{$array[4]} = $feat;
}

my $prev; #holds previous element in list
my $cluster_count = 1;
my $holdstart; #holds coords of cluster
my $holdend; #holds coords of cluster

my $closeup="NA"; #holds closest upstream element
my $updist="NA";
my $downdist;

my $firstend; #holds end coord of first element in cluster
my $laststart; #holds start coord of last element in cluster

print "Cluster\tRepeats\tClosest upstream\tDist upstream\tClosest downstream\tDist downstream\tCoords\tFirst_start\tFirst_end\tLast_start\tLast_end\tCyto_band\tCyto_start\n";

#print "Cluster\tRepeats\tClosest downstream element\tContig\tFirst_start\tFirst_end\tLast_start\tLast_end\n";

foreach my $contig (keys %hash) {
	foreach my $start (sort {$a <=> $b} keys %{ $hash{$contig} }) { #$start holds start coord of current element
		foreach my $end (keys %{ $hash{$contig}{$start} }) { #$end holds end coord of current element
			my $feature = $hash{$contig}{$start}{$end};
			if(defined($prev)) {
				if( $start > ($holdend+1000) || $feature ne $prev ) { #no increment if current feature doen't equal previous or is too far away. re-define everything

					if($cluster_count >= 1) { #if cluster from previous is big enough, print it

						$downdist=$start-$holdend; #distance of cluster to nearest downstream element

						my $cluster="$prev\t$cluster_count\t$closeup\t$updist\t$feature.$contig:$start-$end\t$downdist\t$contig:$holdstart-$holdend\t$holdstart\t$firstend\t$laststart\t$holdend\n"; 
						cytocluster($cluster,\%cyto_hash); #send cluster to subroutine to get cyto band (neater)...variable being passed correctly!
					}

					$updist=$downdist;

					$closeup="$prev.$contig:$laststart-$holdend"; #is this right???
		
					$holdstart=$start;
					$prev=$feature;
					$laststart=$start;
					$firstend=$end;
					$holdend=$end;
					$cluster_count=1;
				}
				elsif ($feature eq $prev && $start <= ($holdend+1000) ) { #is a match, increment and re-define holdend and feature
					$cluster_count++;
					$prev=$feature;

					$laststart=$start;
					
		
					$holdend=$end; #can't re-def holdstart here, as need it to print cluster coords...
				}
			}
			else { #define for first feature
				$prev=$feature;
				$holdstart=$start;
				$holdend=$end;	
				$firstend=$end;

				$laststart=$start;
			}

		}
	}
}



#######SUBROUTINES######################################

sub cytocluster {
	my $cluster = $_[0];
	chomp $cluster;
	my %cyto_hash = %{$_[1]};
	#print $cluster;
	my @array=split("\t",$cluster); #split cluster, part of interest is the fourth field contig:start-end
	#print "$array[3]\n";
	my @coords = split /[:-]+/, $array[6]; #split on two regex, saves clutter
#	print join(" ",@coords);
#	print "\n";

	#my $chrom=$coords[0];
	my $chrom="X"; #for D. ere, need to set manually as chrom name is different :/

	####Hack-y fix for DSPR chromosomes not matching, comment out as needed
	#my @dspr_fix=split(/\./,$chrom);
	#$chrom=$dspr_fix[1];
	#######################################################################

	my $start=$coords[1];


	foreach my $band (keys %{ $cyto_hash{$chrom} } ) {
		my $value=$cyto_hash{$chrom}{$band};		
		
		my @cyto_coords=split(/\.\./,$value);

		if($start >= $cyto_coords[0] && $start <= $cyto_coords[1]) { #check what cyto band cluster falls into...only looking at start coord, as is rough anyway
			print "$cluster\t$band\t$cyto_coords[0]\n";			
			#print "cluster falls within $chrom $band $cyto_coords[0] - $cyto_coords[1]\n";
		}
	}
}



