#######################
#### Look at the other chromosomes
#### Compare to the ones we fit with default parameters
#######################

setwd('/Users/megansorenson/Documents/Package/RAREsim_Example/Code_from_analysis/DefaultParameterEvaluation/OtherChromosomes/')
fit <- as.data.frame(matrix(nrow = 4, ncol = 2))
colnames(fit) <-  c('pop', 'N')
head(fit)

fit$pop <- c('AFR', 'EAS', 'NFE',  'SAS')
fit$N  <- c(8128, 9197, 56885, 15308)
fit

mac_template <- as.data.frame(matrix(nrow=100, ncol = 10))

colnames(mac_template) <- c('block', 'pop', 'Singletons', 'Doubletons', 'MAC=3-5',
                            'MAC=6-10', 'MAC=11-20', 
                            'MAC=21-MAF005',
                            'MAF005-MAF01', 'rep')

#### loop defines the bins
loop <- as.data.frame(matrix(nrow=7,  ncol = 2))
colnames(loop) <- c('Start', 'End')
loop$Start <- c(1,2,3,6,11,21,'.')
loop$End <- c(1,2,5,10,20,'.','.')



mac2  <- read.table('Chromosome_comparison_gnomAD_data.txt',
                    header = TRUE)
head(mac2)

library(RAREsim)
### set up a dataframe to record the results:
all <-  as.data.frame(matrix(nrow = 12,  ncol = 9))
colnames(all) <- c('pop', 'chr', 'Singletons', 'Doubletons',
                   'MAC=3-5', 'MAC=6-10', 'MAC=11-20', 'MAC=21-MAF=0.5%',
                   'MAF=0.5%=1%')
all$pop <- c('AFR', 'EAS', 'NFE', 'SAS')
all$chr<- c(1,1,1,1,6,6,6,6,9,9,9,9)

## Chr 1
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


afr <- expected_variants(Total_num_var =
                           24.918*nvariant(pop = 'AFR', N=8128),
                         mac_bin_prop = afs(mac_bins = mac_afr, pop = 'AFR'))
eas <- expected_variants(Total_num_var =
                           24.918*nvariant(pop = 'EAS', N=9197),
                         mac_bin_prop = afs(mac_bins = mac_eas, pop = 'EAS'))
nfe <- expected_variants(Total_num_var =
                           24.918*nvariant(pop = 'NFE', N=56885),
                         mac_bin_prop = afs(mac_bins = mac_nfe, pop = 'NFE'))
sas <- expected_variants(Total_num_var =
                           24.918*nvariant(pop = 'SAS', N=15308),
                         mac_bin_prop = afs(mac_bins = mac_sas, pop = 'SAS'))


all[1,3:9] <- afr$Expected_var
all[2,3:9] <- eas$Expected_var
all[3,3:9] <- nfe$Expected_var
all[4,3:9] <- sas$Expected_var

## Chr 6
afr <- expected_variants(Total_num_var =
                           12.519*nvariant(pop = 'AFR', N=8128),
                         mac_bin_prop = afs(mac_bins = mac_afr, pop = 'AFR'))
eas <- expected_variants(Total_num_var =
                           12.519*nvariant(pop = 'EAS', N=9197),
                         mac_bin_prop = afs(mac_bins = mac_eas, pop = 'EAS'))
nfe <- expected_variants(Total_num_var =
                           12.519*nvariant(pop = 'NFE', N=56885),
                         mac_bin_prop = afs(mac_bins = mac_nfe, pop = 'NFE'))
sas <- expected_variants(Total_num_var =
                           12.519*nvariant(pop = 'SAS', N=15308),
                         mac_bin_prop = afs(mac_bins = mac_sas, pop = 'SAS'))


all[5,3:9] <- afr$Expected_var
all[6,3:9] <- eas$Expected_var
all[7,3:9] <- nfe$Expected_var
all[8,3:9] <- sas$Expected_var

## Chr 9
afr <- expected_variants(Total_num_var =
                           17.051*nvariant(pop = 'AFR', N=8128),
                         mac_bin_prop = afs(mac_bins = mac_afr, pop = 'AFR'))
eas <- expected_variants(Total_num_var =
                           17.051*nvariant(pop = 'EAS', N=9197),
                         mac_bin_prop = afs(mac_bins = mac_eas, pop = 'EAS'))
nfe <- expected_variants(Total_num_var =
                           17.051*nvariant(pop = 'NFE', N=56885),
                         mac_bin_prop = afs(mac_bins = mac_nfe, pop = 'NFE'))
sas <- expected_variants(Total_num_var =
                           17.051*nvariant(pop = 'SAS', N=15308),
                         mac_bin_prop = afs(mac_bins = mac_sas, pop = 'SAS'))


