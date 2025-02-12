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

#Cropping  pictures 
#Original images from Copernicus observatory have No Data areas 
crop_ext <- ext(100,775,100,775)
c_inB2020 <- crop(inB2020,crop_ext)
c_inB2024 <- crop(inB2024,crop_ext)
c_mB2024 <- crop(mB2024,crop_ext)
c_mB2020 <- crop(mB2020,crop_ext)

#Plotting images in grid to see difference
par(mfrow = c(2,2))
plot(c_inB2020)
plot(c_inB2024)
plot(c_mB2020)
plot(c_mB2024)
#Use for cleaning plots dev.off()
