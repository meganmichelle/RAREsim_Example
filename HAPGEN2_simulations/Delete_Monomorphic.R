count_file<-'/Users/megansorenson/Documents/RAREsim/Example/NFE/NFE_Block37_Rep11.count.txt'


#########
### Example code
### Create the necessary file with code to delete 
### monomorphic variants
#########


create_delete_list<-function(variants_to_remove, name=NULL){
  
  if(is.null(name)){
    name = 'List2delete'
  }
  
  to_remove <- paste(variants_to_remove, collapse = 'd; ')
  to_remove <- paste0(to_remove,'d')
  
  write.table(to_remove, file = paste0(name,'.sed'), row.names = FALSE, 
              col.names = FALSE, quote = FALSE)
  
  print(paste('File written in working directory called', name))
  
}


MAC <- read.table(count_file, header = FALSE)
ToRemove <- which(MAC == 0)


rem_file <- paste0(substr(count_file,1,nchar(count_file)-9),  'rem')
rem_file

#### how do we put it in the correct folder???
create_delete_list(ToRemove, name = rem_file)
