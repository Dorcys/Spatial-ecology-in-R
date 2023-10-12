###Spatial ecology in R 10.10.2023
### Instaling some packages 
install.packages("sdm")
library(sdm)
###
install.packages("terra")
library(terra)
###
version
install.packages("Rtools")
library(Rtools)
###
install.packages("rgdal")
library(rgdal)
###
###BIOME biodiversity and microecology  monday 16 via sembi 2
### Density of individuals or dispertion = spasing population 
install.packages("spatstat")
library(spatstat)
###

bei
plot(bei, cex = .95, pch =8, add=T)

plot(bei.extra$elev)
E11 <- (bei.extra$elev)
E11
density(bei)
dmap <-  density(bei)
dmap
plot(dmap)
### функция поинтс points  наслаивает новую карту а не убиарет 
points(bei)
###

#multiframe

par(mfrow=c(1,4))
### функция отвечает за количество карт на экране работает как матрица 
plot(dmap)
plot(E11)
plot(bei.extra$grad)
plot(bei)

par(mfrow=c(1,1))

plot(E11)
points(bei)

### высота не предсказуема а плотность реузльтат  
### не факт конечно что высоты но результат чего-то 
### Так в статистики придумали а мы теперь живем с этим хз как но живем
### от точек до плотности потом в ОС а потом наложим все это красиво очень так что бы вообщее вау****


