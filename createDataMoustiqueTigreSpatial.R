mytable<- read.delim("~/WORK_ALL/MEDIATION/LesMouettesSavantes/MoustiqueTigre/DataMoustiqueTigre/DonneesPresenceTemporelle.csv")
head(mytable)


mytable  <- cbind(mytable,matrix(0,nrow(mytable),2))
mytable[,7:25] = 0 
names(mytable)[7:27]<- as.character(2004:2024)
head(mytable)

### 
ncol<- ncol(mytable)
year <- 2004; col <- year -2004+7
mytable[6,col:ncol]=1

#year <- 2005; col <- year -2004+2
#mytable[,col]=NA

year <- 2006; col <- year -2004+7
mytable[96,col:ncol]=1


year <- 2007; col <- year -2004+7
mytable[c(83,95),col:ncol]=1

#year <- 2008; col <- year -2004+2
#mytable[,col]=NA

#year <- 2009; col <- year -2004+2
#mytable[,col]=NA

year <- 2010; col <- year -2004+7
mytable[c(13,04),col:ncol]=1


year <- 2011; col <- year -2004+7
mytable[c(84,30,34),col:ncol]=1


year <- 2012; col <- year -2004+7
mytable[c(66,11,31,26,07,38,69,47),col:ncol]=1


year <- 2013; col <- year -2004+7
mytable[c(33),col:ncol]=1

year <- 2014; col <- year -2004+7
mytable[c(73,71),col:ncol]=1



year <- 2015; col <- year -2004+7
mytable[c(01,81,82,46,24,40,64,67,85,94),col:ncol]=1

year <- 2016; col <- year -2004+7
mytable[c(12,68,32),col:ncol]=1


year <- 2017; col <- year -2004+7
mytable[c(48,19,36,02,92,05),col:ncol]=1


year <- 2018; col <- year -2004+7
mytable[c(17,63,42,21,91,77,75,93,58),col:ncol]=1



year <- 2019; col <- year -2004+7
mytable[c(78,44,79,86,36,16,18,74),col:ncol]=1

year <- 2019; col <- year -2004+7
mytable[c(78,44,79,86,36,16,18,74),col:ncol]=1

year <- 2020; col <- year -2004+7
mytable[c(53,87,15,39,25),col:ncol]=1


year <- 2021; col <- year -2004+7
mytable[c(45,54),col:ncol]=1

year <- 2022; col <- year -2004+7
mytable[c(41,35,03),col:ncol]=1


year <- 2023; col <- year -2004+7
mytable[c(76,60,46,57,90,89,72),col:ncol]=1

year <- 2024; col <- year -2004+7
mytable[c(51,52,70),col:ncol]=1



DonneesPresenceDépartementMoustique <- as.data.frame(mytable)
head(DonneesPresenceDépartementMoustique)
write.csv(DonneesPresenceDépartementMoustique,file='DataMoustiqueTigre/DonnesPresenceDepartementMoustique.csv')


