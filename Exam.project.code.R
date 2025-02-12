###1.Abstract
#The goal of this project is compare difference between 
#indigenous people land and modern day Brazil
#We would compare changes in tree cover from 2020 to 2024\
#Comparing NDVI values

###2.Preparing for analysis
#Downloading packages
install.packages("imageRy")
install.packages("terra")
#To use them, we need type additional command
library(imageRy)
library(terra)

###3.Analysis
#Downloading pictures
inB2020 <- rast("I2020.jpg")
#Checking is everything correct
inB2020
plot(inB2020)
#Download last 3 images
inB2024 <- rast("I2024.jpg")
mB2020 <- rast("M2020.jpg")
mB2024 <- rast("M2024.jpg")
