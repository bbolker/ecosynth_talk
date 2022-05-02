L <- load("data/WNV_Pub.Rdata")
library(ggstance)
ggplot(R0_final_ggplot,
       aes(R0, VL_T,
           colour = Virus_Lineage,
           fill = Temperature,
           group = interaction(Host, Virus_Lineage, Temperature))) +
    geom_violinh() + 
    scale_fill_manual(labels = c("16", "26"),
                      values = gray(c(0.1,0.6)),
                      name = "Temperature") +
    geom_vline(xintercept=1,lty=2) + 
    scale_colour_manual(values=c("blue","red"),
                    name = "strain") +
    facet_wrap(~ Host, ncol = 2) +
    scale_x_log10() +
    xlab(expression(R[0])) +
    ylab("") +
    theme(panel.spacing=grid::unit(0,"lines"))
    

library(tidyr)
library(dplyr)
WN02_adv <- (R0_final_ggplot
    %>% group_by(Host,Virus_Lineage,Temperature)
    %>% mutate(s=seq(n()))
    %>% select(-VL_T)
    %>% ungroup()
    %>% tidyr::spread(Virus_Lineage,R0)
    %>% mutate(WN02_adv=WN02/NY99)
)

ggplot(WN02_adv,aes(fill=Temperature,y=Host,
                    x=WN02_adv)) +
    geom_violinh()+
    scale_x_log10(breaks=c(0.01,1,3,100),
                  labels=c("0.01","1","3","100")) +
    scale_fill_manual(labels = c("16", "26"),
                      values = gray(c(0.1,0.6)),
                      name = "Temperature")+
    geom_vline(xintercept=1,lty=2) +
    geom_vline(xintercept=3,lty=3) +
    facet_grid(Host~.,scale="free")+
    theme(panel.spacing=grid::unit(0,"lines"),
          strip.background=element_blank(),
          strip.text.y=element_blank())+
    labs(y="",x=expression(R[0]~"advantage of WN02"))
    
    


