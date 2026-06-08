rm(list=ls())
# Load necessary libraries
library(dplyr)
library(readr)
library(ggplot2)
library(stringr)
library(tidyr)
library(stringr)
library(lubridate)
library(readxl)
# Read the CSV file
Presence <- read.csv("DataMoustiqueTigre/DonnesPresenceDepartementMoustique.csv")
Presence  <- Presence  %>% select(-c("X.1","X"))
Presence <- Presence %>%
  rename_with(~ str_replace(., "^X", ""), starts_with("X")) %>%rename(code_departement=Departement)


Presence_long <- Presence %>%
  pivot_longer(
    cols = `2004`:`2024`,       # columns for the years
    names_to = "year",          # new column name for years
    values_to = "infected"      # new column name for 0/1 presence
  ) %>%
  mutate(year = as.integer(year))   # convert year to integer if needed
source(file='DataMoustiqueTigre/departementListe.R')
Presence_long <- Presence_long %>%left_join(departement_lookup, by = "code_departement")
Presence_long <- Presence_long %>%   select(name_departement, everything())
Presence_long$code_departement  <- str_pad(Presence_long$code_departement, width = 2, pad = "0")


###########################################################
# Get population of departement from the others datasets 
###########################################################

#------------- 2012 -> 2024
arboviroses <- read.csv("DataMoustiqueTigre/Arboviroses/Donnees_arboviroses.csv")
arboviroses <- arboviroses %>%
  mutate(Mois = as.Date(paste0(Mois, "-01")))


pop_departement <- arboviroses %>%
  mutate(year = year(Mois)) %>%              # Extract the year
  group_by(year, Département.Code) %>%            # Group by year and department
  summarise(mean_pop = mean(population, na.rm = TRUE)) %>%  # Sum the values
  ungroup()

# pop_france <- pop_departement %>%             # Extract the year
#   group_by(year) %>%            # Group by year and department
#   summarise(pop = sum(mean_pop, na.rm = TRUE)) %>%  # Sum the values
#   ungroup()

estim_pop_dep_2004_2023 <- read_excel("DataMoustiqueTigre/cartes_presence/estim-pop-dep-sexe-gca-2004_2023_extract.xls")
estim_pop_dep_2004_2023 <- estim_pop_dep_2004_2023 %>%
  pivot_longer(
    cols = `2004`:`2023`,       # columns for the years
    names_to = "year",          # new column name for years
    values_to = "population"      # new column name for 0/1 presence
  ) %>%
  mutate(year = as.integer(year))  

Presence_long$population <- rep(NA,nrow(Presence_long))

for (i in 1:nrow(Presence_long)){
  print(i)
  dep_i <- Presence_long$code_departement[i]
  year_i <- Presence_long$year[i]
  
  if(year_i>=2023){
    u <- which(pop_departement$Département.Code==dep_i & pop_departement$year==year_i )
    Presence_long$population[i]=pop_departement$mean_pop[u]
  }else{
    u <- which(estim_pop_dep_2004_2023$Code==dep_i & estim_pop_dep_2004_2023$year==year_i )
    Presence_long$population[i]=estim_pop_dep_2004_2023$population[u]
  }
}
data_Presence <- Presence_long
write.csv(data_Presence,file='DataMoustiqueTigre/presenceMoustiqueTigre_data_year.csv',row.names = FALSE)


data_infected_per_year <- data_Presence %>%
  group_by(year) %>%
  summarise(nb_dept_infected = sum(infected, na.rm = TRUE), 
            lat_mean_infected = mean(infected*Latitude.la.plus.au.nord, na.rm = TRUE),
            pop_infected = sum(infected*population, na.rm = TRUE)
  ) 
write.csv(data_infected_per_year,file='DataMoustiqueTigre/infectionMoustiqueTigre_data_year.csv',row.names = FALSE)




# 
# ##########################################################" 
# # Plots  Nb of departement infected 
# 
 departements_infected_per_year <- data_Presence %>%
   group_by(year) %>%
   summarise(n_infected = sum(infected, na.rm = TRUE))  # sum of 1s = number infected
 ggplot(departements_infected_per_year, aes(x = year, y = n_infected)) +
   geom_line(color = "red", size = 1.2) +
   geom_point(color = "darkred", size = 2) +
   labs(title = "Number of Infected Departments per Year",
        x = "Year",
        y = "Number of Infected Departments") +
   theme_minimal()
# 
# ##########################################################" 
# # Plots  Max  latitude  of  infected departement  
 latitute_departements_infected_per_year <- data_Presence %>%
   group_by(year) %>%
   summarise(lat_infected = mean(infected*Latitude.la.plus.au.nord, na.rm = TRUE))  # sum of 1s = number infected
 
 ggplot(latitute_departements_infected_per_year, aes(x = year, y = lat_infected)) +
   geom_line(color = "red", size = 1.2) +
   geom_point(color = "darkred", size = 2) +
   labs(title = "Lat",
        x = "Year",
        y = "Latitude moyenne des départements infectés") +
   theme_minimal()


#------------------------------------------------------------ 
 

# 
# ##########################################################" 
# # Plots population infected per year   
 population_infected_per_year <- data_Presence %>%
   group_by(year) %>%
   summarise(pop_infected = sum(infected*population, na.rm = TRUE)/sum(population, na.rm = TRUE))  # sum of 1s = number infected
# 
# # Step 2: Plot
 ggplot(population_infected_per_year, aes(x = year, y = pop_infected)) +
   geom_line(color = "red", size = 1.2) +
   geom_point(color = "darkred", size = 2) +
   labs(title = "Exposed Population per Year",
        x = "Year",
        y = "Exposed Population") +
   theme_minimal()
# 
# 
# 
# 
# 
# 
# # Plots 
# 
# population_infected_per_year <- data_Presence %>%
#   group_by(year) %>%
#   summarise(n_dept_infected = sum(infected, na.rm = TRUE),pop_infected = sum(infected*population, na.rm = TRUE))  # sum of 1s = number infected
# 
# # Step 2: Plot
# ggplot(population_infected_per_year, aes(x = year, y = n_dept_infected)) +
#   geom_line(color = "red", size = 1.2) +
#   geom_point(color = "darkred", size = 2) +
#   labs(title = "Number of Infected Departments per Year",
#        x = "Year",
#        y = "Number of Infected Departments") +
#   theme_minimal()
# 
# 
# 
