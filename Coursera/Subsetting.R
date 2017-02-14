#Subsetting

set.seed(13435)
x <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
x <- x[sample(1:5),]; x$var2[c(1,3)] = NA
x


#specific column
x[,1]
x[,"var1"]
x[1:2,"var2"]


#logicals ands and ors
x[(x$var1 <= 3 & x$var3 > 11),] #usage of the and statement

x[(x$var1 <= 3 | x$var3 > 15),] #usage of the pipe(or) statement

#dealing with missing values
x[which(x$var2 > 8),] #usage of the which command

#sorting
sort(x$var1) #ascending sort

sort(x$var1, decreasing = TRUE) #descending sort

sort(x$var2, na.last = TRUE) #sort that puts the "NA" last

#ordering
x[order(x$var1),] #ordered all the rows by variable 1

x[order(x$var1, x$var3),] #orders by variable 1 and then by 3

#Ordering with "plyr" package
library(plyr)
arrange(x,var1) #arrange is part of the plyr package
#takes the dataframe and then a variable that it will sort on

arrange(x, desc(var1))

#adding rows and columns to dataframes
x$var4 <- rnorm(5) #x$var4 isn't in the current dataset so we define it
x

#using cbind instead
y <- cbind(x,rnorm(5))
y
#we can also bind new rows just using the rbind command

