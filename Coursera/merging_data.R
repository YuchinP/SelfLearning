#merging data on an id similar to joining tables in a RDBMS

if(!file.exists("/.data")){dir.create("./data")}
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1, destfile="./data/reviews.csv")
download.file(fileUrl2, destfile="./data/solutions.csv")
reviews = read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
head(solutions,2)

#merging data with merge()
#important parameters: x, y, by.x, by.y, all
names(reviews)
names(solutions)
#it would try to merge on all the variables with the same names even if they have no connection

mergedData = merge(reviews, solutions, by.x = "solution_id", by.y= "id", all = TRUE) #all = true if there is a value where it doesn't correspond add it anyways
head(mergedData)
#solution id has now taken the place of "id"

#default merge all common column names
intersect(names(solutions), names(reviews))
mergedData2 = merge(reviews, solutions, all = TRUE)
head(mergedData2)

#Alternatively can use join in the plyr package, it's faster but more limited
#cannot merge on names that aren't common
df1 = data.frame(id=sample(1:10), x = rnorm(10))
df2 = data.frame(id=sample(1:10), y= rnorm(10))
arrange(join(df1,df2),id)

#plyr is helpful if you have multiple data frame with same name
df3 = data.frame(id=sample(1:10), z = rnorm(10))
dfList = list(df1,df2,df3)
join_all(dfList)
#merged all 3 on the id column

