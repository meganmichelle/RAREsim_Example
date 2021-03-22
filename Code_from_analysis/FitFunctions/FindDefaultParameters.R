#############
# Calculate the default parameters
#############

# Number of Variants function
######

### Load in the target data:
setwd("/Users/megansorenson/Documents/Package/RAREsim_Example/Code_from_analysis/")
df <- read.table('NumberOfVariantsTargetData.txt', header  = TRUE,
                 sep =  '\t')

### For each population and (down)sample size, extract the median observation:
me_re<- c()
for(j in c('sas', 'nfe', 'eas', 'afr')){
  temp <- df[which(df$pop  == j),]
  ds <- levels(droplevels(as.factor(temp$downsample)))
  for(k in 1:length(ds)){
    tmp <- temp[which(temp$downsample == ds[k]),]
    n <- median(tmp$per_kb)#### this needs to be recoreded witht the pop and downsample size
    tmp <- c('median' ,j, ds[k],n)
    me_re <- rbind(me_re,tmp)
  }
}
colnames(me_re) <- c('block', 'pop', 'downsample','per_kb')
me_re <- as.data.frame(me_re)
me_re$downsample <- as.numeric(as.character(me_re$downsample))
me_re$per_kb <- as.numeric(as.character(me_re$per_kb))

### Fit the function to find the default parameters:
library(RAREsim)

me_re$phi <- '.'
me_re$omega <- '.'

for(pop in c('afr', 'eas', 'nfe', 'sas')){
  temp <- me_re[which(me_re$pop == pop),]
    re <- fit_nvariant(temp[,c(3,4)])
    me_re$phi[which(me_re$pop == pop )] <- re$phi
    me_re$omega[which(me_re$pop == pop)] <- re$omega
}

### subset to the 4 ancestries:
results<-me_re[which(me_re$downsample == 10),c(2,5,6)]
results

# Allele Frequency Spectrum function
####

### Load in the information from  each block
setwd("/Users/megansorenson/Documents/Package/RAREsim_Example/Code_from_analysis/")
afp <- read.table('AFS_blocks_fitted_and_observed.txt',
                  header  = TRUE)

### pull the median observation
med_afs<- as.data.frame(matrix(nrow = 4, ncol = 9))
colnames(med_afs) <- c('block', 'pop', colnames(afp)[2:8])
med_afs$block <- 'median'
med_afs$pop <- c('SAS', 'NFE', 'EAS', 'AFR')
for(j in 1:4){
  pop <- med_afs$pop[j]
  df <- afp[which(afp$pop  == pop),]
  df <- df[,1:12]
  for(k in 2:8){
    med_afs[j,(k+1)] <- median(df[,k])
  }
}

med_afs$total <- rowSums(med_afs[3:9])
med_afs$N <- c(15308, 56885,  9197, 8128 )


library(RAREsim)

### create the MAC  bins for each ancestry
loop1 <- as.data.frame(matrix(nrow=7,  ncol = 2))
colnames(loop1) <- c('Lower', 'Upper')
loop1$Lower <- c(1,2,3,6,11,21,'.')
loop1$Upper <- c(1,2,5,10,20,'.','.')

mac_afr <- loop1
N <- 8128
N005 <- floor(0.005*2*N)
mac_afr$Upper[6] <- N005
mac_afr$Lower[7] <- N005 + 1
N01 <- floor(0.01*2*N)
mac_afr$Upper[7] <- N01
mac_afr$Lower <- as.numeric(mac_afr$Lower)
mac_afr$Upper <- as.numeric(mac_afr$Upper)

mac_eas <- loop1
N <- 9197
N005 <- floor(0.005*2*N)
mac_eas$Upper[6] <- N005
mac_eas$Lower[7] <- N005 + 1
N01 <- floor(0.01*2*N)
mac_eas$Upper[7] <- N01
mac_eas$Lower <- as.numeric(mac_eas$Lower)
mac_eas$Upper <- as.numeric(mac_eas$Upper)

mac_nfe <- loop1
N <- 56885
N005 <- floor(0.005*2*N)
mac_nfe$Upper[6] <- N005
mac_nfe$Lower[7] <- N005 + 1
N01 <- floor(0.01*2*N)
mac_nfe$Upper[7] <- N01
mac_nfe$Lower <- as.numeric(mac_nfe$Lower)
mac_nfe$Upper <- as.numeric(mac_nfe$Upper)

mac_sas <- loop1
N <- 15308
N005 <- floor(0.005*2*N)
mac_sas$Upper[6] <- N005
mac_sas$Lower[7] <- N005 + 1
N01 <- floor(0.01*2*N)
mac_sas$Upper[7] <- N01
mac_sas$Lower <- as.numeric(mac_sas$Lower)
mac_sas$Upper <- as.numeric(mac_sas$Upper)

###  Add the Proportion of variants
mac_sas$Prop <- t(med_afs[1,3:9])
mac_nfe$Prop <- t(med_afs[2,3:9])
mac_eas$Prop <- t(med_afs[3,3:9])
mac_afr$Prop <- t(med_afs[4,3:9])

###  Calculate  the  default parameters
fit_afs(mac_afr)
fit_afs(mac_eas)
fit_afs(mac_nfe)
fit_afs(mac_sas)



