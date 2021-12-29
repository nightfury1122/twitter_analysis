Gates <- get_timeline("@JakeG_Online", n= 3200)
# Remove retweets
Gates_tweets_organic <- Gates[Gates$is_retweet==FALSE, ] 
# Remove replies
Gates_tweets_organic <- subset(Gates_tweets_organic, is.na(Gates_tweets_organic$reply_to_status_id))
Gates_tweets_organic <- Gates_tweets_organic %>% arrange(-favorite_count)
Gates_tweets_organic[1,5]
Gates_tweets_organic <- Gates_tweets_organic %>% arrange(-retweet_count)
Gates_tweets_organic[1,5]
# Keeping only the retweets
Gates_retweets <- Gates[Gates$is_retweet==TRUE,]
Gates_replies <- subset(Gates, !is.na(Gates$reply_to_status_id))
# Creating a data frame
data <- data.frame(
  category=c("Organic", "Retweets", "Replies"),
  count=c(2856, 192, 120)
)
# Adding columns 
data$fraction = data$count / sum(data$count)
data$percentage = data$count / sum(data$count) * 100
data$ymax = cumsum(data$fraction)
data$ymin = c(0, head(data$ymax, n=-1))
# Rounding the data to two decimal points
#install.packages("forestmangr")
library(forestmangr)
data <- round_df(data, 2)
# Specify what the legend should say
Type_of_Tweet <- paste(data$category, data$percentage, "%")
library(ggplot2)
ggplot(data, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=Type_of_Tweet)) +
  geom_rect() +
  coord_polar(theta="y") + 
  xlim(c(2, 4)) +
  theme_void() +
  theme(legend.position = "right")
summary(cars)
```

## Including Plots

You can also embed plots, for example:
  
  ```{r pressure, echo=FALSE}
plot(pressure)