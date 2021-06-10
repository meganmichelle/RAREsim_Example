





library(RAREsim)

### total number of variants in the region
exp_var <- reg_size*nvariant(N = nsim, pop = pop)

### minor allele frequencies
maf1 <- round(0.01*(2*nsim))
maf0.5 <- maf1/2
maf0.25 <- maf0.5/2

### minor allele count bins
if (nsim > 3500){
  mac <- data.frame(Lower = c(1, 2, 3, 6, 11, 21, maf0.5+1),
                    Upper = c(1, 2, 5, 10, 20, maf0.5, maf1))
} else {
  mac <- data.frame(Lower = c(1, 2, 3, 6, maf0.25+1, maf0.5+1),
                    Upper = c(1, 2, 5, maf0.25, maf0.5, maf1))
}

### allele frequency spectrum function
bin_props <- afs(mac_bins = mac, pop = pop)

### expected number of variants per bin
bin_estimates <- expected_variants(Total_num_var = exp_var, mac_bin_prop = bin_props)

### prune variants function
count <- read.table(count_file, header=F)
ToPrune <- prune_variants(MAC = count, expected = bin_estimates)

### write file with variants to prune by removing
prune_file <- paste0(substr(count_file, 1, nchar(count_file)-10),  '_ToPrune.txt')
write.table(ToPrune$ToRemove, prune_file, row.names=F, quote=F)

### Write file with the variants to prune a subset of alternate alleles
if(is.null(ToPrune$ToChange) == FALSE){
subset_file <- paste0(substr(count_file, 1, nchar(count_file)-10),  '.SubsetAA.txt')
write.table(ToPrune$ToChange, subset_file, row.names=F, quote=F)
}
