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
tapply(mtcars$mpg, mtcars$cyl, mean)
mean(mtcars$mpg, mtcars$cyl)
lapply(mtcars, mean)
split(mtcars, mtcars$cyl)


tapply(mtcars$hp, mtcars$cyl, mean)
mean(mtcars$hp[mtcars$cyl == 8]) - mean(mtcars$hp[mtcars$cyl == 4])
abs(mean(mtcars$hp[mtcars$cyl == 4]) - mean(mtcars$hp[mtcars$cyl == 8]))


debug(ls)
ls()


















