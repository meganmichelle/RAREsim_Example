

#########
### Example code
### Create the necessary file with code to delete 
### monomorphic variants
### Must define count_file
#########

MAC <- read.table(count_file, header = FALSE)
ToRemove <- which(MAC == 0)

rem_file <- paste0(substr(count_file,1,nchar(count_file)-9),  'rem')
rem_file

library(RAREsim)
create_delete_list(ToRemove, name = rem_file)
