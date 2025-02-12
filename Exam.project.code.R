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
#Note: Use for cleaning plots dev.off()
#Stacking images for further analysis
stackedIN <- c(c_inB2020[[1:3]], c_inB2024[[1:3]])
stackedM <- c(c_mB2020[[1:3]], c_mB2024[[1:3]])
plot(stackedM)

#Calculation of NDVI
#Ploting RGB version of our images
im.plotRGB(c_inB2020, r=3,g=2,b=1)
im.plotRGB(c_inB2024, r=3,g=2,b=1)
dev.off()
#Plot the NIR band 
plot(c_inB2020[[1]])
#Calculate the Difference Vegetation Index (DVI)
inDVI0 <- c_inB2020[[1]] - c_inB2020[[2]]
inDVI4<- c_inB2024[[1]] - c_inB2024[[2]]
par(mfrow = c (2,1))
plot(inDVI0)
plot(inDVI4)
# Calculate the Normalized Difference Vegetation Index (NDVI)
inNDVI0 <- (c_inB2020[[1]] - c_inB2020[[2]]/(c_inB2020[[1]] + c_inB2020[[2]]))
plot(inNDVI0)
