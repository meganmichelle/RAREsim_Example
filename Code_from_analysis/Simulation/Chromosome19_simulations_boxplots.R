###############
#### Data was created/organized with Chromosome19_simulation_data.R
#### Create the plot with the final results
##### All of chromosome 19
#################

#### load in all the data:
##### Organized in the Chromosome19_simulation_data.R script

setwd('/Users/megansorenson/Documents/Package/RAREsim_Example/Code_from_analysis/Simulation/')
mac <- read.table('Simulation_results100reps_chr19_final.txt', header = TRUE,
             sep = '\t')


library(reshape2)

melted_mac <- melt(mac, id = c('block', 'pop', 'data', 'rep'))
head(melted_mac)
table(melted_mac$pop, melted_mac$data)

### Separate gnomAD and the simulation data
melted_gnom <- melted_mac[which(melted_mac$data == 'gnomAD'),]

melted_mac1 <- melted_mac[-c(which(melted_mac$data == 'gnomAD')),]


bl <- 37  #block with median number of bases
library(ggplot2)

melted_mac1$data <- as.character(melted_mac1$data)
melted_mac1$data[which(melted_mac1$data  == 'HAPGEN2 over-simulated')] <- 'HAPGEN2 with all bp'
melted_mac1$data[which(melted_mac1$data  == 'Original HAPGEN2')] <- 'HAPGEN2 with polymorphic SNVs'


cbPalette <- c("#56B4E9","#E69F00",  
               "#009E73", "#CC79A7", "#0072B2",
               "#D55E00")

for(bl in c(56,66)){ # 5th and 95th percentile for number of bases
  mm <- melted_mac1[which(melted_mac1$block  == bl),]
  gm <- melted_gnom[which(melted_gnom$block  == bl),]
  
  
  pop <- 'AFR'
  p1 <- ggplot(mm[which(mm$pop == pop),], 
               aes(x=variable, y=value , col = data)) +
    geom_boxplot() + 
    labs(y = 'Number of Variants', x = 'MAC Bin')+
    theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
    geom_point(data=gm[which(gm$pop == pop),],
               aes(x=variable, y=value), shape  = 8)+
    theme(legend.position="bottom" )+
    theme(legend.title = element_blank()) +
    theme(axis.title.x = element_blank())+
    scale_color_manual(values=cbPalette)+
    theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
  p1
  
  pop <- 'EAS'
  p2 <- ggplot(mm[which(mm$pop == pop),], 
               aes(x=variable, y=value , col = data)) +
    geom_boxplot() + 
    labs(y = 'Number of Variants', x = 'MAC Bin')+
    theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
    geom_point(data=gm[which(gm$pop == pop),],
               aes(x=variable, y=value), shape  = 8)+
    theme(axis.title.x = element_blank())+
    theme(axis.title.y = element_blank())+
    scale_color_manual(values=cbPalette)+
    theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
  p2
  
  pop <- 'NFE'
  p3 <- ggplot(mm[which(mm$pop == pop),], 
               aes(x=variable, y=value , col = data)) +
    geom_boxplot() + 
    labs(y = 'Number of Variants', x = 'MAC Bin')+
    theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
    geom_point(data=gm[which(gm$pop == pop),],
               aes(x=variable, y=value), shape  = 8)+
    theme(axis.title.x = element_blank())+
    theme(axis.title.y = element_blank())+
    scale_color_manual(values=cbPalette)+
    theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
  p3
  
  pop <- 'SAS'
  p4 <- ggplot(mm[which(mm$pop == pop),], 
               aes(x=variable, y=value , col = data)) +
    geom_boxplot() + 
    labs(y = 'Number of Variants', x = 'MAC Bin')+
    theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
    geom_point(data=gm[which(gm$pop == pop),],
               aes(x=variable, y=value), shape  = 8)+
    theme(axis.title.x = element_blank())+
    theme(axis.title.y = element_blank())+
    scale_color_manual(values=cbPalette)+
    theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
  p4 
  
  
  #####  try to extract the legend:
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
  
  # ggsave(file = paste0('Block',bl,'main.jpg'),
  #        plot = p5, height = 5, width = 10, units = 'in')
}


