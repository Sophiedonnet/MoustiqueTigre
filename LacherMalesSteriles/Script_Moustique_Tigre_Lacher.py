import numpy as np
import matplotlib.pyplot as plt

# Parameters
Capacity_eggs = 50000  # max capacity
N_0 = 10
Mean_eggs = 30
N_weeks = 12
mortality = 0.01

# ---------------------------------------- No control ----------------------------------------

# Initial state
N_Eggs = N_0
evolution_N_Eggs = [N_Eggs]

# Simulation
for week in range(N_weeks):
    N_Eggs = np.random.binomial(N_Eggs, 1 - mortality)

    N_Female = np.random.binomial(N_Eggs, 0.5)
    N_Male = N_Eggs - N_Female

    N_Female = np.random.binomial(N_Female, 1 - mortality)
    N_Male = np.random.binomial(N_Male, 1 - mortality)

    N_Eggs_new = 0
    for _ in range(N_Female):
        if N_Male > 0:
            N_Eggs_new += np.random.poisson(Mean_eggs)
            N_Male -= 1

    N_Eggs = min(N_Eggs_new, Capacity_eggs)
    evolution_N_Eggs.append(N_Eggs)
    print(N_Eggs)

plt.figure(figsize=(10, 5))
plt.plot(range(N_weeks + 1), evolution_N_Eggs, label="No Control")
plt.xlabel("Week")
plt.ylabel("Viable Eggs")
plt.title("Egg Evolution Without Control")
plt.grid(True)
plt.legend()
plt.show()

# ---------------------------------------- With sterile male release ----------------------------------------

N_EggsViable = Capacity_eggs
N_EggsSterile = 0
evolution_N_EggsViable = [N_EggsViable]
N_Male_sterile_lacher = 20000

for week in range(N_weeks):
    N_EggsViable = np.random.binomial(N_EggsViable, 1 - mortality)

    N_Female = np.random.binomial(N_EggsViable, 0.5)
    N_Male = N_EggsViable - N_Female
    N_EggsViable = 0  # Reset viable eggs for the next generation

    N_Female = np.random.binomial(N_Female, 1 - mortality)
    N_Male = np.random.binomial(N_Male, 1 - mortality)

    N_Male_sterile = N_Male_sterile_lacher

    for _ in range(N_Female):
        if N_Male + N_Male_sterile > 0:
            pMale = N_Male / (N_Male + N_Male_sterile)
            Male_i = np.random.choice(['Male', 'MaleSterile'], p=[pMale, 1 - pMale])
            if Male_i == 'Male':
                N_EggsViable += np.random.poisson(Mean_eggs)
                N_Male -= 1
            else:
                N_EggsSterile += np.random.poisson(Mean_eggs)
                N_Male_sterile -= 1

    total_eggs = N_EggsViable + N_EggsSterile
    if total_eggs > Capacity_eggs:
        pop_Eggs = np.array(['Fertile'] * N_EggsViable + ['Sterile'] * N_EggsSterile)
        np.random.shuffle(pop_Eggs)
        pop_Eggs = pop_Eggs[:Capacity_eggs]
        N_EggsViable = np.sum(pop_Eggs == 'Fertile')
        N_EggsSterile = np.sum(pop_Eggs == 'Sterile')

    evolution_N_EggsViable.append(N_EggsViable)
    print(N_EggsViable)

plt.figure(figsize=(10, 5))
plt.plot(range(N_weeks + 1), evolution_N_EggsViable, label="With Sterile Males", color="orange")
plt.xlabel("Week")
plt.ylabel("Viable Eggs")
plt.title("Egg Evolution With Sterile Male Release")
plt.ylim(0, 50000)
plt.grid(True)
plt.legend()
plt.show()

