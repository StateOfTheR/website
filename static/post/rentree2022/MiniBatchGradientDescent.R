


        #### Mini-batch gradient descent



## ----packages-----------------------------------------------------------------
rm(list=ls())
library(tidyverse)
library(torch)
library(tictoc)
library(coro)

## -----------------------------------------------------------------------------
Train <- data.table::fread("D:/R/FinistR2022/finistR2022/TrainMnist.txt") %>% 
  as.matrix
input_dim <- ncol(Train)-1
ytrain <- Train[,ncol(Train)]



        #### Mini-batch using the dataloader format



## ----mnist dataset generator--------------------------------------------------
mnist_dataset_gen <- dataset(
  
  ## How to create the dataset
  initialize = function(input) {
    self$data <- torch_tensor(input[,1:(ncol(input)-1)])
  },
  
  ## How to pull a data
  .getitem = function(index) {
    self$data[index, ]
  },
  
  ## Length of the dataset
  .length = function() {
    self$data$size()[[1]]
  }
  
)
class(mnist_dataset_gen)
mnist.ds <- mnist_dataset_gen(Train)
class(mnist.ds)



## -----------------------------------------------------------------------------
## Generate observation
NbVar <- 50
NbEnv <- 40
NbObs <- 1e4
Measurements <- tibble(
  Variety = sample(paste0('V',1:NbVar),NbObs,replace = TRUE),
  Env = sample(paste0('E',1:NbEnv),NbObs,replace = TRUE),
  Y = rnorm(NbObs)
)
Measurements

## -----------------------------------------------------------------------------
## Generate plant genotypes
NbMarker <- 1e4
VarietyInfo <- matrix(rbinom(size = 2,prob=0.5,n = NbMarker*NbVar),NbVar,NbMarker)
row.names(VarietyInfo) <- paste0('V',1:NbVar)
colnames(VarietyInfo) <- paste0('M',1:NbMarker)
VarietyInfo[1:5,1:5]

## -----------------------------------------------------------------------------
plant_ds_gen <- dataset(
  
  initialize = function(      ) {
    
    ## Measurements   

    ## Varieties

    ## List of observations

  },

  .getitem = function(i) {

    
  },
  
  .length = function() {
    
  }
)

plant_ds <- plant_ds_gen(Measurements,VarietyInfo,EnvInfo)
plant_ds[1]
plant_ds[2]

## ----dataloader---------------------------------------------------------------
## Define the dataloader
mnist.dl <- dataloader(mnist.ds, batch_size = 256, shuffle = TRUE, drop_last=FALSE)
class(mnist.dl)

## ----dataloader data access---------------------------------------------------
mnist.dl$dataset$data %>% dim

## ----dataloader batch description---------------------------------------------
mnist.it = mnist.dl$.iter()
minibatch = mnist.it$.next()
class(minibatch)
dim(minibatch)

## ----dataloader nb batches----------------------------------------------------
mnist.it$.length()



        #### Training a VAE using Mini-Batch Gradient Descent



## -----------------------------------------------------------------------------
RObjectsFromPreviousSession <- readRDS(file=paste0('./NNmodules_And_calc_loss.rds'))
imap(RObjectsFromPreviousSession, ~assign(.y,value=.x,envir = globalenv()))

## -----------------------------------------------------------------------------
latent_dim=2
vae <- vae_gen(input_dim,100,20,latent_dim)
vae

## ----optimization setting-----------------------------------------------------
## Set the optimization procedure
optimizer_vae <- optim_adam(vae$parameters, lr = 0.001)
num_epoch <- 10

## ----loop with mini-batch-----------------------------------------------------
## Create a vector to store the loss at each epoch
loss.epoch <- rep(0,num_epoch)

## Loop over epochs
tic()
for(epoch in 1:num_epoch) {
  cat("Epoch #", epoch, ": ", sep = "")
  
  ## Boucle for "coro" pour itérer sur les batchs
  coro::loop(for (minibatch in mnist.dl) {  
    
    ## Perte à cette étape
    loss <- calc_loss(minibatch)
    
    ## On cumule les pertes des batchs pour obtenir in fine celle de l'epoch  
    loss.epoch[epoch] = loss.epoch[epoch] + as.numeric(loss)
    optimizer_vae$step()
    
  })
  cat(sprintf("Loss = %1f\n", loss.epoch[epoch]))
}
toc()

## ----loss plot----------------------------------------------------------------
plot(loss.epoch)

## -----------------------------------------------------------------------------
min(loss_vector)
min(loss.epoch)

## ----latent space plot--------------------------------------------------------
xtrain = mnist.dl$dataset$data
latent_vectors <- vae$encoder(xtrain)$mean
latent_vectors %>% 
  as.matrix %>% 
  as.data.frame() %>% 
  mutate(Label = as.factor(ytrain - 1L)) %>%
  ggplot(aes(x=V1,y=V2,col=Label)) + geom_point() + 
  scale_color_brewer(palette = "Paired")

## ----reconstruction plot------------------------------------------------------
## Compare initial and reconstructed images
predicted <- vae$decoder(latent_vectors)
par(mfrow=c(5,2))
for (ii in 1:5){
  plot_image(xtrain[ii,])
  plot_image(predicted[ii,])
}

