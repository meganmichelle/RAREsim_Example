#!/bin/bash

### map file  (same for all ansestries
Map=${WD_input}/input/genetic_map_chr19_combined.txt

### variables to be updated per ancestry'
## AFR
pop=AFR #population: AFR(African), EAS(Eastern Asian), NFE(Non-Finnish European), SAS(South Asian)
NE=17469 #effective sample size: AFR(17469), EAS(14269), NFE(11418), SAS(14269)
Nsim=16256 #number of individuals (twice gnomAD): AFR (16256), EAS: (183394), NFE: (113770), SAS: (30616) 
Hap=${pop}_Block37_CDS_ref_added.hap
Leg=${pop}_Block37_CDS_ref_added.legend

DL=14765870 # a random locus with at least one alternate allele

# Simulat 1000 replicates
for i in $(seq 1 1000)
do
### output variables
Output=chr19.block37.${pop}.sim${i}

### simulate with HAPGEN2
/nfs/apps/math/hapgen2/hapgen2 -h $Hap \
-m $Map \
-l $Leg \
-o $Output.gz \
-n $Nsim 0 \
-dl $DL 1 1.0 1.0 \
-no_gens_output \
-Ne $NE

done



### variables to be updated per ancestry
## EAS
pop=EAS #population: AFR(African), EAS(Eastern Asian), NFE(Non-Finnish European), SAS(South Asian)
NE=14269 #effective sample size: AFR(17469), EAS(14269), NFE(11418), SAS(14269)
Nsim=183394 #number of individuals (twice gnomAD): AFR (16256), EAS: (183394), NFE: (113770), SAS: (30616) 
Hap=${pop}_Block37_CDS_ref_added.hap
Leg=${pop}_Block37_CDS_ref_added.legend

DL=14591546 # a random locus with at least one alternate allele

# Simulat 1000 replicates
for i in $(seq 1 1000)
do
### output variables
Output=chr19.block37.${pop}.sim${i}

### simulate with HAPGEN2
/nfs/apps/math/hapgen2/hapgen2 -h $Hap \
-m $Map \
-l $Leg \
-o $Output.gz \
-n $Nsim 0 \
-dl $DL 1 1.0 1.0 \
-no_gens_output \
-Ne $NE

done
 
### variables to be updated per ancestry
## NFE
pop=NFE #population: AFR(African), EAS(Eastern Asian), NFE(Non-Finnish European), SAS(South Asian)
NE=11418 #effective sample size: AFR(17469), EAS(14269), NFE(11418), SAS(14269)
Nsim=113770 #number of individuals (twice gnomAD): AFR (16256), EAS: (183394), NFE: (113770), SAS: (30616) 
Hap=${pop}_Block37_CDS_ref_added.hap
Leg=${pop}_Block37_CDS_ref_added.legend

DL=14705483 # a random locus with at least one alternate allele

# Simulat 1000 replicates
for i in $(seq 1 1000)
do
### output variables
Output=chr19.block37.${pop}.sim${i}

### simulate with HAPGEN2
/nfs/apps/math/hapgen2/hapgen2 -h $Hap \
-m $Map \
-l $Leg \
-o $Output.gz \
-n $Nsim 0 \
-dl $DL 1 1.0 1.0 \
-no_gens_output \
-Ne $NE

done
 
### variables to be updated per ancestry
## SAS
pop=SAS #population: AFR(African), EAS(Eastern Asian), NFE(Non-Finnish European), SAS(South Asian)
NE=14269 #effective sample size: AFR(17469), EAS(14269), NFE(11418), SAS(14269)
Nsim=30616 #number of individuals (twice gnomAD): AFR (16256), EAS: (183394), NFE: (113770), SAS: (30616) 
Hap=${pop}_Block37_CDS_ref_added.hap
Leg=${pop}_Block37_CDS_ref_added.legend

DL=14508902 # a random locus with at least one alternate allele
# Simulat 1000 replicates
for i in $(seq 1 1000)
do
### output variables
Output=chr19.block37.${pop}.sim${i}

### simulate with HAPGEN2
/nfs/apps/math/hapgen2/hapgen2 -h $Hap \
-m $Map \
-l $Leg \
-o $Output.gz \
-n $Nsim 0 \
-dl $DL 1 1.0 1.0 \
-no_gens_output \
-Ne $NE

done
 
