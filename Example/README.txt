Here is a start to finish example simulation with RAREsim.

Before running, HAPGEN2 and the RAREsim R package need to be installed. The sed command is also used in the bash script.

The necessary reference data files are included:
   Example.hap
   Example.legend
   Example_map.txt
  
To run, use the bash script
  Example_code.sh
  
The bash script will call the Rscripts
  Delete_Monomorphic.R
  Run_RAREsim.R
  Prune_Variants.R
  
Notes:

 HAPGEN2 is called with ./hapgen2 - this might need to be edited upon instalation
 
 Users with macs might find the gsed command easier to install. After installation, simply replace all 'sed' with 'gsed' in the bash script.