for(bl in c(37)){ ## The median block
  mm <- melted_mac1[which(melted_mac1$block  == bl),]
  gm <- melted_gnom[which(melted_gnom$block  == bl),]
  
  pop <- 'AFR'
  p1 <- ggplot(mm[which(mm$pop == pop),], 
               aes(x=variable, y=value , col = data)) +
    geom_boxplot() + 
    labs(y = 'Number of Variants', x = 'MAC Bin')+
    theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
    geom_point(data=gm[which(gm$pop == pop),],
               aes(x=variable, y=value), shape  = 8)+
    theme(legend.position="bottom" )+
    theme(legend.title = element_blank()) +
    theme(axis.title.x = element_blank())+
    scale_color_manual(values=cbPalette)+
    theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
  p1
  
  pop <- 'EAS'
  p2 <- ggplot(mm[which(mm$pop == pop),], 
               aes(x=variable, y=value , col = data)) +
    geom_boxplot() + 
    labs(y = 'Number of Variants', x = 'MAC Bin')+
    theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
    geom_point(data=gm[which(gm$pop == pop),],
               aes(x=variable, y=value), shape  = 8)+
    theme(axis.title.x = element_blank())+
    scale_color_manual(values=cbPalette)+
    theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
  p2
  
  pop <- 'NFE'
  p3 <- ggplot(mm[which(mm$pop == pop),], 
               aes(x=variable, y=value , col = data)) +
    geom_boxplot() + 
    labs(y = 'Number of Variants', x = 'MAC Bin')+
    theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
    geom_point(data=gm[which(gm$pop == pop),],
               aes(x=variable, y=value), shape  = 8)+
    theme(axis.title.x = element_blank())+
    theme(axis.title.y = element_blank())+
    scale_color_manual(values=cbPalette)+
    theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
  p3
  
  pop <- 'SAS'
  p4 <- ggplot(mm[which(mm$pop == pop),], 
               aes(x=variable, y=value , col = data)) +
    geom_boxplot() + 
    labs(y = 'Number of Variants', x = 'MAC Bin')+
    theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
    geom_point(data=gm[which(gm$pop == pop),],
               aes(x=variable, y=value), shape  = 8)+
    theme(axis.title.x = element_blank())+
    theme(axis.title.y = element_blank())+
    scale_color_manual(values=cbPalette)+
    theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
  p4 
  
  
  ##### Extract the legend:
  g_legend<-function(a.gplot){
    tmp <- ggplot_gtable(ggplot_build(a.gplot))
    leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
    legend <- tmp$grobs[[leg]]
    return(legend)}
  
  mylegend<-g_legend(p1)
  
  p5 <- grid.arrange(arrangeGrob(p1 + theme(legend.position="none"),
                                 p3 + theme(legend.position="none"),
                                 nrow=1),
                     mylegend, nrow=2,heights=c(10, 1.1))
  
  # ggsave(file = paste0('Block',bl,'main_2only.jpg'),
  #        plot = p5, height = 5, width = 8, units = 'in')
  
  p6 <- grid.arrange(arrangeGrob(p2 + theme(legend.position="none") ,
                                 p4 + theme(legend.position="none"),
                                 nrow=1),
                     mylegend, nrow=2,heights=c(10, 1.1))
  
  # ggsave(file = paste0('Block',bl,'supp_2only.jpg'),
  #        plot = p6, height = 5, width = 8, units = 'in')
  
}


###### Look at all of chromosome 19

dt <- levels(as.factor(mac$data))
head(mac)
all <- c()
for(pop in c('AFR', 'EAS',  'NFE', 'SAS')){
  df <- mac[which(mac$pop == pop),]
  for(i in 1:length(dt)){
    dff <- df[which(df$data == dt[i]),]
    for(rep in 1:100){
      df1 <- dff[which(dff$rep == rep),]
      temp <- colSums(df1[,3:9])
      temp <- as.data.frame(t(temp))
      temp$data <- dt[i]
      temp$pop <- pop
      temp$rep <- rep
      all  <- rbind(all, temp)
    }
    
  }
  dff <- df[which(df$data == 'gnomAD'),]
  temp <- colSums(dff[,3:9])
  temp <- as.data.frame(t(temp))
  temp$data <-  'gnomAD'
  temp$pop <- pop
  temp$rep <- '.'
  all  <- rbind(all,  temp)
}

all <- all[-c(which(all$data == 'gnomAD' & all$Singletons == 0 )),]


library(reshape2)
all_melt <- melt(all, id = c('pop', 'data', 'rep'))


all_melt1 <- all_melt[-c(which(all_melt$data == 'gnomAD')),]
gnom_melt <- all_melt[which(all_melt$data == 'gnomAD'),]

table(gnom_melt$pop, gnom_melt$variable)
table(all_melt1$data)

pop <- 'AFR'
p1 <- ggplot(all_melt1[which(all_melt1$pop == pop),], 
             aes(x=variable, y=value , col = data)) +
  geom_boxplot() + 
  labs(y = 'Number of Variants', x = 'MAC Bin')+
  theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
  geom_point(data=gnom_melt[which(gnom_melt$pop == pop),],
             aes(x=variable, y=value), shape  = 8)+
  theme(legend.position="bottom" )+
  theme(legend.title = element_blank()) +
  theme(axis.title.x = element_blank())+
  scale_color_manual(values=cbPalette)+
  theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
p1

pop <- 'EAS'
p2 <- ggplot(all_melt1[which(all_melt1$pop == pop),], 
             aes(x=variable, y=value , col = data)) +
  geom_boxplot() + 
  labs(y = 'Number of Variants', x = 'MAC Bin')+
  theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
  geom_point(data=gnom_melt[which(gnom_melt$pop == pop),],
             aes(x=variable, y=value), shape  = 8)+
  theme(axis.title.x = element_blank())+
  theme(axis.title.y = element_blank())+
  scale_color_manual(values=cbPalette)+
  theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
p2

pop <- 'NFE'
p3 <- ggplot(all_melt1[which(all_melt1$pop == pop),], 
             aes(x=variable, y=value , col = data)) +
  geom_boxplot() + 
  labs(y = 'Number of Variants', x = 'MAC Bin')+
  theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
  geom_point(data=gnom_melt[which(gnom_melt$pop == pop),],
             aes(x=variable, y=value), shape  = 8)+
  theme(axis.title.x = element_blank())+
  theme(axis.title.y = element_blank())+
  scale_color_manual(values=cbPalette)+
  theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
p3

pop <- 'SAS'
p4 <- ggplot(all_melt1[which(all_melt1$pop == pop),], 
             aes(x=variable, y=value , col = data)) +
  geom_boxplot() + 
  labs(y = 'Number of Variants', x = 'MAC Bin')+
  theme(axis.text.x = element_text(angle = 35, hjust=0.65)) +
  geom_point(data=gnom_melt[which(gnom_melt$pop == pop),],
             aes(x=variable, y=value), shape  = 8)+
  theme(axis.title.x = element_blank())+
  theme(axis.title.y = element_blank())+
  scale_color_manual(values=cbPalette)+
  theme(plot.margin = unit(c(0.2,0.5,0.1,0.2), "cm"))
p4 


#####  try to extract the legend:
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
# 
# ggsave(file ='All_chr19_main.jpg',
#        plot = p5, height = 5, width = 10, units = 'in')





