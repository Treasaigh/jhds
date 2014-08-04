library(datasets)
library(MASS)
data(mtcars)

# EDA
head(mtcars)
summary(mtcars)
summary(mtcars$mpg)
c(avg = mean(mtcars$mpg), 
  sigma = sd(mtcars$mpg), 
  sig_hi = mean(mtcars$mpg) + 2 * (sd(mtcars$mpg)),
  sig_lo = mean(mtcars$mpg) - 2 * (sd(mtcars$mpg)))
table(mtcars$am)
by(mtcars$mpg, mtcars$am, summary)

# 1 Var Fit
test_vars <- c('mpg','cyl','disp','hp','wt','gear','carb')
pairs(x = mtcars[,test_vars], 
      panel = panel.smooth,
      main = 'Pairs Plot with Smoothing for MTCars Attributes')

cor(mtcars$mpg, mtcars$am)

fit_1var <- lm(mtcars$mpg ~ mtcars$am)
summary(fit_1var)
summary(fit_1var)$coefficients

par(mfrow = c(1,2))
plot(mtcars$am, mtcars$mpg, main = '1 Variable Regression: MPG vs Transmission')
abline(fit_1var)
plot(mtcars$am, resid(fit_1var), main = 'Residuals: 1 Variable Exploratory')
abline(h = 0)


layout(matrix(c(1,2,3,4),2,2))
plot(fit_1var, main = 'Single Variable: mpg vs transmission')


# Multi-variate fit
fit_multi <- lm(mpg ~ . , data = mtcars)
summary(fit_multi)

step_fit <- glm(mpg ~ as.factor(am) + as.factor(cyl) + as.factor(gear) + disp + hp + drat + wt, data = mtcars)
model_fit <- stepAIC(step_fit, direction = 'both')
model_fit$anova
final_model <- glm(mpg ~ as.factor(am) + as.factor(cyl) + hp + wt, data = mtcars)
summary(final_model)

layout(matrix(c(1,2,3,4),2,2))
plot(final_model, main = 'Final Model: mpg vs transmission and other factors')























