





library(RAREsim)

### total number of variants in the region
exp_var <- reg_size*nvariant(N = nsim, pop = pop)

### minor allele frequencies
maf1 <- floor(0.01*(2*nsim))
maf0.5 <- floor(maf1/2)
maf0.25 <- floor(maf0.5/2)

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

### write file with variants to prune by removing
write.table(bin_estimates, 'MAC_bin_estimates.txt', row.names=F, quote=F,
            sep = '\t')

