rm(list=ls())


# Load necessary libraries
library(dplyr)
library(readr)
library(ggplot2)
library(stringr)

# Read the CSV file
Presence <- read.csv("~/WORK_ALL/MEDIATION/LesMouettesSavantes/MoustiqueTigre/DataMoustiqueTigre/DonnesPresenceDepartementMoustique.csv")
Presence  <- Presence  %>% select(-c("X.1","X"))
Presence <- Presence %>%
  rename_with(~ str_replace(., "^X", ""), starts_with("X"))


# Get name of departement from the other dataset 
Donnees_arboviroses <- read.csv("~/WORK_ALL/MEDIATION/LesMouettesSavantes/MoustiqueTigre/DataMoustiqueTigre/Donnees_arboviroses.csv")

Donnees_arboviroses <- Donnees_arboviroses %>%
  mutate(Département.Code = case_when(
    Département.Code == "2A" ~ "201",
    Département.Code == "2B" ~ "202",
    TRUE ~ Département.Code
  ))%>% mutate(Département.Code.numeric = as.numeric(Département.Code))


listeDepartement <- Donnees_arboviroses %>%   group_by(Département.Code.numeric,Département) %>%arrange(Département.Code.numeric) %>%
  summarise(mean_population = mean(population, na.rm = TRUE))

#Check 
# cbind(listeDepartement$Département.Code.numeric,Presence[,1])


cbind(listeDepartement,Presence[,-1])


