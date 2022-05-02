x <- read.csv("../data/WNV_human_cases.csv")
library(ggplot2)
ggplot(x,aes(Year,Value,linetype=Disease,colour=Type,shape=Disease)) +
    geom_point(fill="white") +
    geom_line() + scale_y_log10() +
    scale_colour_brewer(palette="Set1")+
    scale_shape_manual(values=c(16,21))
