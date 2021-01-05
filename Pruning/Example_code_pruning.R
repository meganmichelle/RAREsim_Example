#####
# Pruning Example - R portion
#####

library(RAREsim)

original_variants <- read.table(file = original_variants_file,
                                header = FALSE)

new_MAC <- read.table(file = new_mac_file,
                      header = TRUE)

# Edit the variants to have the new MAC:
Changed_variants <- new_variant_macs(original_variants, new_MAC = new_MAC$New_mac)

dim(Changed_variants)  ## sanity check
rowSums(Changed_variants) ## sanity check

# The file needs to be written for the next step:
write.table(Changed_variants, 'Variants2Update.txt', row.names = FALSE,
            col.names = FALSE, quote  = FALSE, sep  = ' ')

### need to be in the correct working directory for this:

line_nos <- new_MAC$line
repl_lines <-readLines('Variants2Update.txt')

update_hap_files(con1, con2, repl_lines, line_nos)

### Then delete the other variants with new MAC = 0

ToDel <- read.table(file = ToDel_file, header = TRUE)

ToDel <- ToDel[which(ToDel$New_mac == 0),]

create_delete_list(ToDel$line)






