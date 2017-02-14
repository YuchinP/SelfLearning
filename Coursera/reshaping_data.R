library(reshape2)
head(mtcars) #mtcars is a default r dataset based on cars

mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars,id=c("carname", "gear", "cyl"), measure.vars=c("mpg", "hp"))
#identify which of the vars are ID vars and which are measureable vars
head(carMelt,n=3)
tail(carMelt,n=3)

#casting dataframes
cylData <- dcast(carMelt, cyl ~ variable) #recast the melted data with dcast into cylinders broken down by the variables
#variable will do both our measured ones mpg and hp
cylData
# produces a much smaller dataset to work with

cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData
#resummarize and reorganizing the data in different ways

#averaging values
head(InsectSprays)# InsectSprays is a default R dataset

tapply(InsectSprays$count, InsectSprays$spray,sum) #tapply is to apply along an index of a function
#within each value of spray it will provide a sum

#another way
spIns = split(InsectSprays$count, InsectSprays$count)
spIns
#provided a list instead we can apply new things to
sprCount = lapply(spIns,sum)
sprCount
#two ways to transform the list back into a vector
unlist(sprCount)
sapply(spIns,sum)

#using the plyr package to do it
ddply(InsectSprays,.(spray), summarise,sum=sum(count)) # we have to use .() so we don't have to use ""
#quick way to do the split apply combine process

#creating a new variable
spraySums <- ddply(InsectSprays,.(spray), summarise, sum=ave(count,FUN=sum))
dim(spraySums)
head(spraySums)
