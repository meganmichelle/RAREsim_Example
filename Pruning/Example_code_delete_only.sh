#!/bin/bash

### Code for pruning when variants are only deleted

### Using [ToPrune] to prune [Hap] and [Leg]

### Define Variables:

WD=[working directory] ## Must be in the directory with R script
SimHap=[Simulated haplotypes with excess rare variants, do NOT include .gz in the name] 
SimLeg=[Simulated legend file with excess rare variants] 
ToPrune_remove=[Output from the Pruning_info R function]

cd $WD 

### Create the file with the command needed to remove variants (rows)

#### Specify the file location and add it to the top of the R code
add="ToDel_file<-'$ToPrune_remove'"

gsed -i " 1s|^|${add}\n| " Example_code_delete_only.R

### Run the Rscript to create List2delete.sed 
Rscript Example_code_delete_only.R

### First unzip the haplotype file:

gunzip $SimHap.gz

### Delete the pruned variants from the haplotype and legend file

gsed -i -f List2delete.sed $SimHap

## And rezip the file

gzip $SimHap

#### First, remove the header from the legend file (so line number correctly corresponds)
sed -i '1d' $SimLeg

#### Remove the variants that were removed from the haplotype file
sed -i -f List2delete.sed $SimLeg

#### Add the header back in
sed -i " 1s|^|rs position X0 X1\n| " $SimLeg

