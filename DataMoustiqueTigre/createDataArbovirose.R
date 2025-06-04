# Load necessary libraries
library(dplyr)
library(readr)

library(lubridate)
# Read the CSV file
arboviroses <- read.csv("DataMoustiqueTigre/Donnees_arboviroses.csv")
arboviroses <- arboviroses %>%
  mutate(Mois = as.Date(paste0(Mois, "-01")))




# View the unique disease names if needed
unique(arboviroses$Arbovirose)  # Replace 'disease' with actual column name indicating the disease

# Filter data for each disease

dengue_data <- filter(arboviroses, Arbovirose == "Dengue")
zika_data <- filter(arboviroses,Arbovirose == "Zika")
chikungunya_data <- filter(arboviroses,Arbovirose == "Chikungunya")

#--------------------------------------------------------- 
chikungunya_data_year <- chikungunya_data %>%
  mutate(year = year(Mois)) %>%              # Extract the year
  group_by(year) %>%            # Group by year
  summarise(chikungunya_cases_autochtones = sum(Nombre.de.cas.autochtones, na.rm = TRUE), chikungunya_cases_importés = sum(Nombre.de.cas.importés, na.rm = TRUE)) %>%  # Sum the values
  ungroup()

zika_data_year <- zika_data %>%
  mutate(year = year(Mois)) %>%              # Extract the year
  group_by(year) %>%            # Group by year
  summarise(zika_cases_autochtones = sum(Nombre.de.cas.autochtones, na.rm = TRUE), zika_cases_importés = sum(Nombre.de.cas.importés, na.rm = TRUE)) %>%  # Sum the values
  ungroup()

dengue_data_year <- dengue_data %>%
  mutate(year = year(Mois)) %>%              # Extract the year
  group_by(year) %>%            # Group by year
  summarise(dengue_cases_autochtones = sum(Nombre.de.cas.autochtones, na.rm = TRUE), dengue_cases_importés = sum(Nombre.de.cas.importés, na.rm = TRUE)) %>%  # Sum the values
  ungroup()



# Merge the dataframes by 'year'
arbovirose_data_year <- dengue_data_year %>%   full_join(zika_data_year, by = "year") %>%
  full_join(chikungunya_data_year, by = "year")
write.csv(arbovirose_data_year,file='DataMoustiqueTigre/arbovirose_data_year.csv',row.names = FALSE)
