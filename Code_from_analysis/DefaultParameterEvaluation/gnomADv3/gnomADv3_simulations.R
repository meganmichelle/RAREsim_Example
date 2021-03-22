###############
#### Default parameter comparison
##### gnomADv3 intergenic region
###############

### load in gnomAD
gnom_nfe <- read.table('NFE_gnomAD_cds_and_intergenic.txt', header = TRUE,
                       sep = '\t')
gnom_afr<- read.table('AFR_gnomAD_cds_and_intergenic.txt', header = TRUE,
                      sep = '\t')

#### first the CDS
#### we expect this to be alright!

# mac_template <- as.data.frame(matrix(nrow=100, ncol = 10))
# 
# colnames(mac_template) <- c('block', 'pop', 'Singletons', 'Doubletons', 'MAC=3-5',
#                             'MAC=6-10', 'MAC=11-20', 
#                             'MAC=21-MAF005',
#                             'MAF005-MAF01', 'rep')
# 
# #### loop defines the bins
# loop <- as.data.frame(matrix(nrow=7,  ncol = 2))
# colnames(loop) <- c('Start', 'End')
# loop$Start <- c(1,2,3,6,11,21,'.')
# loop$End <- c(1,2,5,10,20,'.','.')

#### RAREsim with default parameters:

# to_fit_d <- read.table('Expected_default.txt', header = TRUE,
#                        sep = '\t')
# ###### and now with the default parameters:
# setwd('/Users/megansorenson/Documents/RAREsim/Intergenic_region/Simulated/intergenic/')
# ##### and now intergenic
# mac4 <- c()
# set.seed(12345)
# ### first cds
# for(pop in c('AFR', 'NFE')){
#   N <- to_fit_d$N[which(to_fit_d$Pop == pop & to_fit_d$block  == 37)]
#   N005 <- floor(0.005*2*N)
#   loop$End[6] <- N005
#   loop$Start[7] <- N005 + 1
#   N01 <- floor(0.01*2*N)
#   loop$End[7] <- N01
#   loop$Start <- as.numeric(loop$Start)
#   loop$End <- as.numeric(loop$End)
#   for(bl in  c(56,37,66)){
#     mac <- mac_template
#     mac$block <- bl
#     mac$pop <- pop
#     for(rep in c(1:100)){
#       rem_all<-c()
#       change_all <-  c()
#       temp <- read.table(paste0(pop,'_block',bl,'/Block', bl, '.Rep', rep,'.count.txt'),
#                          header = FALSE,skipNul = TRUE)
#       temp <- as.data.frame(temp)
#       temp$num <-  1:nrow(temp)
#       for(k in nrow(loop):1){
#         tmp <-  temp[which(temp$V1 >= loop$Start[k] & temp$V1 <= loop$End[k]),]
#         ##### if there are not any SNVs in the bin, tmp is all NA's...
#         n1 <- nrow(tmp)
#         expect <- to_fit_d[which(to_fit_d$Pop == pop & to_fit_d$block == bl),k+2]  ##expected
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
#             if((expect-n1) >2){
#               print(c('Error!', pop, bl,n1, expect, (n1-expect)))}
#             next}
#           if(length(rem_all)>0){
#             n2 <- expect  - n1 ### n2 is how many more we need
#             p1 <- n2/nrow(rem_all)  ### this is the proportion from rem_all
#             rem_all$rd <- runif(nrow(rem_all))
#             to_change <- rem_all[which(rem_all$rd  <= p1),]
#             mac_range <-  c(loop$Start[k]:loop$End[k])
#             to_change$new_MAC <- sample(mac_range, nrow(to_change),
#                                         replace = TRUE)
#             ### change them within the MAC file.
#             ####  this needs to change for the haplotype file!!!
#             temp$V1[which(temp$num %in% to_change$num)]<- to_change$new_MAC
#             rem_all <- rem_all[which(rem_all$rd > p1),]
#             change_all<- rbind(change_all,  to_change)
#           }else{
#             print('Error2')
#             next}
#         }
#       }
# 
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
#     mac4  <- rbind(mac4,mac)
# 
#   }
# }
# 
# mac4$data  <- 'RAREsim_intergenic_default'
# 
# write.table(mac4, 'All_RAREsim_intergenic_default_AC_information.txt',
#             row.names  = FALSE, sep = '\t', quote = FALSE)

setwd('/Users/megansorenson/Documents/RAREsim/Intergenic_region/Simulated/intergenic')
mac<- read.table('All_RAREsim_intergenic_default_AC_information.txt',
                   header  = TRUE)



head(gnom_afr)
gnom_afr$data <- paste0('gnomAD', gnom_afr$Int_cds)
gnom_afr$pop <- 'AFR'
gnom_nfe$data <- paste0('gnomAD', gnom_afr$Int_cds)
gnom_nfe$pop <- 'NFE'
names(mac)
names(gnom_afr)

gnom <- rbind(gnom_afr, gnom_nfe)
gnom$rep <- '.'
names(gnom)
names(mac)

gnom  <- gnom[,c(2,12,3:9,13,11)]
colnames(gnom)  <- colnames(mac)

mac <- rbind(mac,  gnom)

