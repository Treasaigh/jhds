# Q1
data(mtcars)
summary(lm(mpg ~ as.factor(cyl) + wt, mtcars))
summary(lm(mpg ~ as.factor(cyl), mtcars))








#Q4
lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)
summary(lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars))




#Q5-6
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
plot(x,y)
lm.influence(lm(y ~ x))

dfbetas(lm(y ~ x))









