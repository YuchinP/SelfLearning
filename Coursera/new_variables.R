#sequences
s1 <- seq(1,10,by=2) ; s1
#1 is the min value, 10 is the max value, by says what the interval is

s2 <- seq(1,10, length=3);s2
#length will simply split it up by the length number

x <- c(1,3,8,25,100); seq(along=x)
#seq(along) makes a vector like an index for the initial vector

#subsetting variables using the restaurant data again
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/restaurants.csv")
restData <- read.csv("./data/restaurants.csv")

restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)
#returns true if in the neighborhood and false if not new subset of this data

#creating binary variables
restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE) #all cases that zip code is bigger than 0 it returns true
#all cases it returns true it's a wrong zipcode
table(restData$zipWrong, restData$zipCode < 0)


#creating categorical variables
restData$zipGroups = cut(restData$zipCode, breaks=quantile(restData$zipCode))
#breaking up the zip code groups into different groups based on the quantiles
table(restData$zipGroups)
#this will show the values and how many of the zipcodes fall into the clusters
table(restData$zipGroups, restData$zipCode)
#breaks the quantitative into a categorical


#easier cutting
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g = 4) #breaking them up and it determines the quantiles for us
#usage of the cut2 function
table(restData$zipGroups)


#creating factor variables
restData$zcf <- factor(restData$zipCode) #takes input and turns it into a factor variable
restData$zcf
#tells me the usual, but it will also tell me the levels and the type of var is now factor

#levels of factor variables
yesno <- sample(c("yes", "no"), size=10, replace=TRUE)
yesnofac = factor(yesno, levels=c("yes", "no"))
relevel(yesnofac, ref="yes")
#allowed me to relevel "yes " into yes and "no" into no
as.numeric(yesnofac)

#cutting produces factor variables
#using the mutate function to create a new version and add it to a dataset using plyr
library(Hmisc); library(plyr)
restData2 = mutate(restData, zipGroups = cut2(zipCode,g=4))
table(restData2$zipGroups)

#most common transformations
abs(x) #absolute value
sqrt(x) #square root
ceiling(x) #ceiling(3.475) is 4
floor(x) #floor(3.475) is 3
round(x,digits=n) #round(3.475,digits=2) is 3.48
signif(x,digits=n) #signif(3.475, digits = 2) is 3.5
cos(x), sin(x) #ect
log(x) #natural logarithm
log2(x), log10(x) #other common logs
exp(x) #exponentiating x