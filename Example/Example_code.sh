#!/bin/bash


Hap=Example.hap
Map=Example_map.txt
Leg=Example.legend
Output=Simulated_example
DL=54313452
Nsim=2000
Reg_size_kb=0.25
pop=AFR
NE=17469

### simulate with HAPGEN2
./hapgen2 -h $Hap \
-m $Map \
-l $Leg \
-o $Output.gz \
-n $Nsim 0 \
-dl $DL 1 1.0 1.0 \
-Ne $NE \
-no_gens_output 

rm $Output.cases.*

### create the MAC file
zcat $Output.controls.haps.gz | awk '{sum=0; for(i=1; i<=NF; i++) sum += $i; print sum}' > $Output.count.txt

### delete the variants with 0 alternate alleles (no variation - monomorphic variants)
### must be in directory with R code

### replace the first line of the R script with the necessary file location
count="count_file <- '$Output.count.txt'"
sed -i "1c${count}" Delete_Monomorphic.R 

### run the Rscript to create the .rem.sed file
Rscript Delete_Monomorphic.R 

#### unzip the haplotype and genotype files 
gunzip $Output.controls.haps.gz


### remove the monomorphic variants from the haplotype and genotype files
sed -i -f $Output.rem.sed $Output.controls.haps 

### remove the legend file header (so line number correctly corresponds)
sed -i '1d' $Output.legend

### remove the monomorphic variants from the legend file
sed -i -f $Output.rem.sed $Output.legend 

### create an updated MAC file for pruning
cat $Output.controls.haps | awk '{sum=0; for(i=1; i<=NF; i++) sum += $i; print sum}' > $Output.count.txt

### relace the first three lines of the Run_RAREsim.R script with the necessary variables
Nsim2="nsim <- $Nsim"
pop2="pop <- '$pop'"
reg_size="reg_size <- $Reg_size_kb\ "
sed -i "1c${Nsim2}" Run_RAREsim.R
sed -i "2c${pop2}" Run_RAREsim.R
sed -i "3c${count}" Run_RAREsim.R
sed -i "4c${reg_size}" Run_RAREsim.R

### run RAREsim

Rscript Run_RAREsim.R


### Implement pruning:

#### Check if the subset AA files exists

FILE=$Output.SubsetAA.txt
if test -f "$FILE"; then
    echo "$FILE exists."
    ### prune commands!


awk '{print $1}' $Output.SubsetAA.txt > ChangeLines.txt

## Delete  the header in ChangeLines so we can just loop through the lines

sed -i '1d' ChangeLines.txt

##### Extract each line from the haplotype file that needs a subset of variants removed

while read ln; do

ln1=$(( $ln + 1))
sed -n "${ln}p;${ln1}q" $Output.controls.haps >> VariantsToEdit.txt

done <ChangeLines.txt 

### 3. Use the RAREsim package to take the ToChange file and edit the lines (variants) - based on the ToPrune file 

add1="original_variants_file<-'VariantsToEdit.txt'"
add2="new_mac_file<-'$Output.SubsetAA.txt'"
add3="con1<-'$Output.controls.haps'"
add4="con2<-'$Output.controls.updated.haps'"

sed -i "1c${add1}" Prune_subset_of_AA.R
sed -i "2c${add2}" Prune_subset_of_AA.R
sed -i "3c${add3}" Prune_subset_of_AA.R
sed -i "4c${add4}" Prune_subset_of_AA.R

Rscript Prune_subset_of_AA.R

rm $Output.controls.haps
cp $Output.controls.updated.haps $Output.controls.haps
rm $Output.controls.updated.haps

rm VariantsToEdit.txt


fi

## remove other pruned variants

prune="ToDel_file <- '$Output\_ToPrune.txt'"
sed -i "1c${prune}" Prune_Variants.R 

### run the Rscript to create the List2Delete.sed file

Rscript Prune_Variants.R

### remove the pruned variants from the haplotype
sed -i -f $Output\_List2delete.sed $Output.controls.haps

## re-zip the haplotype and genotype files
gzip $Output.controls.haps


### remove the pruned variants from the legend file
sed -i -f $Output\_List2delete.sed $Output.legend 

### add the header back to the legend file
sed -i " 1s|^|rs position X0 X1\n| " $Output.legend 





