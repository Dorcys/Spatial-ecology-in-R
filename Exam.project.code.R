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
inB2020 <- rast("IFC2020.jpg")
#Checking is everything correct
inB2020
plot(inB2020)
#Download last 3 images
inB2024 <- rast("IFC2024.jpg")
mB2020 <- rast("MFC2020.jpg")
mB2024 <- rast("MFC2024.jpg")
par(mfrow = c(2,2))
plot(inB2020)
plot(inB2024)
plot(mB2020)
plot(mB2024)
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
im.plotRGB(c_inB2020, r=3,g=1,b=2)
im.plotRGB(c_inB2024, r=3,g=1,b=2)
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
inNDVI0 <- (c_inB2020[[1]] - c_inB2020[[2]]) / (c_inB2020[[1]] + c_inB2020[[2]])  
inNDVI4 <- (c_inB2024[[1]] - c_inB2024[[2]]) / (c_inB2024[[1]] + c_inB2024[[2]]) 
mNDVI0 <- (c_mB2020[[1]] - c_mB2020[[2]]) / (c_mB2020[[1]] + c_mB2020[[2]])
mNDVI4 <- (c_mB2024[[1]] - c_mB2024[[2]]) / (c_mB2024[[1]] + c_mB2024[[2]])

par(mfrow = c (2,2))
plot(inNDVI0)
plot(inNDVI4)
plot(mNDVI0)
plot(mNDVI4)
dev.off()
#Change in NDVI
NDVI_diff_IN <- inNDVI4 - inNDVI0
NDVI_diff_M <- mNDVI4 - mNDVI0
plot(NDVI_diff_IN, main="NDVI Change - Indigenous Land")
plot(NDVI_diff_M, main="NDVI Change - Modern Land")

summary(values(NDVI_diff_IN))
summary(values(NDVI_diff_M))

t.test(values(NDVI_diff_IN), values(NDVI_diff_M))

#Perform PCA 
inB0_PCA <- im.pca2(c_inB2020)
inB4_PCA <- im.pca2(c_inB2024)
mB0_PCA <- im.pca2(c_mB2020)
mB4_PCA <- im.pca2(c_mB2024)

#Extract 1 PCA
ipc10 <- inB0_PCA$PC1
ipc14 <- inB4_PCA$PC1
mpc10 <- mB0_PCA$PC1
moc14 <- mB4_PCA$PC1

#Changes 
pc1_diff_IN <- ipc14 - ipc10  # Change in Indigenous land
pc1_diff_M <- moc14 - mpc10    # Change in Modern land
pc1_diff_IN
pc1_diff_M

#Visualization 
par(mfrow=c(1,2))  
plot(pc1_diff_IN, main="PCA Difference - Indigenous Land")  
plot(pc1_diff_M, main="PCA Difference - Modern Land")  

#Quantifying Forest Loss
forest_loss_IN <- sum(pc1_diff_IN[] < 0, na.rm=TRUE) / ncell(pc1_diff_IN) * 100
forest_loss_M <- sum(pc1_diff_M[] < 0, na.rm=TRUE) / ncell(pc1_diff_M) * 100
print(paste("Forest loss in Indigenous land:", round(forest_loss_IN, 2), "%"))
print(paste("Forest loss in Modern land:", round(forest_loss_M, 2), "%"))
