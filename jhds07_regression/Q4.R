# Q1
library(MASS)
?shuttle
data(shuttle)
head(shuttle)

sm <- glm(use ~ wind, data = shuttle, family = "binomial")
summary(sm)
plot(shuttle$wind, sm$fitted.values)
length(shuttle$wind[shuttle$wind == 'head'])
length(shuttle$wind[shuttle$wind == 'head' & shuttle$use == 'auto'])
length(shuttle$wind[shuttle$wind == 'tail'])
length(shuttle$wind[shuttle$wind == 'tail' & shuttle$use == 'auto'])
exp(sm$coeff)


# Q2
smw <- glm(use ~ wind + magn, data = shuttle, family = "binomial")
summary(smw)
exp(smw$coeff)


# Q3
smn <- glm(use ~ wind, data = shuttle, family = "binomial")
summary(smn)
summary(smn)$coeff
summary(sm)$coeff


# Q4
data(InsectSprays)
head(InsectSprays)
plot(InsectSprays$count, InsectSprays$spray)
plot(InsectSprays$count ~ InsectSprays$spray)
ism <- glm(count ~ as.factor(spray), data = InsectSprays, family = 'poisson')
summary(ism)
exp(ism$coefficients)


# Q5
summary(glm(count ~ as.factor(spray), data = InsectSprays, family = 'poisson'))$coeff
summary(glm(count ~ as.factor(spray), data = InsectSprays, family = 'poisson'))$coeff


# Q6
x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
plot(y ~ y)
length(y)
y[6:11]
x[6:11]
lm(y[6:11] ~ x[6:11])





