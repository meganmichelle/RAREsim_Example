count_file <- '/nfs/storage/math/gross-s2/projects/RAREsim/ExampleForBetaTesting/TestSims/Test_b37_NFE.count.txt'

#########
### Example code
### Create the necessary file with code to delete 
### monomorphic variants
### Must define count_file
#########

MAC <- read.table(count_file, header = FALSE)
ToRemove <- which(MAC == 0)

rem_file <- paste0(substr(count_file,1,nchar(count_file)-9),  'rem')

library(RAREsim)
create_delete_list(ToRemove, name = rem_file)