head(mac)
colnames(mac)[8:9] <-  c('MAC=21-MAF=0.5%', 'MAF=0.5%-1%')
colnames(gnom)[8:9] <-  c('MAC=21-MAF=0.5%', 'MAF=0.5%-1%')


table(mac$data)

mac$data <- as.character(mac$data)
table(mac$data)

mac$data[which(mac$data == 'gnomADint')] <- 'gnomAD intergenic region'
mac$data[which(mac$data == 'RAREsim_intergenic_default')] <- 'RAREsim default parameters intergenic region'

#### only do the default parameters and  gnomAD

head(mac)
mac <- mac[-c(which(mac$data == 'gnomAD coding region')),]

colnames(mac)[5:7] <- c('MAC=3-5', 'MAC=6-10', 'MAC=11-20')

library(reshape2)
melted_mac1 <- melt(mac, id = c('block', 'pop', 'data', 'rep'))
head(melted_mac)
table(melted_mac$pop, melted_mac$data)

###### make this so each population is one color, light and dark

table(melted_mac$data)
##### change the MAC

#### change the colors
cbPalette <- c(   "#56B4E9","#CC79A7","#009E73", "#E69F00", 
                  "#0072B2",
                  "#D55E00")

#### change the names
melted_mac1$data <- as.character(melted_mac1$data)
melted_mac1$data[which(melted_mac1$data == 'gnomAD intergenic region')] <- 'gnomADv3 intergenic'
melted_mac1$data[which(melted_mac1$data == 'RAREsim default parameters intergenic region')] <- 'RAREsim'

#### then also just show default parameters
table(melted_mac1$data)

library(ggplot2)
setwd('/Users/megansorenson/Documents/RAREsim/Intergenic_region/Simulated/')
for(pop in c('AFR', 'NFE')){
  
  bl=56
  mm <- melted_mac1[which(melted_mac1$block  == bl & 
                            melted_mac1$data == 'RAREsim'),]
  mg <- melted_mac1[which(melted_mac1$block  == bl),]
  mg <- mg[-c(which(mg$data == 'RAREsim')),]
  
  p1 <- ggplot(mm[which(mm$pop == pop),], 
               aes(x=variable, y=value , col = data)) +
    geom_boxplot() + 
    labs(y = 'Number of Variants', x = 'MAC Bin')+
    theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
    geom_point(data=mg[which(mg$pop  == pop),],
               aes(x=variable, y=value), shape  = 8, size = 2.1) +
    theme(legend.position="bottom" )+
    theme(legend.title = element_blank()) +
    theme(axis.title.x = element_blank())+
    scale_color_manual(values=cbPalette)+
    theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
  
  bl=37
  mm <- melted_mac1[which(melted_mac1$block  == bl & 
                            melted_mac1$data == 'RAREsim'),]
  mg <- melted_mac1[which(melted_mac1$block  == bl),]
  mg <- mg[-c(which(mg$data == 'RAREsim')),]
  
  p2 <- ggplot(mm[which(mm$pop == pop),], 
               aes(x=variable, y=value , col = data)) +
    geom_boxplot() + 
    labs(y = 'Number of Variants', x = 'MAC Bin')+
    theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
    geom_point(data=mg[which(mg$pop  == pop),],
               aes(x=variable, y=value), shape  = 8, size = 2.1) +
    theme(legend.position="bottom" )+
    theme(legend.title = element_blank()) +
    theme(axis.title.y = element_blank())+
    theme(axis.title.x = element_blank())+
    scale_color_manual(values=cbPalette)+
    theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
  
  bl=66
  mm <- melted_mac1[which(melted_mac1$block  == bl & 
                            melted_mac1$data == 'RAREsim'),]
  mg <- melted_mac1[which(melted_mac1$block  == bl),]
  mg <- mg[-c(which(mg$data == 'RAREsim')),]
  
  p3 <- ggplot(mm[which(mm$pop == pop),], 
               aes(x=variable, y=value , col = data)) +
    geom_boxplot() + 
    labs(y = 'Number of Variants', x = 'MAC Bin')+
    theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
    geom_point(data=mg[which(mg$pop  == pop),],
               aes(x=variable, y=value), shape  = 8, size = 2.1) +
    theme(legend.position="bottom" )+
    theme(legend.title = element_blank()) +
    theme(axis.title.x = element_blank())+
    theme(axis.title.y = element_blank())+
    scale_color_manual(values=cbPalette)+
    theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
  
  library(gridExtra)
  g_legend<-function(a.gplot){
    tmp <- ggplot_gtable(ggplot_build(a.gplot))
    leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
    legend <- tmp$grobs[[leg]]
    return(legend)}
  
  mylegend<-g_legend(p1)
  
  p5 <- grid.arrange(arrangeGrob(p1 + theme(legend.position="none"),
                                 p2 + theme(legend.position="none"),
                                 p3 + theme(legend.position="none"),
                                 nrow=1),
                     mylegend, nrow=2,heights=c(10, 1.1))
  ##### so the legend has it's own 'row'
  
  # ggsave(file = paste0('Intergenic_gnomADv3_',  pop, '.jpg'),
  #        plot = p5, height = 5, width = 8, units = 'in')
  
  
}