all[9,3:9] <- afr$Expected_var
all[10,3:9] <- eas$Expected_var
all[11,3:9] <- nfe$Expected_var
all[12,3:9] <- sas$Expected_var

### Code to calculate - results below

# mac3 <- c()
# for(pop in c('EAS', 'SAS', 'AFR', 'NFE')){ 
#   N <- fit$N[which(fit$pop == pop)]
#   N005 <- floor(0.005*2*N)
#   loop$End[6] <- N005
#   loop$Start[7] <- N005 + 1
#   N01 <- floor(0.01*2*N)
#   loop$End[7] <- N01
#   loop$Start <- as.numeric(loop$Start)
#   loop$End <- as.numeric(loop$End)
#   for(bl in  c(1,6,9)){
#     mac <- mac_template
#     mac$block <- bl
#     mac$pop <- pop
#     
#     for(rep in c(1:100)){
#       rem_all<-c()
#       change_all <-  c() 
#       temp <- read.table(paste0(pop,'/Chr',bl,'.Rep', rep,'.count.txt'))
#       temp$num <-  1:nrow(temp)
#       for(k in nrow(loop):1){
#         tmp <-  temp[which(temp$V1 >= loop$Start[k] & temp$V1 <= loop$End[k]),]
#         ##### if there are not any SNVs in the bin, tmp is all NA's...
#         n1 <- nrow(tmp)
#         expect <- all[which(all$pop == pop & all$chr == bl),k+2]  ##expected
#         #print(expect)
#         if(n1>0){
#           p <- expect/n1
#         }else{
#           if(expect < 1){next}
#           if(expect >=1){
#             p <- expect
#           }
#         }
#         if(p <= 1){
#           
#           rd <- runif(n1)
#           
#           rem <- tmp[c(which(rd >= p)),]
#           
#           #print(rem)
#           ### now need to keep these ones...
#           
#           rem_all <- rbind(rem_all, rem)
#           
#         }
#         if(p>1){
#           if(k==7){
#             next}
#           n2 <- expect  - n1 ### n2 is how many more we need
#           p1 <- n2/nrow(rem_all)  ### this is the proportion from rem_all
#           rem_all$rd <- runif(nrow(rem_all))
#           to_change <- rem_all[which(rem_all$rd  <= p1),]
#           mac_range <-  c(loop$Start[k]:loop$End[k])
#           to_change$new_MAC <- sample(mac_range, nrow(to_change),
#                                       replace = TRUE)
#           ### change them within the MAC file.
#           ####  this needs to change for the haplotype file!!!
#           temp$V1[which(temp$num %in% to_change$num)]<- to_change$new_MAC
#           rem_all <- rem_all[which(rem_all$rd > p1),]
#           change_all<- rbind(change_all,  to_change)
#         }
#       }
#       temp <- temp[-c(rem_all$num),]
#       
#       ##### At this point, set rem_all to all reference alleles in haplotype files
#       ##### And set change_all to the given MAC
#       
#       #####  ok, now I need the allele count to add to the plot
#       for(k in 1:nrow(loop)){
#         tmp <-  temp[which(temp$V1 >= loop$Start[k] & temp$V1 <= loop$End[k]),]
#         n1 <- nrow(tmp)
#         mac[rep,k+2] <- n1
#       }
#       mac$rep[rep] <- rep
#     }
#     mac3  <- rbind(mac3,mac)
#     
#   }
# }
# 
# mac3$data <- 'RAREsim'

mac3 <- read.table('RAREsim_results_chromosome_comparison.txt',
                   header = TRUE)


head(mac3)
names(mac2)

mac3$rep <- as.character(mac3$rep)
mac2$rep <- as.character(mac2$rep)

mac <- rbind(mac2, mac3)


#######  separate  the observed from the simulations
####### renames  the percentages

table(mac$data)
gnom <-  mac[which(mac$data == 'gnomAD'),]
mac  <-  mac[-c(which(mac$data == 'gnomAD')),]

library(reshape2)
melted_mac <- melt(mac, id = c('block', 'pop', 'data', 'rep'))
head(melted_mac)
table(melted_mac$pop, melted_mac$data)

melted_gnom <-melt(gnom, id = c('block', 'pop', 'data', 'rep'))


library(ggplot2)
#### pretty plots:
cbPalette <- c( "#56B4E9", "#CC79A7","#009E73", "#E69F00", 
                "#0072B2",
                "#D55E00")

melted_mac$data <- as.character(melted_mac$data)
melted_mac$data[which(melted_mac$data  == 'HAPGEN2 default')] <- 'HAPGEN2 with polymorphic SNVs'

