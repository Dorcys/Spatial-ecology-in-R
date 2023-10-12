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

#12.10.2023 Why indivisuals dispersing in sertan plane of landscape
#GDAL
#OSGeo_project
#tarra #predictors 
#Повтор : как виды распределяеются на ландшафте 
library(sdm)
library(terra)

systeam.file ("external/species.shp", package="sdm")
FIL <- system.file("external/species.shp", package = "sdm")
FIL
rana <- vect(FIL)
rana
rana$Occurrence

plot(rana, cex = 0.5, pch = 1)
### Selecting presences

PRES <- rana[rana$Occurrence== 1,]
plot(PRES, cex =0.7, pch = 3)
PRES$Occurrence

#exercise 

rana$absences
ABSE <- rana[rana$Occurrence==0, ]
plot(ABSE)
par(mfrow= c(1,2))
plot(PRES, cex = 0.7, pch = 1)
plot(ABSE,  cex = 1, pch = 3)


### 2 coomands in one place 
MAPof2 <- plot(PRES, cex = 0.7, pch = 1); plot(ABSE,  cex = 1, pch = 3)
MAPof2
par(mfrow =c(1,1))
plot(ABSE)
MAPof2
### End of expirement 

###Выключает чертежи 
dev.off()
###
plot(ABSE, cex = 1, pch = 3, col = "darkblue")
plot(PRES, cex = 1.5, pch = 8, col = "green")

points(ABSE, col = "darkblue", pch = 5)

### predictors look at the path 

path <- system.file("external", package="sdm") 

elev <-  system.file ("external/elevation.asc", package="sdm")
elev
#from terra pack
elevmap <-  rast(elev)
plot(elevmap)
points(PRES, cex = 0.5, pch =3 , col = "blue")

#tempperture predictor

#ОШИБКА

TPE <-  system.file("external/temperature.asc", package="sdm")
TP <- rast(TPE)
TP

plot(TP)


### ОШИБКА 

V <- system.file("external/vegetation.asc", package="sdm")
V
VG <- rast(V)
plot(VG)
points(PRES, pch = 3)

###Precipitaion 

P <- system.file("external/precipitation.asc", package="sdm")
P
PR <- rast(P)
plot(PR)
####

par(mfrow = c(2,2))

plot(PR)
points(PRES)
plot(VG)
points(PRES)
plot(TP)
points(PRES)
plot(elevmap)
points(PRES)


