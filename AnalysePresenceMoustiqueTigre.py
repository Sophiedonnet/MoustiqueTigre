import pandas as pd
import matplotlib.pyplot as plt

# Load your wide-format data
df = pd.read_csv("DataMoustiqueTigre/infectionMoustiqueTigre_data_year.csv")


# Stacked barplot for dengue only (repeat for others if needed)
years = df['year'].astype(str)
auto = df['nb_dept_infected']

# Plotting
plt.figure(figsize=(10, 6))
plt.plot(years, auto, label='nb_dept_infected',marker='o')
plt.title("Nb de départements infectés au cours du temps")
plt.xlabel("Year")
plt.ylabel("Nb de départements ")
plt.xticks(rotation=90)
plt.legend()
plt.tight_layout()
plt.show()





##########################################################" 
# Plots  Max  latitude  of  infected departement  
years = df['year'].astype(str)
auto = df['lat_max_infected']

# Plotting
plt.figure(figsize=(10, 6))
plt.plot(years, auto, label='nlat_max_infected',marker='o')
plt.title("Latitude max de l'infection ")
plt.xlabel("Year")
plt.ylabel("Latitude ")
plt.xticks(rotation=90)
plt.legend()
plt.tight_layout()
plt.show()






##########################################################" 
# Plots  Max  latitude  of  infected departement  
years = df['year'].astype(str)
auto = df['pop_infected']

# Plotting
plt.figure(figsize=(10, 6))
plt.plot(years, auto, label='pop_infected',marker='o')
plt.title("Exposed Population per Year ")
plt.xlabel("Year")
plt.ylabel("Population ")
plt.xticks(rotation=90)
plt.legend()
plt.tight_layout()
plt.show()


