Supplementary data and information for the [RAREsim R package](https://github.com/meganmichelle/RAREsim), and the [RAREsim python package](https://github.com/ryanlayer/raresim).

![RAREsim_implementation_flowchart](https://user-images.githubusercontent.com/21186894/132229596-fe861e53-a002-4a5c-afe8-b742a7316c76.png)

# Example 
 Start to finish example simulation with example bash code for implementation.
 
 RAREsim requires [HAPGEN2](https://mathgen.stats.ox.ac.uk/genetics_software/hapgen/hapgen2.html), the [RAREsim R package](https://github.com/meganmichelle/RAREsim), and the [RAREsim python package](https://github.com/ryanlayer/raresim).

# Reference Data 
Chromosome 19 coding regions reference data that can be used with RAREsim
 *_input_sim_data.tar.gz
   The ancestry specific (AFR, EAS, NFE, SAS) input simulation haplotypes used in RAREsim
   Each tar ball contains haplotype and legend files for the cM blocks on Chromosome 19, as described in the  RAREsim manuscript.
   The blocks have all sequence bases added within the coding region, to allow HAPGEN2 to simulate an abundance of variants.

# Code_from_analysis
  Code necessary to recreate the majority of the analysis examined in the RAREsim manuscript
  
# Stratified_Target_Data
  AFS and Nvariant target data stratified by functional and synonymous status. Target data is available for each cM block on chromosome 19, for each of the four ancesties.
  
# Simulated Data
  Already simulated rare variant data is available at [this link](https://drive.google.com/drive/folders/17UuAPYydEcj_chsfMLl3XDDlkhkoG1I3?usp=sharing). For each of the four ancestral populations, 1,000 replicates of the block with the median number of bp (19,029 bp) was simulated for twice the sample size observed in gnomAD: African: N=16,256; East Asian: N=18,394; Non-Finnish European: N=113,770; South Asian: N=30,616.
  
  The folder contains the code used to create the data.

