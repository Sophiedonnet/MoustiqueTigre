Capacity_eggs = 50000 ### max capacity
N_0 = 10
Mean_eggs = 30 

N_weeks = 12; 
mortality = 0.01

#----------------------------------------Aucun contrôle -------------------------------------- 

#########################" Au début
N_Eggs = N_0

evolution_N_Eggs <- c(N_Eggs)
###############################" Evolution du nombre  

for (week in 1:N_weeks){
  # mortalité pendant le développemment de larves 
  N_Eggs <- rbinom(1,N_Eggs,1-mortality) 

  # 50 / 50 deviennent male ou female 
  N_Female <-  rbinom(1,N_Eggs,0.5)  
  N_Male <- N_Eggs - N_Female

  # Mortalité à l'age adulte: 
  N_Female <-  rbinom(1,N_Female,1-mortality)  
  N_Male <- rbinom(1,N_Male,1-mortality)  

  
  # Accouplement et ponte 
  N_Eggs_new = 0 
  for (i in 1:N_Female){
    if(N_Male>0){
      N_Eggs_new <- N_Eggs_new + rpois(1,Mean_eggs)
      N_Male = N_Male-1 
    }
  }
  if(N_Eggs_new > Capacity_eggs){N_Eggs=Capacity_eggs}else{N_Eggs = N_Eggs_new}
  evolution_N_Eggs <- c(evolution_N_Eggs,N_Eggs)
  print(c(N_Eggs))
  
}

plot(0:N_weeks,evolution_N_Eggs,type='l')


#---------------------------------------- Avec lâcher -------------------------------------- 

#########################" Au début
N_EggsViable = Capacity_eggs
N_EggsSterile <- 0 
evolution_N_EggsViable <- c(N_EggsViable)
N_Male_sterile_lacher  = 50000
###############################" Evolution du nombre  

for (week in 1:N_weeks){
  
  # mortalité pendant le développemment de larves 
  N_EggsViable <- rbinom(1,N_EggsViable,1-mortality) 
  
  # 50 / 50 deviennent male ou female 
  N_Female <-  rbinom(1,N_EggsViable,0.5)  
  N_Male <- N_EggsViable - N_Female
  N_EggsViable = 0 
  
  # Mortalité à l'age adulte: 
  N_Female <-  rbinom(1,N_Female,1-mortality)  
  N_Male <- rbinom(1,N_Male,1-mortality)  
  
  ## lacher de mâles stériles
  N_Male_sterile <- N_Male_sterile_lacher
  
  # Accouplement avec mâle normal ou mâle stérile  et  ponte 

  
  for (i in 1:N_Female){
    ### elle choisit un mâle 
    if((N_Male+ N_Male_sterile)>0){
      pMale <- N_Male / (N_Male+ N_Male_sterile)
      Male_i <- sample(c('Male','MaleSterile'),1,prob = c(pMale,1-pMale))
      if (Male_i=='Male'){
        N_EggsViable <- N_EggsViable + rpois(1,Mean_eggs)
        N_Male <- N_Male - 1 
      }else{
        N_EggsSterile<- N_EggsSterile + rpois(1,Mean_eggs)
        N_Male_sterile <- N_Male_sterile-1
      }
    }
  }
  if((N_EggsViable + N_EggsSterile) > Capacity_eggs){
    pop_Eggs <- c(rep("Fertile",N_EggsViable ), rep("Sterile",N_EggsSterile))
    pop_Eggs <- sample(pop_Eggs,Capacity_eggs,replace  = FALSE)
    N_EggsViable <- sum(pop_Eggs=="Fertile")
    N_EggsSterile <- sum(pop_Eggs=="Sterile")
  }
  evolution_N_EggsViable <- c(evolution_N_EggsViable,N_EggsViable)
  print(c(N_EggsViable))
  
}

plot(0:N_weeks,evolution_N_EggsViable,type='l',ylim=c(0,50000))




