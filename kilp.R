library(ggplot2); theme_set(theme_bw())
library(dplyr)
library(readr)

## fn <- "~/students/kain/McMasterPhdWork/WNV/incrate.csv"
fn <- "data/bird_to_mos.csv"
dd <- (read_csv(fn)
    %>% filter(Strain != "JEV", Temperature_C>=18, Temperature_C != 28)
    %>% droplevels()
    %>% mutate(K2008=(Citation=="Kilpatrick et al 2008"))
)
dds <- (dd
    %>% group_by(Temperature_C,Strain,Days_Post_Infection)
    %>% summarise(mean=mean(Percent_Transmitting_Mean,na.rm=TRUE))
    %>% drop_na(mean)
)

with(dd,table(Citation,Temperature_C,Strain))

ggplot(dds,aes(Days_Post_Infection,
              mean,
              ## Adjusted_Percent_Transmitted_Mean,
              colour=factor(Temperature_C),
              linetype=Strain,
              shape=Strain)) +
    geom_point()+
    scale_colour_manual(values=viridis(7))+
    geom_smooth(method="glm",  ## "gam"?
                ## formula=y~s(x,k=5),
                formula=y~poly(x,2),
                method.args=list(family=quasibinomial()),
                alpha=0.1)+
    ## geom_line(aes(size=(Temperature_C==32)))+
    scale_size_manual(values=c(1,2),name="temperature (C)")+
    labs(x="mean transmission probability",
         y="days post-infection")
    
filter(dd,Citation=="Kilpatrick et al 2008") %>%
    select(Temperature_C, Strain, Percent_Transmitting_Mean) %>%
    View()

filter(dd,Temperature_C == 27) %>% 
    select(Citation, Temperature_C, Strain, Percent_Transmitting_Mean) %>%
    arrange(Citation, Strain) %>%
    View()
