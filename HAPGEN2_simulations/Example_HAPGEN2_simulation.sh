#!/bin/bash

./hapgen2 -h [path/to/haplotype/with/all/sequencing/bases.hap] \
-m [path/to/recombination/map.txt] \
-o [path/to/output/file_name.gz] \
-l [path/to/legend/with/all/sequencing/bases.legend] \
-no_gens_output \
-n 8128 0 \
-dl $dl 1 1.0 1.0 \
-Ne 17469 

#### and then create the MAC file

zcat /path/to/output/and/name/.controls.haps.gz | awk '{sum=0; for(i=1; i<=NF; i++) sum += $i; print sum}' > \
/path/to/MAC/output/location/File_name.count.txt