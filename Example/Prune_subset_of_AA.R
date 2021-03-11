original_variants_file<-'VariantsToEdit.txt'
new_mac_file<-'NFE.Block61.SubsetAA.txt'
con1<-'NFE.Block61.controls.haps'
con2<-'NFE.Block61.controls.updated.haps'


library(RAREsim)
library(data.table)

original_variants <- fread(file = original_variants_file,
                                header = FALSE)

new_MAC <- fread(file = new_mac_file,
                      header = TRUE)

# Edit the variants to have the new MAC:
Changed_variants <- new_variant_macs(original_variants, new_MAC = new_MAC$New_mac)

dim(Changed_variants)  ## sanity check
rowSums(Changed_variants) ## sanity check

# The file needs to be written for the next step:
fwrite(Changed_variants, 'Variants2Update.txt', row.names = FALSE,
            col.names = FALSE, quote  = FALSE, sep  = ' ')

### need to be in the correct working directory for this:

line_nos <- new_MAC$line
repl_lines <-readLines('Variants2Update.txt')

update_hap_files(con1, con2, repl_lines, line_nos)






