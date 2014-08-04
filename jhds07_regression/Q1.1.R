# Question 1
x <- c(0.18, -1.54, 0.42, 0.95)
w <- c(2, 1, 3, 1)
z <- x * w
mean(x)
weighted.mean(x,w)


# Question 2
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
cor(x,y)
cor(y,x)
plot(x,y)
sum(x*y) / sum(x^2)  # Regression through origin non-centered


# Question 3
data(mtcars)
lm_cars <- lm(mtcars$mpg ~ mtcars$wt)
lm_cars

lm_cars <- lm(mtcars$wt ~ mtcars$mpg)  # Intentionally Backwards for testing


# Question 4
plot(0,0)
abline(0,.5)


# Question 5
1.5 * .4


# Question 6
x <- c(8.58, 10.46, 9.01, 9.64, 8.86)
mean(x)
sd(x)
(x - mean(x))/sd(x)


# Question 7
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
lm(y ~ x)


# Question 8


# Question 9
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
mean(x)
































