###############
#### Create the plot with the 'UKBioBank' results
#### June 30, 2020
###############


re <- read.table('uk_biobank_block_counts.txt',  sep  = '\t', header = TRUE)

##### gnomAD has the blocks merged

mac_template <- as.data.frame(matrix(nrow=100, ncol = 10))

colnames(mac_template) <- c('block', 'pop', 'Singletons', 'Doubletons', 'MAC=3-5',
                            'MAC=6-10', 'MAC=11-20', 
                            'MAC=21-MAF005',
                            'MAF005-MAF01', 'rep')

#### loop defines the bins
loop <- as.data.frame(matrix(nrow=7,  ncol = 2))
colnames(loop) <- c('Lower', 'Upper')
N<- 41246
loop$Lower <- c(1,2,3,6,11,21,(floor(N*2*0.005)+1))
loop$Upper <- c(1,2,5,10,20,floor(N*2*0.005),floor(N*2*0.01))


###
# Code included but it just loads in at the bottom
###

# ##### and now get RAREsim
# 
# mac3 <- c()
# set.seed(1234)
# 
# for(bl in c(56, 37, 62)){
#     mac <- mac_template
#     mac$block <- bl
#     mac$pop <- 'British'
#     setwd(paste0('/Users/megansorenson/Documents/RAREsim/RealData/MAC/Block', bl))
#     for(rep in c(1:100)){
#       rem_all<-c()
#       change_all <-  c()
#       to_change <- c()
#       temp <- read.table(paste0('Rep', rep,'.count.txt'))
#       temp <- as.data.frame(temp)
#       temp$num <-  1:nrow(temp)
#       for(k in nrow(loop):1){
#         tmp <-  temp[which(temp$V1 >= loop$Lower[k] & temp$V1 <= loop$Upper[k]),]
#         n1 <- nrow(tmp)
#         expect <- re[which(re$Block == bl & re$data == 'Expected'),k+3]  ##expected
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
#           n2 <- expect  - n1 ### n2 is how many more we need
#           p1 <- n2/nrow(rem_all)  ### this is the proportion from rem_all
#           rem_all$rd <- runif(nrow(rem_all))
#           to_change <- rem_all[which(rem_all$rd  <= p1),]
#           mac_range <-  c(loop$Lower[k]:loop$Upper[k])
#           to_change$new_MAC <- sample(mac_range, nrow(to_change),
#                                       replace = TRUE)
#           ### change them within the MAC file.
# 
#           temp$V1[which(temp$num %in% to_change$num)] <- to_change$new_MAC
# 
#           rem_all <- rem_all[which(rem_all$rd > p1),]
#           change_all<- rbind(change_all,  to_change)
#           }else{
#             print('Error2')
#             next}
#         }
#       }
#       temp <- temp[-c(rem_all$num),]
# 
#       ##### At this point, set rem_all to all reference alleles in haplotype files
#       ##### And set change_all to the given MAC
# 
#       #####  ok, now I need the allele count to add to the plot
#       for(k in 1:nrow(loop)){
#         tmp <-  temp[which(temp$V1 >= loop$Lower[k] & temp$V1 <= loop$Upper[k]),]
#         n1 <- nrow(tmp)
#         mac[rep,k+2] <- n1
#       }
#       mac$rep[rep] <- rep
#     }
# 
#     mac3  <- rbind(mac3,mac)
# 
#   }
# 
# 
# mac3$data  <- 'RAREsim'
# 
# setwd('/Users/megansorenson/Documents/RAREsim/RealData/')
# write.table(mac3, 'All_RAREsim_AC_information.txt',
#             row.names  = FALSE, sep = '\t', quote = FALSE)

setwd('/Users/megansorenson/Documents/RAREsim/RealData/')
mac <- read.table('All_RAREsim_AC_information.txt', header = TRUE,
                   sep = '\t')



re <- re[,c(3,1,4:12)]
re$Total <- '.'
colnames(re) <- colnames(mac)
gnom  <-  re[1:3,]

