# Q1 & 2
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
lm(y ~ x)
plot(x,y)

sd(resid(lm(y ~ x)))
sum(resid(lm(y ~ x)))

# Q3-6
mtcars
mean(mtcars$wt)
fit_cars <- lm(mtcars$mpg ~ mtcars$wt)
plot(mtcars$mpg ~ mtcars$wt)
abline(fit_cars)
fit_cars

fit_cars$coefficients[2] * 2




























