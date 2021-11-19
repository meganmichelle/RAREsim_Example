# Calculate Expected Number of Variant

library(RAREsim)

# Sample sizes to  simulate
Nafr <- 2*8128
Neas <- 2*9197
Nnfe <- 2*56885
Nsas <- 2*15308

# NFE

Nsim <- Nnfe

# Create the MAC bins
maf1 = floor(0.01*(2*Nsim))
maf0.5 = floor(maf1/2)
maf0.25 = maf0.5/2

mac = data.frame(Lower = c(1, 2, 3, 6, 11, 21, maf0.5+1),
                   Upper = c(1, 2, 5, 10, 20, maf0.5, maf1))
bin = c("1", "2", "3-5", "6-10", "11-20", paste0(21, "-", maf0.5), 
        paste0(maf0.5+1, "-", maf1))


# Calculate Expected
nfe_ex <- expected_variants(Total_num_var = 19.029*nvariant(pop = 'NFE',
                                                  N = Nnfe),
                  mac_bin_prop = afs(pop='NFE', mac_bins = mac))

# Write the table to be used in the python package
write.table(nfe_ex, 'Expected_variants_NFE_twice_gnomAD.txt',
            row.names = FALSE, sep = '\t', quote = FALSE)


# AFR

# Create the MAC bins
Nsim <- Nafr
maf1 = floor(0.01*(2*Nsim))
maf0.5 = floor(maf1/2)
maf0.25 = maf0.5/2

mac = data.frame(Lower = c(1, 2, 3, 6, 11, 21, maf0.5+1),
                 Upper = c(1, 2, 5, 10, 20, maf0.5, maf1))
bin = c("1", "2", "3-5", "6-10", "11-20", paste0(21, "-", maf0.5), paste0(maf0.5+1, "-", maf1))

# Calculate Expected
afr_ex <- expected_variants(Total_num_var = 19.029*nvariant(pop = 'AFR',
                                                            N = Nafr),
                            mac_bin_prop = afs(pop='AFR', mac_bins = mac))

# Write the table to be used in the python package
write.table(afr_ex, 'Expected_variants_AFR_twice_gnomAD.txt',
            row.names = FALSE, sep = '\t', quote = FALSE)

# EAS

# Create the MAC bins
Nsim <- Neas
maf1 = floor(0.01*(2*Nsim))
maf0.5 = floor(maf1/2)
maf0.25 = maf0.5/2

mac = data.frame(Lower = c(1, 2, 3, 6, 11, 21, maf0.5+1),
                 Upper = c(1, 2, 5, 10, 20, maf0.5, maf1))
bin = c("1", "2", "3-5", "6-10", "11-20", paste0(21, "-", maf0.5), paste0(maf0.5+1, "-", maf1))

# Calculate Expected
eas_ex <- expected_variants(Total_num_var = 19.029*nvariant(pop = 'EAS',
                                                            N = Neas),
                            mac_bin_prop = afs(pop='EAS', mac_bins = mac))

# Write the table to be used in the python package
write.table(eas_ex, 'Expected_variants_EAS_twice_gnomAD.txt',
            row.names = FALSE, sep = '\t', quote = FALSE)
            
            
# SAS

# Create the MAC bins
Nsim <- Nsas
maf1 = floor(0.01*(2*Nsim))
maf0.5 = floor(maf1/2)
maf0.25 = maf0.5/2

mac = data.frame(Lower = c(1, 2, 3, 6, 11, 21, maf0.5+1),
                 Upper = c(1, 2, 5, 10, 20, maf0.5, maf1))
bin = c("1", "2", "3-5", "6-10", "11-20", paste0(21, "-", maf0.5), paste0(maf0.5+1, "-", maf1))

# Calculate Expected
sas_ex <- expected_variants(Total_num_var = 19.029*nvariant(pop = 'SAS',
                                                            N = Nsas),
                            mac_bin_prop = afs(pop='SAS', mac_bins = mac))

# Write the table to be used in the python package
write.table(sas_ex, 'Expected_variants_SAS_twice_gnomAD.txt',
            row.names = FALSE, sep = '\t', quote = FALSE)
