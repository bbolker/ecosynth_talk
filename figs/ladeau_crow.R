library(dplyr)
library(tidyr)
library(ggplot2); theme_set(theme_bw())
x <- (read.table("ladeau_crow.png.dat")
    %>% setNames(c("year","value"))
    %>% mutate(year=round(year))
    %>% group_by(year)
    %>% arrange(value)
    %>% mutate(type=rep(c("lwr","est","upr")))
    %>% ungroup()
    %>% spread(type,value)
)
write.csv(x,"ladeau_crow.txt",row.names=FALSE)
ggplot(x,aes(year,est,ymin=lwr,ymax=upr,colour=(year>=2000))) +
    geom_pointrange()+
    geom_vline(xintercept=1999.5, linetype=2)+
    scale_colour_manual(values=c("black","red"),
                        guide=FALSE)+
    labs(y="counts/breeding bird survey transect")



