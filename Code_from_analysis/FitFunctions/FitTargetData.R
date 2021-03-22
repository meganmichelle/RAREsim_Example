##############
### Fit the Target Data
##############

## Number of variants function

### Load in the target data:
setwd("/Users/megansorenson/Documents/Package/RAREsim_Example/Code_from_analysis/FitFunctions/")
df <- read.table('NumberOfVariantsTargetData.txt', header  = TRUE,
                  sep =  '\t')
df$obs_all <-  as.numeric(df$obs_all)
df$downsample <-  as.numeric(as.character(df$downsample))

### Fit the function
library(RAREsim)

### Create a list of blocks to loop through
blocks <- levels(as.factor(as.character(df$block)))

### placeholder for phi and omega
df$phi <- '.'
df$omega <- '.'

## Loop through each population and block, fitting the target data:
for( pop in c('afr', 'eas', 'nfe', 'sas')){
  temp <- df[which(df$pop == pop),]
  for(bl in blocks){
    tmp <- temp[which(temp$block == bl),]
    re <- fit_nvariant(tmp[,c(3,7)])
    df$phi[which(df$pop == pop & df$block == bl)] <- re$phi
    df$omega[which(df$pop == pop & df$block == bl)] <- re$omega
  }
}

summary(as.numeric(df$phi))

### Allele frequency spectrum function
afp <- read.table('AFS_TargetData.txt', header = TRUE)
head(afp)


afp$alpha <- '.'
afp$beta <-  '.'
afp$b <- '.'

library(RAREsim)
### we need the MAC bins
### minor allele count bins

## afr
n=8128
maf1 <- floor(0.01*(2*n))
maf0.5 <- floor(0.005*(2*n))
mac <- data.frame(Lower = c(1, 2, 3, 6, 11, 21, maf0.5+1),
                  Upper = c(1, 2, 5, 10, 20, maf0.5, maf1))


temp <- afp[which(afp$pop == 'AFR'),]
for(i in 1:nrow(temp)){
  mac$Prop <- t(temp[i,c(2:8)])
  re <- fit_afs(mac)
  afp$alpha[which(afp$block == afp$block[i] &
                     afp$pop == 'AFR')] <- re$alpha
  afp$beta[which(afp$block == temp$block[i] &
                    afp$pop == 'AFR')] <- re$beta
  afp$b[which(afp$block == temp$block[i] &
                 afp$pop == 'AFR')] <- re$b
}

### EAS
### minor allele count bins
n=9197
maf1 <- floor(0.01*(2*n))
maf0.5 <- floor(0.005*(2*n))
mac <- data.frame(Lower = c(1, 2, 3, 6, 11, 21, maf0.5+1),
                  Upper = c(1, 2, 5, 10, 20, maf0.5, maf1))

temp <- afp[which(afp$pop == 'EAS'),]
for(i in 1:nrow(temp)){
  mac$Prop <- t(temp[i,c(2:8)])
  re <- fit_afs(mac)
  afp$alpha[which(afp$block == temp$block[i] &
                     afp$pop == 'EAS')] <- re$alpha
  afp$beta[which(afp$block == temp$block[i] &
                    afp$pop == 'EAS')] <- re$beta
  afp$b[which(afp$block == temp$block[i] &
                 afp$pop == 'EAS')] <- re$b
}

### NFE

n=56885
maf1 <- floor(0.01*(2*n))
maf0.5 <- floor(0.005*(2*n))

### minor allele count bins

mac <- data.frame(Lower = c(1, 2, 3, 6, 11, 21, maf0.5+1),
                  Upper = c(1, 2, 5, 10, 20, maf0.5, maf1))

temp <- afp[which(afp$pop == 'NFE'),]
for(i in 1:nrow(temp)){
  mac$Prop <- t(temp[i,c(2:8)])
  re <- fit_afs(mac)
  afp$alpha[which(afp$block == temp$block[i] &
                     afp$pop == 'NFE')] <- re$alpha
  afp$beta[which(afp$block == temp$block[i] &
                    afp$pop == 'NFE')] <- re$beta
  afp$b[which(afp$block == temp$block[i] &
                 afp$pop == 'NFE')] <- re$b
}

## SAS

n=15308
maf1 <- floor(0.01*(2*n))
maf0.5 <-  floor(0.005*(2*n))

### minor allele count bins

mac <- data.frame(Lower = c(1, 2, 3, 6, 11, 21, maf0.5+1),
                  Upper = c(1, 2, 5, 10, 20, maf0.5, maf1))

temp <- afp[which(afp$pop == 'SAS'),]
for(i in 1:nrow(temp)){
  mac$Prop <- t(temp[i,c(2:8)])
  re <- fit_afs(mac)
  afp$alpha[which(afp$block == temp$block[i] &
                     afp$pop == 'SAS')] <- re$alpha
  afp$beta[which(afp$block == temp$block[i] &
                    afp$pop == 'SAS')] <- re$beta
  afp$b[which(afp$block == temp$block[i] &
                 afp$pop == 'SAS')] <- re$b
}

head(afp)
afp$beta <- as.numeric(as.character(afp$beta))
afp$b<- as.numeric(as.character(afp$b))
afp$alpha <- as.numeric(as.character(afp$alpha))

### To calculate fitted singletons:
head(afp$b/((1+afp$beta)^afp$alpha))


