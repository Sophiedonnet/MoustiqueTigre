C = 10000### max capacity
N_0 = 2 
mean_N_eggs = 30 

N_T = 10; 

#----------------------------------------Aucun contrôle -------------------------------------- 
N_pop = N_0 
N_F = rbinom(1,N_pop,0.5)  
Pop  = c(rep('F',N_F), rep('M',N_pop-N_F))

Size_Pop <- rep(0,N_T)
Size_Pop[1]<- 10 
for (t in 2:N_T){
  
  new_Pop <- c()
  for (i in 1:N_pop){
    if (Pop[i]=='F'){
      N_eggs <-  rpois(1,mean_N_eggs )
      new_Pop <- c(new_Pop,sample(c('F','M'),N_eggs,replace = TRUE))
    }
  }
  Pop <- new_Pop
  N_pop <- length(Pop)
  
  if (N_pop>C){
    Pop <- sample(Pop,C,replace=FALSE)
    N_pop <- length(Pop)
  }
  Size_Pop[t] = N_pop 
  print(c(t,N_pop))
}

plot(1:N_T,Size_Pop,type='l')


#----------------------------------------Produit chimique radical -------------------------------------- 



#---------------------------------------- Lacher males stériles------------------------------------- 
N_pop = C 
N_F = rbinom(1,N_pop,0.5)  
Pop  = c(rep('F',N_F), rep('M',N_pop-N_F))

Size_Pop <- rep(0,N_T)
Size_Pop[1]<- 10 
for (t in 2:N_T){
  
  new_Pop <- c()
  for (i in 1:N_pop){
    if (Pop[i]=='F'){
      N_eggs <-  rpois(1,50)
      new_Pop <- c(new_Pop,sample(c('F','M'),N_eggs,replace = TRUE))
    }
  }
  Pop <- new_Pop
  N_pop <- length(Pop)
  
  if (N_pop>C){
    Pop <- sample(Pop,C,replace=FALSE)
    N_pop <- length(Pop)
  }
  Size_Pop[t] = N_pop 
  print(c(t,N_pop))
}

plot(1:N_T,Size_Pop,type='l')



