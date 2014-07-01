library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)


library(datasets)
data(airquality)
library(ggplot2)

qplot(Wind, Ozone, data = airquality, geom = "smooth")

airquality = transform(airquality, Month = factor(Month))
qplot(Wind, Ozone, data = airquality, facets = . ~ Month)

qplot(Wind, Ozone, data = airquality)

qplot(Wind, Ozone, data = airquality, facets = . ~ factor(Month))


library(ggplot2)
g <- ggplot(movies, aes(votes, rating))
print(g)


qplot(votes, rating, data = movies)

qplot(votes, rating, data = movies, smooth = "loess")
qplot(votes, rating, data = movies) + geom_smooth()
qplot(votes, rating, data = movies) + stats_smooth("loess")
qplot(votes, rating, data = movies, panel = panel.loess)

qplot(votes, rating, data = movies) + geom_smooth(method='auto')
qplot(votes, rating, data = movies) + geom_smooth(method='lm')
















