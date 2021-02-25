ToDel_file<-'/nfs/storage/math/gross-s2/projects/RAREsim/ExampleForBetaTesting/TestSims/Test_b37_NFE_ToPrune.txt'

#########
### Pruning Example: Delete Only R script
#########

library(RAREsim)

### Read in RAREsim output to get the lines to remove
ToDel <- read.table(file = ToDel_file, header = TRUE)

rem_file <- paste0(substr(ToDel_file,1,nchar(ToDel_file)-11),  'List2delete')

### Create a file with the necessary code to delete the list
create_delete_list(ToDel$line, name = rem_file)



