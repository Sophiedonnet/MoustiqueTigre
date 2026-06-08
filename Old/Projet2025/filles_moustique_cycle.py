import numpy as np
import random
import matplotlib.pyplot as plt

lambda_val = 70 #nbr oeuf par femelle
cap= 50000 #capaciter oeuf
Fm=1 #nombre femelle depart 
Hs=0
suivi_Fm = []
nbGen = 10 #nombre de generation

##############################################
def fille_garcon(nbebe):
    Fm=0
    H=0
    for i in range(nbebe):
        resultat = random.choice(['Femme', 'Homme'])
        if resultat == 'Femme':
         Fm=Fm+1
        else:
         H=H+1
    return Fm

##############################################

##############################################



def vie_mort(n):
    V = 0
    M = 0
    for i in range(n):
        resultat = random.choices(['Vie', 'Mort'], weights=[0.99, 0.01])
        if resultat[0] == 'Vie':
            V = V + 1
    return V

#############################################
### Evolution de la popoulaiton normale
############################################
   
Fm  = 1
for i in range(nbGen):
   data = np.random.poisson(lam=lambda_val, size=Fm) # nombre oeuf
   noeuf=sum(data) #nombre total d'oeuf
   if noeuf>cap: #depasse capaciter ?
     noeuf=cap
   noeuf=vie_mort(noeuf) # oeuf en vie
   Fm=fille_garcon(noeuf) # femelle
   H=noeuf-Fm # male
   if  H>Fm : #fecondation assez de male ?
     Fm=Fm
   else:
     Fm=H
   print(Fm)
   suivi_Fm.append(Fm) # graphique

y=suivi_Fm
x =range(nbGen)

plt.plot(x, suivi_Fm, marker='o')
plt.title("Courbe de femelles sans lâcher")
plt.xlabel("x")
plt.ylabel("nbre de femelles")
plt.grid(True)
plt.show()



#############################################
### Evolution de la popoulaiton avec lâcher
############################################
   

############################################   
def fertilisation(Fmf,H,Hs):
   Fms=0
   Fmof=0
   for i in range(Fmf):
      resultat = random.choices(['sterile', 'fertile'], weights=[Hs, H])
      if resultat[0] == 'fertile':
         Fmof=Fmof+1
         H = H-1
      else:
         Hs = Hs-1
   return  Fmof
############################################

############################################
def selection(cap,noeufs,noeuff):
   noeufs_new=0
   noeuff_new=0
   for i in range(cap):
      resultat = random.choices(['sterile', 'fertile'], weights=[noeufs, noeuff])
      if resultat[0] == 'fertile':
         noeuff_new=noeuff_new+1
      else:
         noeufs_new=noeufs_new+1
   return  noeuff_new
############################################

##############################################
def fille_garcon_fertile(noeuff):
    Fmf=0
    H=0
    for i in range(noeuff):
        resultat = random.choice(['Femme', 'Homme'])
        if resultat == 'Femme':
         Fmf=Fmf+1
        else:
         H=H+1
    return Fmf

##############################################


def evolution_moustique_lacher(nbGen, cap, nbOeufMoyen,Hs):
   #Simule l'évolution de la population de moustiques avec lâcher
    Fm = round(cap/2) #nombre femelle depart
    Fmos = 0
    Fmof = Fm
    suivi_Fm_lacher = [Fm]
    H = cap-Fm

    for i in range(nbGen):
       print(i)
       noeuff=sum(np.random.poisson(lam=nbOeufMoyen, size=Fmof)) #nombre d'oeuf fertile
       noeufs=sum(np.random.poisson(lam=nbOeufMoyen, size=Fmos)) #nombre oeuf sterile
       noeuf=noeufs+noeuff #total oeuf
       if noeuf>cap: #depasse capaciter ?
          noeuff = selection(cap,noeufs,noeuff)
          noeufs = cap - noeuff
       cap = cap - noeufs
       noeuff=vie_mort(noeuff) # oeuf en vie
       Fmf=fille_garcon(noeuff) # femelle
       H=noeuff-Fmf # male
       if  (H+Hs)>Fmf : #fecondation assez de male ?
          Fmf=Fmf
       else:
          Fmf=H+Hs
       Fmof = fertilisation(Fmf,H,Hs)
       Fmos = Fmf - Fmof
       print(Fmof)
       suivi_Fm_lacher.append(Fmof) # graphique
    return suivi_Fm_lacher


nbOeufMoyen = 70
Hs = 1000
y=evolution_moustique_lacher(nbGen, cap, nbOeufMoyen,Hs)
x =range(nbGen+1)

plt.plot(x, y, marker='o')
plt.title("Courbe de femelles")
plt.xlabel("x")
plt.ylabel("y")
plt.grid(True)
plt.show()








