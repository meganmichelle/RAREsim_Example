Rare variant data that has already been simulated with RAREsim is available at [this link](https://drive.google.com/drive/folders/17UuAPYydEcj_chsfMLl3XDDlkhkoG1I3?usp=sharing). For each of the four ancestral populations, 1,000 replicates of the block with the median number of bp (19,029 bp) was simulated for twice the sample size observed in gnomAD: African (AFR): N=16,256; East Asian (EAS): N=18,394; Non-Finnish European (NFE): N=113,770; South Asian (SAS): N=30,616.

# Reference Data 
To simulate the data linked  above, reference data from cM block 37 (the block with the median number of bp) was used for each ansestry (AFR, EAS, NFE, and SAS). The necessary reference and haplotype files, with all bp added for simulation, can be found in RAREsim_Example/Reference_Data. Each tar ball contains all cM blocks from chromosome 19 for the specified ancestry - only block 37 was used here.

# Simulating with HAPGEN2
HAPGEN2 was used to simulate 1000 replicates for twice the ancestry specific sample size observed in gnomAD. The code is found in the Simulate_step1_HAPGEN2.sh script. HAPGEN2 over simulates the number of variants,  which will then be pruned to match what is expected.

# Calculating Expected Number of Variants per MAC bin
The expected number of variants per MAC bin was calculated within Simulate_step2_Expected_Variants.R

# Pruning to match the expected number of variants
The HAPGEN2 files were then pruned to match what was expected, as seen in the Simulate_step3_pruning.sh
