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

### Remove unnecessary files produced by HAPGEN2
rm $Output.cases.*


### Calculate the number of variants per MAC bin with the RAREsim R package

### replace the first four lines of the Run_RAREsim.R script with the necessary variables
Nsim2="nsim <- $Nsim"

pop2="pop <- '$pop'"
reg_size="reg_size <- $Reg_size_kb\ "

sed -i "1c${Nsim2}" Expected_MAC_bins.R
sed -i "2c${pop2}" Expected_MAC_bins.R
sed -i "3c${reg_size}" Expected_MAC_bins.R

### run RAREsim

Rscript Expected_MAC_bins.R


### Convert the haplotype file into a sparse matrix

python convert.py \
    -i $Output.controls.haps.gz \
    -o $Output.controls.haps.gz.sm


### Prune the haplotype to match what is expected
$ python sim.py \
    -m $Output.controls.haps.gz.sm \
    -b MAC_bin_estimates.txt \
    -l $Output.legend \
    -L $Output.new.legend \
    -H $Output.new.hap.gz



