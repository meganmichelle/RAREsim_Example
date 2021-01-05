#############
##### Example for pruning
#############

### Script should be run in a directory with all files or the working directory should be set
### If Running in a loop, a copy of Prune_Example.R will need to be made or the edits at the top of the file need to be deleted

WD=[working directory]
SimHap=[Simulated haplotypes with excess rare variants, do NOT include .gz in the name] 
SimLeg=[Simulated legend file with excess rare variants] 
ToPrune_subset=[Output from the Pruning_info R function]
ToPrune_remove=[Output from the Pruning_info R function]

cd $WD 

### First unzip the haplotype file to work with

gunzip $SimHap.gz

#### Variants pruned by removing 1) a subset of or 2) all alternate alleles

#### First, we will address the variants that require a subset of alternate alleles returned to reference:

##### Extract the list of lines that need edited (subset of AA's returned to reference)

awk '{print $1}' $ToPrune_subset > ChangeLines.txt

## Delete  the header in ChangeLines so we can just loop through the lines

sed -i '1d' ChangeLines.txt



##### Extract each line from the haplotype file that needs a subset of variants removed

while read ln; do

ln1=$(( $ln + 1))
sed -n "${ln}p;${ln1}q" $SimHap >> ToChange.txt

done <ChangeLines.txt 



### 3. Use the RAREsim package to take the ToChange file and edit the lines (variants) - based on the ToPrune file 

###### User needs to be in the directory with Example_code_pruning.R!
#### Add the first few lines:

add_1="original_variants_file<-'$WD\ToChange.txt'"

sed -i " 1s|^|${add_1}\n| " Example_code_pruning.R


add_2="new_mac_file<-'$ToPrune_subset'"

sed -i " 1s|^|${add_2}\n| " Example_code_pruning.R


add_3="con1<-'$SimHap'"

sed -i " 1s|^|${add_3}\n| " Example_code_pruning.R


add_4="con2<-'$SimHap.updated.haps'"

sed -i " 1s|^|${add_4}\n| " Example_code_pruning.R


add_5="variants_remove_file<-'$ToPrune_remove'"

sed -i " 1s|^|${add_5}\n| " Example_code_pruning.R


add_6="legend_file<-'$SimLeg'"

sed -i " 1s|^|${add_6}\n| " Example_code_pruning.R


add_7="ToDel_file<-'$ToPrune_remove'"

sed -i " 1s|^|${add_7}\n| " Example_code_pruning.R


##### Run the R script

Example_code_pruning.R
Rscript Example_code_pruning.R


### 6. Then remove all of the lines we don't care about (pull other code)

### Remove variants from the haplotype file
sed -i -f List2delete.sed $SimHap.updated.haps

### Remove those same variants from the legend file

#### First, remove the header from the legend file (so line number correctly corresponds)
sed -i '1d' $SimLeg

#### Remove the variants that were removed from the haplotype file
sed -i -f List2delete.sed $SimLeg

#### Add the header back in
sed -i " 1s|^|rs position X0 X1\n| " $SimLeg

### 7. And rezip the file

gzip $SimHap.updated.haps

rm ToChange.txt #(we just add to the bottom... so it doesn't work in the loop) 
