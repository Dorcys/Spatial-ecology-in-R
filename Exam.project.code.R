###1.Abstract
#The goal of this project is compare difference between 
#indigenous people land and modern day Brazil
#We would compare changes in tree cover from 2020 to 2024\
#Comparing NDVI values

###2.Preparing for analysis
#Downloading packages
install.packages("imageRy")
install.packages("terra")
install.packages("viridis")
install.packages("ggplot2")

#To use them, we need type additional command
library(imageRy) 
library(terra)
library(viridis) 
library(ggplot2) 

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

#Calculation of DVI & NDVI
#Plot NIR band to see representation of vegetation  
plot(c_inB2020[[1]])
plot(c_mB2020[[1]])

#Calculate the Difference Vegetation Index (DVI)
inDVI0 <- c_inB2020[[1]] - c_inB2020[[2]]
inDVI4<- c_inB2024[[1]] - c_inB2024[[2]]
mDVI0 <- c_mB2020[[1]] - c_mB2020[[2]]
mDVI4 <- c_mB2024[[1]] - c_mB2024[[2]]

# Calculate the Normalized Difference Vegetation Index (NDVI)
inNDVI0 <- (c_inB2020[[1]] - c_inB2020[[2]]) / (c_inB2020[[1]] + c_inB2020[[2]])  
inNDVI4 <- (c_inB2024[[1]] - c_inB2024[[2]]) / (c_inB2024[[1]] + c_inB2024[[2]]) 
mNDVI0 <- (c_mB2020[[1]] - c_mB2020[[2]]) / (c_mB2020[[1]] + c_mB2020[[2]])
mNDVI4 <- (c_mB2024[[1]] - c_mB2024[[2]]) / (c_mB2024[[1]] + c_mB2024[[2]])
summary(values(inNDVI0))
summary(values(inNDVI4))
summary(values(mNDVI0))
summary(values(mNDVI4))

#Change in DVI 
DVI_diff_IN <- inDVI4 - inDVI0
DVI_diff_M <- mDVI4 - mDVI0
summary(values(DVI_diff_IN))
summary(values(DVI_diff_M))

#Change in NDVI
NDVI_diff_IN <- inNDVI4 - inNDVI0
NDVI_diff_M <- mNDVI4 - mNDVI0
summary(values(NDVI_diff_IN))
summary(values(NDVI_diff_M))
t.test(values(NDVI_diff_IN), values(NDVI_diff_M))

#Perform PCA 
inB0_PCA <- im.pca2(c_inB2020)
inB4_PCA <- im.pca2(c_inB2024)
mB0_PCA <- im.pca2(c_mB2020)
mB4_PCA <- im.pca2(c_mB2024)

#Extract First PCA as most important
ipc10 <- inB0_PCA$PC1
ipc14 <- inB4_PCA$PC1
mpc10 <- mB0_PCA$PC1
moc14 <- mB4_PCA$PC1

#Changes of cover in different type of land
# Change in Indigenous land
pc1_diff_IN <- ipc14 - ipc10
# Change in Modern land
pc1_diff_M <- moc14 - mpc10
pc1_diff_IN
pc1_diff_M

#Quantifying Forest Loss
forest_loss_IN <- sum(pc1_diff_IN[] < 0, na.rm=TRUE) / ncell(pc1_diff_IN) * 100
forest_loss_M <- sum(pc1_diff_M[] < 0, na.rm=TRUE) / ncell(pc1_diff_M) * 100
print(paste("Forest loss in Indigenous land:", round(forest_loss_IN, 2), "%"))
print(paste("Forest loss in Modern land:", round(forest_loss_M, 2), "%"))
# Convert to hectares
# Get resolution in square meters
res_m2 <- res(NDVI_diff_IN)[1] * res(NDVI_diff_IN)[2]
area_lost_IN <- sum(NDVI_diff_IN[] < 0, na.rm=TRUE) * res_m2 / 10000
area_lost_M <- sum(NDVI_diff_M[] < 0, na.rm=TRUE) * res_m2 / 10000  
print(paste("Forest loss in Indigenous land:", round(area_lost_IN, 2), "hectares"))
print(paste("Forest loss in Modern land:", round(area_lost_M, 2), "hectares"))


###4.Data visualization
#This part of code dedicated for creating images for presentation 
#DVI & NDVI

plot(DVI_diff_IN, col=viridis(100), main="DVI Change - Indigenous Land")
legend("bottomright", legend=c("Decrease", "No Change", "Increase"),
       fill=viridis(3), bty="n")

plot(DVI_diff_M, col=viridis(100), main="DVI Change - Modern land")
legend("bottomright", legend=c("Decrease", "No Change", "Increase"),
       fill=viridis(3), bty="n")

plot(NDVI_diff_IN, col=viridis(100), main="NDVI Change - Indigenous Land")
legend("bottomright", legend=c("Decrease", "No Change", "Increase"),
       fill=viridis(3), bty="n")

plot(NDVI_diff_M, col=viridis(100), main="NDVI Change - Modern land")
legend("bottomright", legend=c("Decrease", "No Change", "Increase"),
       fill=viridis(3), bty="n")

#Histogram for NDVI 
hist(values(NDVI_diff_IN), breaks=50, col=viridis(100), main="NDVI Change - Indigenous Land", xlab="NDVI Change")
hist(values(NDVI_diff_M), breaks=50, col=viridis(100), main="NDVI Change - Modern Land", xlab="NDVI Change")

#PCA
plot(PCA_diff_IN, col=viridis(100), main="PCA Change - Indigenous Land")  
legend("bottomright", legend=c("Decrease", "No Change", "Increase"),
       fill=viridis(3), bty="n") 

plot(PCA_diff_M, col=viridis(100), main="PCA Change - Modern land")  
legend("bottomright", legend=c("Decrease", "No Change", "Increase"),
       fill=viridis(3), bty="n")
