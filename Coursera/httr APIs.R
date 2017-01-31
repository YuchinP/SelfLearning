library(httr)
myapp <- oauth_app("twitter",
                   key = "yourkeyhere", secret = "yoursecrethere")
sig <- sign_oauth1.0(myapp,
                     token = "yourtokenhere",
                     token_secret = "yoursecrethere")
homeTL <- GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

library(jsonlite)
json1 <- content(homeTL)
json2 <- jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]


##httr allows GET, POST, PUT, DELETE requests if authorized
##can authenticate with a user/pass
##most modern APIs use something like oauth though
##httr works well with Facebook, Google, Twitter, Github, ect