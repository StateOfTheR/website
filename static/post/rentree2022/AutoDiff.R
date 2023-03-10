## -----------------------------------------------------------------------------
rm(list=ls())
library(tidyverse)
library(torch)



        #### Load the data, perform classical GLM



## -----------------------------------------------------------------------------
data("iris")
xtrain <- iris[51:150,1:4] %>% 
  {cbind(Intercept=rep(1,100),.)} %>% ## Add a column for the intercept
  as.matrix %>% ## Transform into matrix to be passed to torch
  torch_tensor
ytrain <- (iris[51:150,5]!="versicolor") %>% as.numeric %>% torch_tensor

## -----------------------------------------------------------------------------
## GLM
GLM <- glm(Species ~ ., data = iris[51:150,],family = "binomial")
Coefs <- GLM$coefficients

## -----------------------------------------------------------------------------



       #### Perform inference using torch



## First define the parameter
theta <- rep(0,ncol(xtrain)) %>% ## Initial value 
  torch_tensor(.,requires_grad = TRUE) ## Must track gradient to perform GD!

logistic_loglik <- function(theta, x, y){
  ## Compute x_i*theta
  scores <- torch_matmul(x, theta)
  log_lik <- torch_dot(y, scores) - torch_sum(torch_log(1 + torch_exp(scores)))
  return(-log_lik)
}

## Check
logistic_loglik(theta, xtrain, ytrain)



        #### Gradient descent loop



## Define the optimization setting
# Choose the optimization procedure
theta_optimizer <- optim_adam(theta)
# Provide the number of iterations
num_iterations <- 100

## Create a vector to store the evaluation of the LogLik at each step
loglik_vector <- vector("numeric", length = num_iterations)

## Write the loop
for (i in 1:num_iterations) {
  ## Set the derivatives at 0
  theta_optimizer$zero_grad()
  ## Forward
  # Loss computed for each observation
  loglik <- logistic_loglik(theta, xtrain, ytrain)
  ## Backward
  # Rmk: all leaf tensors get their gradient computed
  loglik$backward()
  ## Update parameter
  theta_optimizer$step()
  ## Store the current loss for graphical display
  loglik_vector[i] <- loglik %>% as.numeric()
}

## Check the LogLik
plot(loglik_vector)
plot(Coefs, as.numeric(theta))



        #### From ML inference to loss minimization



## -----------------------------------------------------------------------------
## Reset the parameter
theta <- rep(0,ncol(xtrain)) %>%  
  torch_tensor(.,requires_grad = TRUE) 

## Define the predictor
prediction_function <- function(x,theta){
  score <- torch_matmul(x, theta)
}

## Define the loss function
logistic_loss <- function(score, y){
  log_lik <- torch_dot(y, score) - torch_sum(torch_log(1 + torch_exp(score)))
  return(-log_lik)
}

## Define the optimization setting
theta_optimizer <- optim_adam(theta)
num_iterations <- 100

## Create a vector to store the evoluation of the LogLik at each step
loss_vector <- vector("numeric", length = num_iterations)

## Write the loop
for (i in 1:num_iterations) {
  ## Set the derivatives at 0
  theta_optimizer$zero_grad()
  ## Forward
  scores <- prediction_function(xtrain,theta)
  loss <- logistic_loss(scores, ytrain)
  ## Backward
  loss$backward()
  ## Update parameter
  theta_optimizer$step()
  ## Store the current loss for graphical display
  loss_vector[i] <- loss %>% as.numeric()
}

## Check the loss 
plot(loss_vector)
plot(Coefs, as.numeric(theta))



        #### Building a first (and simple!) Neural Network



## -----------------------------------------------------------------------------
## A simple NN generator
prediction_nn <- nn_linear(5,1)

## What kind of object ?
class(prediction_nn)

## How can it be used ?
x <- torch_randn(1,5)
prediction_nn(x)

## -----------------------------------------------------------------------------
str(prediction_nn)
prediction_nn$parameters

## -----------------------------------------------------------------------------
prediction_nn <- nn_linear(5,1,bias = FALSE)
nn_init_constant_(prediction_nn$parameters$weight,0)
prediction_nn$parameters

## -----------------------------------------------------------------------------
## Loss for the nn shape
logistic_loss_nn <- function(score, y){
  score <- torch_transpose(score,1,2)
  log_lik <- torch_matmul(score, y) - torch_sum(torch_log(1 + torch_exp(score)))
  return(-log_lik)
}

## Define the optimization setting
theta_optimizer <- optim_adam(prediction_nn$parameters)
num_iterations <- 100

## Create a vector to store the evoluation of the LogLik at each step
loss_vector <- vector("numeric", length = num_iterations)

## Write the loop
for (i in 1:num_iterations) {
  ## Set the derivatives at 0
  theta_optimizer$zero_grad()
  ## Forward
  scores <- prediction_nn(xtrain) 
  loss <- logistic_loss_nn(scores, ytrain)
  ## Backward
  loss$backward()
  ## Update parameter
  theta_optimizer$step()
  ## Store the current loss for graphical display
  loss_vector[i] <- loss %>% as.numeric()
}

## Check the Loss
plot(loss_vector)
Coefs_nn <- as.numeric(prediction_nn$parameters$weight)
plot(Coefs, Coefs_nn)



        #### Consider alternative optimization procedures.



## -----------------------------------------------------------------------------
## Reinitialize the prediction function
prediction_nn <- nn_linear(5,1,bias = FALSE)
nn_init_constant_(prediction_nn$parameters$weight,0)

## Set the optimization procedure
theta_optimizer.lbfgs <- optim_lbfgs(prediction_nn$parameters)
num_iter.lbfgs <-10
loss_vector.lbfgs <- vector("numeric", length = num_iter.lbfgs)

calc_loss <- function() {
  
  theta_optimizer.lbfgs$zero_grad()
  ## Forward
  scores <- prediction_nn(xtrain) 
  loss <- logistic_loss_nn(scores, ytrain)
  ## Backward
  loss$backward()
  return(loss)
  
}

for (i in 1:num_iter.lbfgs) {
  cat("Iteration: ", i, "\n")
  loss_vector.lbfgs[i] <- calc_loss() %>% as.numeric()
  theta_optimizer.lbfgs$step(calc_loss)
}

## Check the LogLik
plot(loss_vector.lbfgs)
plot(Coefs, as.numeric(prediction_nn$parameters$weight))
abline(0,1,col=2)