#mac <- rbind(mac,gnom)

table(mac$data)

#### simulate just one block
names(mac)
colnames(mac)[5:9] <- c('MAC=3-5', 'MAC=6-10','MAC=11-20', 'MAC=21-MAF=0.5%',
                        'MAF=0.5%-1%')
colnames(gnom)[5:9] <- c('MAC=3-5', 'MAC=6-10','MAC=11-20', 'MAC=21-MAF=0.5%',
                         'MAF=0.5%-1%')
head(mac)
library(reshape2)
melted_mac <- melt(mac, id = c('block', 'pop', 'data', 'rep'))
head(melted_mac)
table(melted_mac$pop, melted_mac$data)

melted_gnom <- melt(gnom, id = c('block', 'pop', 'data', 'rep'))


bl <- 62
cbPalette <- c( "#CC79A7",  "#56B4E9","#009E73", "#E69F00", 
                "#0072B2",
                "#D55E00")

library(ggplot2)

melted_mac <- melted_mac[which(melted_mac$data == 'RAREsim'),]

setwd('/Users/megansorenson/Documents/RAREsim/RealData')

bl=56
mm <- melted_mac[which(melted_mac$block  == bl),]

p1 <- ggplot(mm, 
             aes(x=variable, y=value , col = data)) +
  geom_boxplot() + 
  labs(y = 'Number of Variants', x = 'MAC Bin')+
  theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
  geom_point(data=melted_gnom[which(melted_gnom$block  == bl),],
             aes(x=variable, y=value), shape  = 8, size =  2.1)+
  theme(legend.position="bottom" )+
  theme(legend.title = element_blank()) +
  theme(axis.title.x = element_blank())+
  scale_color_manual(values=cbPalette)+
  theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
p1

bl=37
mm <- melted_mac[which(melted_mac$block  == bl),]

p2 <- ggplot(mm, 
             aes(x=variable, y=value , col = data)) +
  geom_boxplot() + 
  theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
  geom_point(data=melted_gnom[which(melted_gnom$block  == bl),],
             aes(x=variable, y=value), shape  = 8, size =  2.1)+
  theme(legend.position="bottom" )+
  theme(legend.title = element_blank()) +
  theme(axis.title.x = element_blank())+
  theme(axis.title.y = element_blank())+
  scale_color_manual(values=cbPalette)+
  theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
p2

bl=62
mm <- melted_mac[which(melted_mac$block  == 62),]

p3 <- ggplot(mm, 
             aes(x=variable, y=value , col = data)) +
  geom_boxplot() + 
  theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
  geom_point(data=melted_gnom[which(melted_gnom$block  == bl),],
             aes(x=variable, y=value), shape  = 8, size =  2.1)+
  theme(legend.position="bottom" )+
  theme(legend.title = element_blank()) +
  theme(axis.title.x = element_blank())+
  theme(axis.title.y = element_blank())+
  scale_color_manual(values=cbPalette)+
  theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
p3

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

# ggsave(file = 'UKBiobank_blocks.jpg',
#        plot = p5, height = 5, width = 8, units = 'in')


##### for figure 4

cbPalette <- c(   "#CC79A7",  
                  "#009E73")


bl=62

mm <- melted_mac[which(melted_mac$block  == 62),]



p3a <- ggplot(mm, 
              aes(x=variable, y=value , col = data)) +
  geom_boxplot() + 
  theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
  geom_point(data=melted_gnom[which(melted_gnom$block  == bl),],
             aes(x=variable, y=value), shape  = 8, size =  2.1)+
  theme(legend.position="bottom" )+
  theme(legend.title = element_blank()) +
  theme(axis.title.x = element_blank())+
  theme(axis.title.y = element_blank())+
  scale_color_manual(values=cbPalette)+
  theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))+
  guides(col = guide_legend(nrow = 2, byrow = TRUE))
p3a

