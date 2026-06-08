arbovirose_data_year <- read.csv("~/WORK_LOCAL/MEDIATION/MouettesSavantes/MoustiqueTigre/DataMoustiqueTigre/arbovirose_data_year.csv")

############# plot in R 
library(tidyr)
library(dplyr)
library(ggplot2)
arbovirose_data_year_long <- arbovirose_data_year %>%
  pivot_longer(
    cols = -year,
    names_to = c("disease", "drop", "type"),
    names_sep = "_",
    values_to = "cases"
  ) %>%
  select(-drop) 

ggplot(arbovirose_data_year_long, aes(x = factor(year), y = cases, fill = type)) +
  geom_bar(stat = "identity") +  # default is position = "stack"
  facet_wrap(~ disease) +
  labs(
    title = "Nombre de cas autochtones et importés par maladie et par an",
    x = "Année",
    y = "Nombre de cas",
    fill = "Type de cas"
  ) +
  theme_minimal() + theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)
  )

 





