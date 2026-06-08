from math import*
import matplotlib.pyplot as plt
import random 
import numpy as np

############# Paramètres du modèle #############
nbGen = 0
c= 50000
print(c)
m=0.01 #taux de mortalité des larves
f=round(c/2) #nombre de femelle
Mf=c-f #nombre de male fertile
Ms=100#nombre de Male stérile
donnees=[]

####################" Fonction pour la fecondation
def fecond(f,Mf,Ms):
    
    Ff=0 
    Fs=0
    for i in range(f):
        male  = random.choices(["fertile", "sterile"], [Mf, Ms], k=1)[0]
        if (male == "fertile"):
            Ff += 1
            Mf -= 1
        else:
            Fs += 1
            Ms -= 1
    return(Ff)


####################" Fonction pour la fecondation

def selec(c,Of,Os):
    
    Ogf=0 
    Ogs=0
    vec_tirage = []
    for i in range(c):
       
        typeo = random.choices(["fertile", "sterile"], [Of, Os], k=1)[0]
        if (typeo == "fertile"):
            Ogf += 1
            Of -= 1
        else:
            Ogs += 1
            Os -= 1
        vec_tirage.append(typeo)
    #print([vec_tirage])
    print(Ogf," espace " ,Ogs)
    return(Ogf, Ogs)




######################### Genreration 0 
o=sum(np.random.poisson(70,f))
o = min(o,c)
o=np.random.binomial(o,1-m)  #nb de larve survivante
f=np.random.binomial(o,1/2) #nb femelle
Mf=o-f 
print("Moustique femelle",f)   




########################### Boucle de génération des moustiques
    #c0 = 50000
    #Ms = 1

    #f = round(c0/2)
    #Mf = c0 - f  # Nombre de moustiques mâles fertiles
    #nbGen = 0
    #c=c0 
    #donnees = [f]  # Initialisation de la liste avec le nombre de moustiques femelles de la génération 0
#for i in range(nbGen):
while c>=0 and nbGen<10 :
    
    nbGen+=1
    
    if(f>(Ms+Mf)):  
        print("Nombre de moustique femelle trop élevé, on arrête la simulation")
        f = Ms + Mf  # Limite le nombre de moustiques femelles à la somme
    
    Ff  = fecond(f,Mf,Ms) # fecondation des moustiques
    Fs  = f-Ff
    Os=sum(np.random.poisson(70,Fs))
    Of=sum(np.random.poisson(70,Ff))
    o=Of+Os      #nb d'oeuf  
    print("Oeuf sterile",Os)
    print("Oeuf fertile",Of)   

    if o<c:
        l=Os
    else:
        Os,Of = selec(c,Os,Of)
        l=Os
    c=c-l #capaciter -oeuf non fertile
    if(c<0):
        c=0
    f=np.random.binomial(Of,1/2) #nb de femelle
    donnees.append(f)  
    print("Moustique femelle",f)
    

print(donnees)
#plt.xlim(0,donnees)
#plt.ylim(0)


plt.plot(donnees,label=("male sterile",Ms),color='red') # label=("male sterile",Ms) ,
plt.title("Courbe moustique femme11e")
plt.xlabel("x")
plt.ylabel("y")
plt.legend()
plt.grid(True)
plt.show()