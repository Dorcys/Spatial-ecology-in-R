### import data
?read.table
StudData <- read.table("StudDataset.csv", header = T, sep = ",")
class(StudData)
View(StudData)


###


stud.df <- StudData [ , -c(1, ncol(StudData))]
ncol(stud.df)
nrow(stud.df)
str(stud.df)

###Change names of colums

names(stud.df) <- c("age", "Height", "Country", "City" , "Roommate" , "Travel" , "KM" , "Skmow", "HS", "UP", "UR", "UR", "RC")

str(stud.df)
View(stud.df)

which(stud.df$Height<100)

stud.df$Height[ stud.df$Height < 100] <- 181

### Country

class(stud.df$Country)


stud.df$Country[stud.df$Country == "ITALY"] <-  "Italy"
stud.df$Country[stud.df$Country == "italy"] <-  "Italy"
stud.df$Country[stud.df$Country == "Italy "] <-  "Italy"
stud.df$Country[stud.df$Country == "SPAIN"] <-  "Spain"
as.factor(stud.df$Country)

### Transform intro a factor in the dataframe 
stud.df$Country <-  as.factor(stud.df$Country)

###Romemates

stud.df$Roommate [ stud.df$Roommate > 10] <-  NA

##km_travel

class(stud.df$km_travel)
as.numeric(stud.df$KM)

#create  a vector with posion  incorrecot postions

idx <- (is.na(as.numeric(stud.df$KM))
idx
    
    stud.df$KM[idx]
stud.df$KM[stud.df$KM=="600 metro"] <- 0.6   

stud.df$KM[idx[2]] <-  2

view(stud.df$KM)
View(stud.df$KM)


stud.df$KM <-  as.numeric(stud.df$KM)

View(stud.df)
