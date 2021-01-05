#!/bin/bash

### this uses sed. Might need to change to gsed...

Hap=[path/to/haplotype/with/all/sequencing/bases.hap]
Map=[path/to/recombination/map.txt]
Leg=[path/to/legend/with/all/sequencing/bases.legend]
Output=[path/to/output/file_name] 
Nsim=[Number of individuals to simulate]
DL=[disease locus] # must have a nonzero number of alternate alleles
NE=[Effective population size] # see http://mathgen.stats.ox.ac.uk/genetics_software/hapgen/hapgen2.html for recommended parameters

#### Maybe add working directory for the code???

WD=[directory that contains Example_code_delete.R]

### Simulate with HAPGEN2

./hapgen2 -h $Hap \
-m $Map \
-l $Leg \
-o $Output.gz \
-no_gens_output \
-n $Nsim 0 \
-dl $DL 1 1.0 1.0 \
-Ne $NE

#### Create the MAC file

zcat $Output.controls.haps.gz | awk '{sum=0; for(i=1; i<=NF; i++) sum += $i; print sum}' > \
$Output.count.txt


#### Delete the variants with 0 alternate alleles (no variation)

#### put a new first line:
add="count_file<-'$Output.count.txt'"

sed -i " 1s|^|${add}\n| " Example_code_delete.R

### Run the Rscript to create the necessary file to delete variants

##########
### Need to be in the directory with this script. And the file will write to that directory
##########

cd $WD 

Rscript Example_code_delete.R
##########

#### Need to unzip the  haplotype file  before we  can  remove variants
gunzip $Output.controls.haps.gz

#### need to update this:
sed -i -f $Output.rem.sed $Output.controls.haps ### check

### Re-zip the haplotype file
gzip $Output.controls.haps

### remove the header to the legend file
sed -i '1d' $Output.legend

### delete the variants without variation:
sed -i -f $Output.rem.sed $Output.legend

### add the header back
sed -i " 1s|^|rs position X0 X1\n| " $Output.legend

### Create an updated MAC file for pruning

zcat $Output.controls.haps.gz | awk '{sum=0; for(i=1; i<=NF; i++) sum += $i; print sum}' > \
$Output.count.txt
