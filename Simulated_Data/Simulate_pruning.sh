#!/bin/bash

for pop in AFR EAS NFE SAS

do

for i in $(seq 1 1000)

do

# Create the sparse matrix
python3 convert.py -i chr19.block37.NFE.sim$i.controls.haps.gz -o chr19.block37.NFE.sim$i.controls.haps.sm 

# Prune the haplotypes to match the expected
python3 sim.py -m /chr19.block37.$pop.sim$i.controls.haps.sm -b Expected_variants_${pop}_twice_gnomAD.txt -l chr19.block37.${pop}.sim$i.legend -L ${pop}.rep$i.updated.legend -H ${pop}.rep$i.updated.haps.gz

done

done
