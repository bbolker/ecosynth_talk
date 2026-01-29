library(tidyverse)
library(plotly)
library(arrow)
f <- list.files("States", pattern = "\\.csv", full.names = TRUE)
names(f) <- stringr::str_remove_all(f, "(States/|\\.csv$)")
ctypes <- paste(rep("i", 14), collapse = "")
all <- purrr::map_dfr(f,
                      ~ read_csv(. , col_types = ctypes),
                      .id = "State")

write_parquet(all, "bbs.pqt")

all <- read_parquet("bbs.pqt")

crowcounts <- all |> filter(AOU == 04880) |>
  summarise(Count = mean(Count50), .by = c(State, Year)) |>
  arrange(desc(Count))

crowcounts_ny <- all |> filter(AOU == 04880, State == "NYork") |>
  summarise(Count = mean(Count50), .by = Year) |>
  arrange(Year)

plot(Count ~ Year, crowcounts_ny, type = "b")


gg0 <- ggplot(crowcounts, aes(Year, Count, group = State)) +
  geom_line(aes(colour = State)) +
  stat_summary(fun = mean, geom = "line", aes(group = Year))
