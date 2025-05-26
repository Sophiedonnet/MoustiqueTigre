rm(list=ls())


# Load necessary libraries
library(dplyr)
library(readr)
library(ggplot2)
library(lubridate)
# Read the CSV file
arboviroses <- read.csv("~/WORK_ALL/MEDIATION/LesMouettesSavantes/MoustiqueTigre/DataMoustiqueTigre/Donnees_arboviroses.csv")
arboviroses <- arboviroses %>%
  mutate(Mois = as.Date(paste0(Mois, "-01")))




# View the unique disease names if needed
unique(arboviroses$Arbovirose)  # Replace 'disease' with actual column name indicating the disease

# Filter data for each disease

disease_data <- dengue_data <- filter(arboviroses, Arbovirose == "Dengue")
save(disease_dat,file='DataMoustiqueTigre/dengue_data.Rdata')


disease_data <- zika_data <- filter(arboviroses,Arbovirose == "Zika")
save(disease_data,file='DataMoustiqueTigre/zika_data.Rdata')


disease_data <- chikungunya_data <- filter(arboviroses,Arbovirose == "Chikungunya")
save(disease_data,file='DataMoustiqueTigre/chikungunya_data.Rdata')

#--------------------------------------------------------- 

disease <- "zika"
disease <- "chikungunya"

name_data <- paste0('DataMoustiqueTigre/',disease,'_data.Rdata') 
load(file=name_data)

data_summary <- disease_data %>%
  mutate(year = year(Mois)) %>%              # Extract the year
  group_by(year, Département) %>%            # Group by year and department
  summarise(total_Nombre.de.cas.autochtones = sum(Nombre.de.cas.autochtones, na.rm = TRUE)) %>%  # Sum the values
  ungroup()
head(data_summary)

title_data = paste0("Nombre total de cas de ",disease, ' par an et par département ')

ggplot(data_summary, aes(x = year, y = total_Nombre.de.cas.autochtones, color = Département)) +
  geom_line(size = 1) +
  geom_point() +
  labs(
    title = title_data,
    x = "Year",
    y = "Total Cases",
    color = "Department"
  ) + theme_minimal() +  theme(legend.position = "none")








