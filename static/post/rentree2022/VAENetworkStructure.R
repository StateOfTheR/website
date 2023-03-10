


        #### Data loading and preprocessing



## ----packages-----------------------------------------------------------------
rm(list=ls())
library(tidyverse)
library(torch)
library(tictoc)

## ----load the data------------------------------------------------------------
Train <- data.table::fread("D:/R/FinistR2022/finistR2022/TrainMnist.txt") %>% 
  as.matrix
xtrain <- torch_tensor(Train[,1:784])
ytrain <- Train[,785]
input_dim <- ncol(xtrain)



        #### Building a VAE Neural Network



## ----choose latent dim--------------------------------------------------------
## Choice of the dimension of the latent space
latent_dim = 2

## ----decoder------------------------------------------------------------------
## Build the decoder generator
decoder_gen <- nn_module(
  
  classname = "decoder", 
  
  ## Define the successive layers
  initialize = function(dim.latent, dim.input) {
    self$l1 <- nn_linear(dim.latent, dim.input)
  }, 
  
  ## Define the forward path 
  forward = function(input) {
    input %>% self$l1()
  }
)

## Check
decoder <- decoder_gen(latent_dim,input_dim)
latent_vectors <- matrix(rnorm(10), nrow = 5, ncol = latent_dim) %>% torch_tensor() 
decoder(latent_vectors) %>% 
  dim()

## ----decoder 2----------------------------------------------------------------
## First build a decompressor generator
decompressor_gen <- function(dim.latent, dim.l1, dim.l2, dim.input) {
  nn_sequential(
    nn_linear(dim.latent, dim.l1),
    nn_relu(),
    nn_linear(dim.l1, dim.l2),
    nn_relu(),
    nn_linear(dim.l2, dim.input),
  )  
}

## Check it
decompressor <- decompressor_gen(latent_dim, 20, 100, input_dim)
decompressor(latent_vectors)

## Then build the decoder itself that calls the decompressor generating function
decoder_gen <- nn_module(
  
  classname = "decoder", 
  
  ## Define the architecture of the decoder
  initialize = function(dim.latent, dim.l1, dim.l2, dim.input) {
    self$decompressor <- decompressor_gen(dim.latent, dim.l1, dim.l2, dim.input)
  }, 
  
  ## Define the forward path
  forward = function(input) {
    input %>% self$decompressor()
  }
)

## Check
decoder <- decoder_gen(latent_dim, 20, 100, input_dim)
decoder(latent_vectors) %>% dim
decoder$parameters %>% names



        #### Encoder



## First define the compressor generator
compressor_gen <- function(      ) {
  nn_sequential(
    
    )  
}

## And check it
compressor <- compressor_gen(      )
compressor(xtrain[1,])

## Now define the encoder generator
encoder_gen <- nn_module(
  
  classname = "encoder", 
  
  ## Define the different components
  initialize = function(      ) {

    
    
  }, 
  
  ## Define the computation
  forward = function(input) {
    ## First compress the data

    ## Then compute means and variances

    
    ## Output mean and log_var
    list(mean = mean, log_var = log_var)
  }
)

## Check the encoder
encoder <- encoder_gen(      )
encoder(xtrain[1, ])



        #### Complete VAE structure



## ----vae----------------------------------------------------------------------
# Define VAE model using encoder and decoder from above
vae_gen <- nn_module(
  
  initialize = function(input_dim,dim.l1=100, dim.l2=20, latent_dim=2) {
    
    self$latent_dim = latent_dim
    self$encoder <- encoder_gen(input_dim,dim.l1,dim.l2, latent_dim)
    self$decoder <- decoder_gen(latent_dim, dim.l2, dim.l1, input_dim)
    
  },
  
  forward = function(x) {
    f <- self$encoder(x)
    mu <- f$mean
    log_var <- f$log_var
    z <- mu + torch_exp(log_var$mul(0.5))*torch_randn(c(dim(x)[1], self$latent_dim))
    reconst_x <- self$decoder(z)
    
    list(pred=reconst_x, mean=mu, log_var=log_var)
  }
  
)

## Check
vae <- vae_gen(input_dim,100,20,latent_dim)
vae(xtrain[1, ]) %>% names

## ----optimization setting-----------------------------------------------------
## Set the optimization procedure
optimizer_vae <- optim_adam(vae$parameters, lr = 0.001)
num_iter <- 250

## ----loss---------------------------------------------------------------------
calc_loss <- function(traindata) {
  
  optimizer_vae$zero_grad()
  
  ## Forward (apply the current VAE to the data at hand)
  forward <- vae(traindata)
  pred <- forward$pred
  mu <- forward$mean
  log_var <- forward$log_var
  
  ## Compute the loss: L2 part ("fitting" part)
  l2 <- nn_mse_loss(reduction = "sum")
  l2.eval <- l2(pred,traindata)
    
  # Compute the loss: KL divergence part ("regularization" part)
  kl_div =  1 + log_var - mu$pow(2) - log_var$exp()
  kl_div_sum = - 0.5 *kl_div$sum()
  
  # Compute the loss: full loss (fitting + regularization)
  loss <- l2.eval + kl_div_sum

  ## Backward (compute the gradients)
  loss$backward()
  return(loss)
  
}

## ----optimization loop--------------------------------------------------------
## Run the loop 
loss_vector <- rep(NA,num_iter)
tic()
for (i in 1:num_iter) {
  
  ## Print iteration number
  if(i %% 50 == 0){ cat("Iteration: ", i, "\n") }
  
  ## Compute the loss and gradients
  loss_vector[i] <- calc_loss(xtrain) %>% as.numeric()
  
  ## Update the parameters
  optimizer_vae$step() 
}
toc()

## ----loss plot----------------------------------------------------------------
plot(loss_vector)

## ----latent space plot--------------------------------------------------------
latent_vectors <- vae$encoder(xtrain)$mean
latent_vectors %>% 
  as.matrix %>% 
  as.data.frame() %>% 
  mutate(Label = as.factor(ytrain - 1L)) %>%
  ggplot(aes(x=V1,y=V2,col=Label)) + geom_point() + 
  scale_color_brewer(palette = "Paired")

## ----reconstruction plot------------------------------------------------------
## A small function to plot MNIST images 
plot_image <- function(input) {
  par(mar = c(0, 0, 0, 0))
  input %>% 
    as.numeric %>% 
    .[784:1] %>% 
    matrix(.,28,28) %>% 
    .[28:1,] %>% 
    image(., 
        col = gray.colors(256, start = 0, end = 1, rev = FALSE), 
        axes = FALSE)  
}

## Compare initial and reconstructed images
predicted <- vae$decoder(latent_vectors)
par(mfrow=c(5,2))
for (ii in 1:5){
  plot_image(xtrain[ii,])
  plot_image(predicted[ii,])
}

## -----------------------------------------------------------------------------
gen.list <- c('decompressor_gen','decoder_gen','compressor_gen','encoder_gen','vae_gen','calc_loss','loss_vector','plot_image')
gen.list %>% 
  setNames(.,.) %>% 
  map(~ get(.x)) %>% 
  saveRDS(.,file=paste0('./NNmodules_And_calc_loss.rds'))