melted_mac1 <- melted_mac[which(melted_mac$data == 'RAREsim'),]
setwd('/Users/megansorenson/Documents/RAREsim/Chrom_comp')
for(bl in c(1,6,9)){
  mm <- melted_mac1[which(melted_mac1$block  == bl),]
  gm <-  melted_gnom[which(melted_gnom$block == bl),]
  
  pop <- 'AFR'
  p1 <- ggplot(mm[which(mm$pop == pop),], 
               aes(x=variable, y=value , col = data)) +
    geom_boxplot() + 
    labs(y = 'Number of Variants', x = 'MAC Bin')+
    theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
    geom_point(data=gm[which(gm$pop == pop),],
               aes(x=variable, y=value), shape  = 8, size =  2.1)+
    theme(legend.position="bottom" )+
    theme(legend.title = element_blank()) +
    theme(axis.title.x = element_blank())+
    scale_color_manual(values=cbPalette)+
    theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
  
  
  pop <- 'EAS'
  p2 <- ggplot(mm[which(mm$pop == pop),], 
               aes(x=variable, y=value , col = data)) +
    geom_boxplot() + 
    labs(y = 'Number of Variants', x = 'MAC Bin')+
    theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
    geom_point(data=gm[which(gm$pop == pop),],
               aes(x=variable, y=value), shape  = 8, size = 2.1)+
    theme(legend.position="bottom" )+
    theme(legend.title = element_blank()) +
    theme(axis.title.x = element_blank())+
    scale_color_manual(values=cbPalette)+
    theme(axis.title.y = element_blank())+
    theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
  
  
  pop <- 'NFE'
  p3 <- ggplot(mm[which(mm$pop == pop),], 
               aes(x=variable, y=value , col = data)) +
    geom_boxplot() + 
    labs(y = 'Number of Variants', x = 'MAC Bin')+
    theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
    geom_point(data=gm[which(gm$pop == pop),],
               aes(x=variable, y=value), shape  = 8, size =  2.1)+
    theme(legend.position="bottom" )+
    theme(legend.title = element_blank()) +
    theme(axis.title.x = element_blank())+
    scale_color_manual(values=cbPalette)+
    theme(axis.title.y = element_blank())+
    theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
  
  pop <- 'SAS'
  p4 <- ggplot(mm[which(mm$pop == pop),], 
               aes(x=variable, y=value , col = data)) +
    geom_boxplot() + 
    labs(y = 'Number of Variants', x = 'MAC Bin')+
    theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
    geom_point(data=gm[which(gm$pop == pop),],
               aes(x=variable, y=value), shape  = 8, size =  2.1)+
    theme(legend.position="bottom" )+
    theme(legend.title = element_blank()) +
    theme(axis.title.x = element_blank())+
    theme(axis.title.y = element_blank())+
    scale_color_manual(values=cbPalette)+
    theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
  
  g_legend<-function(a.gplot){
    tmp <- ggplot_gtable(ggplot_build(a.gplot))
    leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
    legend <- tmp$grobs[[leg]]
    return(legend)}
  
  mylegend<-g_legend(p1)
  
  p5 <- grid.arrange(arrangeGrob(p1 + theme(legend.position="none"),
                                 p2 + theme(legend.position="none"),
                                 p3 + theme(legend.position="none"),
                                 p4 + theme(legend.position="none"),
                                 nrow=1),
                     mylegend, nrow=2,heights=c(10, 1.1))
  ##### so the legend has it's own 'row'
  
  
  # ggsave(file = paste0('Chr',bl,'.jpg'),
  #        plot = p5, height = 5, width = 8, units = 'in')
  
}



#### for figure 4:
bl=6
mm <- melted_mac1[which(melted_mac1$block  == bl),]
gm <-  melted_gnom[which(melted_gnom$block == bl),]
gm1 <- gm
gm1$data <- 'gnomADv2.1 SAS Chr 6' 
pop='SAS'

p1a <- ggplot(mm[which(mm$pop == pop),], 
              aes(x=variable, y=value , col = data)) +
  geom_boxplot() + 
  labs(y = 'Number of Variants', x = 'MAC Bin')+
  theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
  geom_point(data=gm1[which(gm1$pop == pop),],
             aes(x=variable, y=value), shape  = 8, size =  2.1)+
  theme(legend.position="bottom" )+
  theme(legend.title = element_blank()) +
  theme(axis.title.x = element_blank())+
  scale_color_manual(values=cbPalette)+
  theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm")) +
  guides(col = guide_legend(nrow = 2, byrow = TRUE))
p1a

