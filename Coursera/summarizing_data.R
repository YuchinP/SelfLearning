if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/restaurants.csv")
restData <- read.csv("./data/restaurants.csv")

#summarize
head(restData,n=3)
tail(restData,n=3)

summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm=TRUE) #na.rm removes the NA values
quantile(restData$councilDistrict, probs = c(0.5,0.75,0.9)) #probs let's you choose what quantiles you want to look at

#make a table
table(restData$zipCode, useNA="ifany")#shows all the values and how many of each there is
#we have one zip code that's coded negatively which needs to be fixed
table(restData$councilDistrict, restData$zipCode)

#check for missing values
sum(is.na(restData$councilDistrict))
#output: 0
any(is.na(restData$councilDistrict))
#output: False
all(restData$zipCode > 0)
#output: False

#row and column sums
colSums(is.na(restData))

all(colSums(is.na(restData))==0)

#values with specific characteristics
table(restData$zipCode %in% c("21212")) #are there any value in this
table(restData$zipCode %in% c("21212", "21213")) #in either 21212 or 21213

restData[restData$zipCode %in% c("21212","21213"),] #shows only the points that have these zip codes


#crosstabs
data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)
summary(DF)

xt <- xtabs(Freq ~ Gender + Admit, data=DF)
xt

#flat tables
warpbreaks$replicate <- rep(1:9, len = 54) #warpbreaks is a default dataset, replicating data into it
xt = xtabs(breaks ~., data=warpbreaks) #we have 3 different variables so it breaks it down for us
xt #multiple 2d tables 

ftable(xt) #makes it in a much smaller and compact form

#size of a dat set
fakeData = rnorm(1e5)
object.size(fakeData)

print(object.size(fakeData), units="Mb")
