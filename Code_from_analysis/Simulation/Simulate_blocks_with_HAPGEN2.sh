#!/bin/bash


#######
## Example code to simulate the cM blocks for African ancestry
## The other ancestries were extremely similar
## Reference data used in simulations can found at https://github.com/meganmichelle/RAREsim_Example/tree/master/Reference_Data


### First simulate  with HAPGEN2

pop='AFR'

for bl in {0..22}
do
for rep in {1..100}
do

dl_bl="$(($bl + 1))"

dl=$(cat /nfs/storage/math/gross-s2/combined/sorensom/RAREsimV3/Chr19/Input_data_1KG/$pop\_blocks/$pop\block_disease_loci.txt | sed -n "${dl_bl}p")

#echo $dl 


./hapgen2 -h /nfs/storage/math/gross-s2/combined/sorensom/RAREsimV3/Chr19/Input_data_1KG/$pop\_blocks/$pop\_Block$bl\_CDS_ref_added.hap \
-m /nfs/storage/math/gross-s2/projects/HapGen2/1000GP_Phase3/Map/genetic_map_chr19_combined_b37.txt \
-o /nfs/storage/math/gross-s2/combined/sorensom/RAREsimV3/Chr19/Input_data_1KG/gnomADsize/$pop\_blocks/Data/Rep$rep\/Block$bl\_rep$rep.gz \
-l /nfs/storage/math/gross-s2/combined/sorensom/RAREsimV3/Chr19/Input_data_1KG/$pop\_blocks/$pop\_Block$bl\_CDS_ref_added.legend \
-no_gens_output \
-n 8128 0 \
-dl $dl 1 1.0 1.0 \
-Ne 17469 

done
done



for bl in {24..106}
do
for rep in {1..100}
do

dl_bl="$(($bl + 1))"

dl=$(cat /nfs/storage/math/gross-s2/combined/sorensom/RAREsimV3/Chr19/Input_data_1KG/$pop\_blocks/$pop\block_disease_loci.txt | sed -n "${dl_bl}p")

#echo $dl 


./hapgen2 -h /nfs/storage/math/gross-s2/combined/sorensom/RAREsimV3/Chr19/Input_data_1KG/$pop\_blocks/$pop\_Block$bl\_CDS_ref_added.hap \
-m /nfs/storage/math/gross-s2/projects/HapGen2/1000GP_Phase3/Map/genetic_map_chr19_combined_b37.txt \
-o /nfs/storage/math/gross-s2/combined/sorensom/RAREsimV3/Chr19/Input_data_1KG/gnomADsize/$pop\_blocks/Data/Rep$rep\/Block$bl\_rep$rep.gz \
-l /nfs/storage/math/gross-s2/combined/sorensom/RAREsimV3/Chr19/Input_data_1KG/$pop\_blocks/$pop\_Block$bl\_CDS_ref_added.legend \
-no_gens_output \
-n 8128 0 \
-dl $dl 1 1.0 1.0 \
-Ne 17469 

done
done

### Get the MAC files

mkdir /nfs/storage/math/gross-s2/combined/sorensom/RAREsimV3/Chr19/Input_data_1KG/gnomADsize/$pop\_MAC/


for bl in {0..22}
do

mkdir /nfs/storage/math/gross-s2/combined/sorensom/RAREsimV3/Chr19/Input_data_1KG/gnomADsize/$pop\_MAC/Block$bl\/


for rep in {1..100}
do

zcat /nfs/storage/math/gross-s2/combined/sorensom/RAREsimV3/Chr19/Input_data_1KG/gnomADsize/$pop\_blocks/Data/Rep$rep\/Block$bl\_rep$rep.controls.haps.gz | awk '{sum=0; for(i=1; i<=NF; i++) sum += $i; print sum}' > /nfs/storage/math/gross-s2/combined/sorensom/RAREsimV3/Chr19/Input_data_1KG/gnomADsize/$pop\_MAC/Block$bl\/Rep$rep.count.txt

echo $rep
done

echo $bl

done


for bl in {24..106}
do


mkdir /nfs/storage/math/gross-s2/combined/sorensom/RAREsimV3/Chr19/Input_data_1KG/gnomADsize/$pop\_MAC/Block$bl\/


for rep in {1..100}
do

zcat /nfs/storage/math/gross-s2/combined/sorensom/RAREsimV3/Chr19/Input_data_1KG/gnomADsize/$pop\_blocks/Data/Rep$rep\/Block$bl\_rep$rep.controls.haps.gz | awk '{sum=0; for(i=1; i<=NF; i++) sum += $i; print sum}' > /nfs/storage/math/gross-s2/combined/sorensom/RAREsimV3/Chr19/Input_data_1KG/gnomADsize/$pop\_MAC/Block$bl\/Rep$rep.count.txt

echo $rep
done

echo $bl

done


### Repeat for all  ancestries
