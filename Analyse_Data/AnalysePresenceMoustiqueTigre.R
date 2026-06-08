rm(list=ls())
data_Presence = read.csv(file='DataMoustiqueTigre/presenceMoustiqueTigre_data_year.csv')
data_infected_per_year <- read.csv(file='DataMoustiqueTigre/infectionMoustiqueTigre_data_year.csv')



# sum of 1s = number infected
ggplot(data_infected_per_year, aes(x = year, y = nb_dept_infected)) +
  geom_line(color = "red", size = 1.2) +
  geom_point(color = "darkred", size = 2) +
  labs(title = "Number of Infected Departments per Year",
       x = "Year",
       y = "Number of Infected Departments") +
  theme_minimal()

##########################################################" 
# Plots  Max  latitude  of  infected departement  
ggplot(data_infected_per_year, aes(x = year, y = lat_max_infected)) +
  geom_line(color = "red", size = 1.2) +
  geom_point(color = "darkred", size = 2) +
  labs(title = "Lat max infected",
       x = "Year",
       y = "Lat max infected Departments") +
  theme_minimal()


##########################################################" 
# Plots population infected per year   
ggplot(data_infected_per_year, aes(x = year, y = pop_infected)) +
  geom_line(color = "red", size = 1.2) +
  geom_point(color = "darkred", size = 2) +
  labs(title = "Exposed Population per Year",
       x = "Year",
       y = "Exposed Population") +
  theme_minimal()







