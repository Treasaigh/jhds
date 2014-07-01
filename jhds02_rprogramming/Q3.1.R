library(datasets)
data(iris)
?iris
head(iris)


mean(iris$Sepal.Length)
levels(iris$Species)
mean(iris$Sepal.Length[iris$Species == 'virginica'])


apply(iris[, 1:4], 2, mean)
colMeans(iris)
apply(iris, 1, mean)
apply(iris[, 1:4], 1, mean)


library(datasets)
data(mtcars)
head(mtcars)


table(mtcars$cyl)
with(mtcars, tapply(mpg, cyl, mean))
tapply(mtcars$cyl, mtcars$mpg, mean)
sapply(mtcars, cyl, mean)
split(mtcars, mtcars$cyl)


mean(mtcars$mpg[mtcars$cyl == 4]) - mean(mtcars$mpg[mtcars$cyl == 8])


debug(ls)
ls()


















