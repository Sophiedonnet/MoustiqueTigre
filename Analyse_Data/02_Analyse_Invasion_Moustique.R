progressionMoustiqueTigre_year <- read.csv("~/WORK_ALL/MEDIATION/LesMouettesSavantes/MoustiqueTigre/PréparationProjet/Create_Data_MoustiqueTigre/preparedData_progressionMoustiqueTigre_year.csv")

# ##########################################################" 
# # Plots  Nb of departement infected 
# 
ggplot(progressionMoustiqueTigre_year, aes(x = year, y = nb_dept_infected)) +
  geom_line(color = "red", size = 1.2) +
  geom_point(color = "darkred", size = 2) +
  labs(title = "Number of Infected Departments per Year",
       x = "Year",
       y = "Number of Infected Departments") +
  theme_minimal()
# 
# ##########################################################" 
# # Plots  Max  latitude  of  infected departement  

ggplot(progressionMoustiqueTigre_year, aes(x = year, y = lat_mean_infected)) +
  geom_line(color = "red", size = 1.2) +
  geom_point(color = "darkred", size = 2) +
  labs(title = "Lat",
       x = "Year",
       y = "Latitude moyenne des départements infectés") +
  theme_minimal()


ggplot(data_infected_per_year, aes(x = Temperature, y = lat_mean_infected)) +
  geom_point(color = "darkred", size = 2) +geom_smooth(method='lm')

labs(title = "Lat",
     x = "Year",
     y = "Latitude moyenne des départements infectés") +
  theme_minimal()


ggplot(data_infected_per_year, aes(x = Nb_internet_users, y = lat_mean_infected)) +
  geom_point(color = "darkred", size = 2) +geom_smooth(method='lm')
labs(title = "Lat",
     x = "Year",
     y = "Latitude moyenne des départements infectés") +
  theme_minimal()

cor(data_infected_per_year$Nb_internet_users, data_infected_per_year$lat_mean_infected)


#------------------------------------------------------------ 
gg_lat <- ggplot(data_infected_per_year, aes(x = year, y = lat_mean_infected)) + geom_point(color = "darkred", size = 2) +geom_smooth(method='lm')
labs(title = "Lat", x = "Year",y = "Latitude moyenne des départements infectés") +     theme_minimal()
gg_temp <- ggplot(data_infected_per_year, aes(x = year, y = Temperature)) + geom_point(color = "darkred", size = 2) +geom_smooth(method='lm')
labs(title = "Lat", x = "Year",y = "Latitude moyenne des départements infectés") +     theme_minimal()




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