#Sum
# 01 Beginig ------- 
#First lessons with spatstat packages
#package need for pattern analyssis
install.packages("spatstat")
library(spatstat)
###
bei
plot(bei)
plot(bei, cex=1, pch=20)
bei.extra
plot(bei.extra)
###
# lets use only part of the dataset: elev
plot(bei.extra$elev)
e11 <- plot(bei.extra$elev)
e11
plot(e11)
bei.extra[1]
plot(bei.extra[1])

# 02 -------------
