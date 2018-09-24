library(MASS)
library(nnet)
library(rstanarm)
library(rstan)
Loan <- read.csv("/Users/ajay/Downloads/Bayesian Linear Regression with Sampling_R/Loan_data_filtered.csv")
attach(Loan)
# Multinomial Logistic Regression
Y_1 <- cbind(grade)
#X <- cbind(funded_amnt,funded_amnt_inv,int_rate,term,emp_length,home_ownership,pymnt_plan,revol_bal,total_pymnt,last_pymnt_amnt,loan_amnt)
X_1 <- cbind(funded_amnt,funded_amnt_inv,int_rate)
#describing data
summary(Y_1)
summary(X_1)
table(Y_1)
#fitting
multi_logit <- multinom(Y_1 ~ X_1, data=Loan)
print(multi_logit)
fitted_logit <- predict(multi_logit, newdata=Loan, type="probs")
#Ordinal regression
X <- cbind(grade,funded_amnt,funded_amnt_inv,int_rate)
summary(X)
ologit <- polr(formula = as.factor(grade) ~ funded_amnt + funded_amnt_inv + int_rate, data = X, Hess = TRUE)
print(ologit)
fitted <- predict(lol,newdata= Loan,type ="probs")
#Bayesian Multinomial Logistic
y = cbind(grade)
x = cbind(funded_amnt,funded_amnt_inv,int_rate)
y_improved <- as.double(y)
stan_data <- list(K =7, N = 887379 , D = 3 , y = y_improved , x = x)
fitz <-stan(file ='/Users/ajay/Downloads/Bayesian Linear Regression with Sampling_R/data2.stan', data = stan_data, warmup = 10, iter = 1, chains = 4, cores = 4, thin = 1)

