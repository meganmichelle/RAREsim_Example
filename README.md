The primary RAREsim code can be found at https://github.com/meganmichelle/RAREsim.

Here we have three folders:

# Example 
 Start to finish example simulation with example bash code for implementation.
 
 RAREsim requires HAPGEN2[https://mathgen.stats.ox.ac.uk/genetics_software/hapgen/hapgen2.html], the RAREsim R package[https://github.com/meganmichelle/RAREsim], and the RAREsim python package[https://github.com/ryanlayer/raresim].

# Reference Data 
Chromosome 19 coding regions reference data that can be used with RAREsim
 *_input_sim_data.tar.gz
   The ancestry specific (AFR, EAS, NFE, SAS) input simulation haplotypes used in RAREsim
   Each tar ball contains haplotype and legend files for the cM blocks on Chromosome 19, as described in the  RAREsim manuscript.
   The blocks have all sequence bases added within the coding region, to allow HAPGEN2 to simulate an abundance of variants.

# Code_from_analysis
  Code necessary to recreate the majority of the analysis examined in the RAREsim manuscript
