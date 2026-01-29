library(tidyverse)
library(viridisLite)
fn <- "data/bird_to_mos.csv"
dd <- (read_csv(fn)
    %>% filter(Strain != "JEV", Temperature_C>=18, Temperature_C != 28)
    %>% droplevels()
    %>% mutate(K2008=(Citation=="Kilpatrick et al 2008"))
)
dds <- (dd
  %>% group_by(Temperature_C,Strain,Days_Post_Infection)
  %>% summarise(mean=mean(Percent_Transmitting_Mean,na.rm=TRUE), groups = "drop")
  %>% tidyr::drop_na(mean)
)
ggplot(dds,aes(Days_Post_Infection,
              mean,
              colour=factor(Temperature_C),
              linetype=Strain,
              shape=Strain)) +
    geom_point()+
    scale_colour_manual(values=viridis(7),name="temp (C)")+
    geom_smooth(method="glm",  ## "gam"?
                ## formula=y~s(x,k=5),
                formula=y~poly(x,2),
                method.args=list(family=quasibinomial()),
                alpha=0.1)+
    ## geom_line(aes(size=(Temperature_C==32)))+
    scale_linetype_manual(values=c(1,2))+
    labs(y="mean transmission probability",
         x="days post-infection")

label_fun <- function(x) {
  list(sprintf("temp=%s C", x$temp_cat))
}
  
dds <- dds |>
  mutate(temp_cat = cut(Temperature_C, c(0, 23, 26.5, 28, Inf),
                      labels = c("18-22", 26, 27, "30-32")))

colvec <- rev(c("#52907B", "#8F4847")) ## NY99, WN02

theme_set(theme_bw())
ggplot(dds,aes(Days_Post_Infection,
              mean,
              colour=Strain,
              linetype=Strain,
              fill = Strain,
              shape=Strain)) +
  facet_wrap(~temp_cat, labeller=label_fun) +
    geom_point()+
    geom_smooth(method="glm",  ## "gam"?
                ## formula=y~s(x,k=5),
                formula=y~poly(x,2),
                method.args=list(family=quasibinomial()),
                alpha=0.1)+
  scale_colour_manual(values=colvec) +
  scale_fill_manual(values=colvec) +
    ## geom_line(aes(size=(Temperature_C==32)))+
    scale_linetype_manual(values=c(1,2))+
    labs(y="mean transmission probability",
         x="days post-infection")

