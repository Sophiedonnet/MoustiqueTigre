import pandas as pd
import matplotlib.pyplot as plt


# Load your wide-format data
df = pd.read_csv("DataMoustiqueTigre/arbovirose_data_year.csv")

# Stacked barplot for dengue only (repeat for others if needed)
years = df['year'].astype(str)
auto = df['dengue_cases_autochtones']
imp = df['dengue_cases_importés']

# Plotting
plt.figure(figsize=(10, 6))
plt.bar(years, auto, label='Autochtones')
plt.bar(years, imp, bottom=auto, label='Importés')

plt.title("Cas de Dengue par année")
plt.xlabel("Année")
plt.ylabel("Nombre de cas")
plt.xticks(rotation=90)
plt.legend()
plt.tight_layout()
plt.show()



auto = df['zika_cases_autochtones']
imp = df['zika_cases_importés']

# Plotting
plt.figure(figsize=(10, 6))
plt.bar(years, auto, label='Autochtones')
plt.bar(years, imp, bottom=auto, label='Importés')

plt.title("Cas de Zika par année")
plt.xlabel("Année")
plt.ylabel("Nombre de cas")
plt.xticks(rotation=90)
plt.legend()
plt.tight_layout()
plt.show()



############# CHIKUNGNYA 
auto = df['chikungunya_cases_autochtones']
imp = df['chikungunya_cases_importés']

# Plotting
plt.figure(figsize=(10, 6))
plt.bar(years, auto, label='Autochtones')
plt.bar(years, imp, bottom=auto, label='Importés')

plt.title("Cas de chikungunya par année")
plt.xlabel("Année")
plt.ylabel("Nombre de cas")
plt.xticks(rotation=90)
plt.legend()
plt.tight_layout()
plt.show()