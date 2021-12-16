## ----setup, message = FALSE---------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(keras)
library(ggplot2)
library(dplyr)
library(corrplot) # pour représenter la matrice des corrélations empiriques
library(factoextra) # pour avoir des représentations graphiques pour l'ACP
library(tensorflow)
#library(reticulate)
# use_miniconda("r-reticulate")
if (tensorflow::tf$executing_eagerly()) {
  tensorflow::tf$compat$v1$disable_eager_execution()
}
K <- keras::backend()


## ---- eval = FALSE------------------------------------------------------------------------------------------------------------------------
## library(tensorflow)
## tf$constant("Hellow Tensorflow")


## ----loading-the-data---------------------------------------------------------------------------------------------------------------------
wine <- read.csv("http://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv", sep = ";")
# Taille du jeux de données
dim(wine)
# Aperçu des premières lignes
head(wine[,-12])
# Résumé
summary(wine)


## ----corrplot-----------------------------------------------------------------------------------------------------------------------------
wine %>%
  select_if(is.numeric) %>%
  cor() %>% # Calcul de la matrice de corrélation empirique
  corrplot::corrplot() # représentation graphique de la matrice


## ----scale-the-data-----------------------------------------------------------------------------------------------------------------------
scaled_data <- wine[, -12] %>%
  select_if(is.numeric) %>%
  mutate_all(.funs = scale) # On applique à toutes les colonnes la fonction scale
# La fonction scale centre et réduit un vecteur


## ----train-and-test-datasets, echo = TRUE, eval = FALSE-----------------------------------------------------------------------------------
## set.seed(seed = 123)
## dataset_size <- nrow(wine)
## train_size <- as.integer(dataset_size * 0.85)
## # Training dataset
## train_dataset <- wine %>%
##   group_by(quality) %>%
##   sample_frac(0.85)
## # Creation of the test dataset
## test_dataset <- anti_join(as_tibble(wine), train_dataset)
## # Scale the data
## scaled_train <- train_dataset %>%
##   select_if(is.numeric) %>%
##   mutate_all(.funs = scale)
## # Attention : il faudrait aussi mettre à l'echelle le jeu de test, peut-etre plutôt avec les valeurs du jeu d'entrainement
## scaled_test <- test_dataset %>%
##   select_if(is.numeric) %>%
##   mutate_all(.funs = scale)


## ----resultat_acp-------------------------------------------------------------------------------------------------------------------------
res.pca <- prcomp(scaled_data)
head(res.pca$x)
## plot of the eigenvalues
factoextra::fviz_eig(res.pca)
# Plot -2D
ggplot(as.data.frame(res.pca$x), aes(x = PC1, y = PC2, col =wine$quality)) + geom_point()
# Plot - 3D
#library(plotly)
#pca_plotly <- plot_ly(as.data.frame(res.pca$x), x = ~PC1, y = ~PC2, z = ~PC3, color = ~wine$quality) %>% add_markers()
#pca_plotly


## ----knn-prediction, eval = FALSE---------------------------------------------------------------------------------------------------------
## library(class)
## y <- wine$quality
## neigh <- knn(scaled_data, scaled_data, cl = y, k = 3)
## # confusion matrix
## tab <- table(neigh, y)
## # accuracy
## sum(diag(tab)) / sum(rowSums(tab)) * 100
## ## Using the 6 first PC
## neigh_reduced <- knn(res.pca$x[, 1:6], res.pca$x[, 1:6], cl = y, k = 3)
## tab <- table(neigh_reduced, y)
## sum(diag(tab)) / sum(rowSums(tab)) * 100
## # si on voulait prédire des individus supplementaires :
## # Centre-reduire les individus supplementaires
## # ind.scaled  <- scale(ind.sup, center = res.pca$center, scale = res.pca$scale)
## # ind.sup.coord <- predict(res.pca, newdata = ind.sup)


## ----autoencoder-1-----------------------------------------------------------------------------------------------------------------------
# Ecriture condensée
input_size <- 11
m <- 6 # nb de composantes
ae_1 <- keras_model_sequential()
ae_1 %>%
  layer_dense(units = m, input_shape = input_size, use_bias = TRUE, activation = "linear", name = "bottleneck") %>%
  layer_dense(units = input_size, use_bias = TRUE, activation = "linear") %>%
  summary(ae_1)


## ----autoencoder-2------------------------------------------------------------------------------------------------------------------------
# Ecriture en separant encodeur et decodeur
# Encoder
enc_input <- layer_input(shape = input_size)
enc_output <- enc_input %>%
  layer_dense(units = m, activation = "linear")
encoder <- keras_model(enc_input, enc_output)
# Decoder
dec_input <- layer_input(shape = m)
dec_output <- dec_input %>%
  layer_dense(units = input_size, activation = "linear")
decoder <- keras_model(dec_input, dec_output)
# Autoencoder
ae_2_input <- layer_input(shape = input_size)
ae_2_output <- ae_2_input %>%
  encoder() %>%
  decoder()
ae_2 <- keras_model(ae_2_input, ae_2_output)
summary(ae_2)


## ----get-config---------------------------------------------------------------------------------------------------------------------------
# Encoder : m*n weights + m terms of bias
# Decoder : m*n + n terms of bias
get_config(ae_1)


## ----ae-1-compile-------------------------------------------------------------------------------------------------------------------------
ae_1 %>% compile(
  loss = "mean_squared_error",
  optimizer = optimizer_sgd(learning_rate = 0.1) # stochastic gradient descent optimizer
)


## ----ae-1-fit-----------------------------------------------------------------------------------------------------------------------------
epochs_nb <- 50L
batch_size <- 10L
scaled_train <- as.matrix(scaled_data)
ae_1 %>% fit(x = scaled_train, y = scaled_train, epochs = epochs_nb, batch_size = batch_size)
# evaluate the performance of the model
mse.ae <- evaluate(ae_1, scaled_train, scaled_train)
mse.ae


## ----ae-poids-----------------------------------------------------------------------------------------------------------------------------
poids <- get_weights(ae_1)
# Encoders/ decoders weights
w_encodeur <- poids[[1]] %>% print()
w_decodeur <- poids[[3]] %>% print()

## -----------------------------------------------------------------------------------------------------------------------------------------
# ACP : unit Norm: the weights on a layer have unit norm.
sum(w_decodeur^2) / m


## ----ae1-predict, eval = FALSE------------------------------------------------------------------------------------------------------------
## ae_1predict <- ae_1 %>% predict(scaled_train)
## # Repasser en non standardisé pour comparer...
## varcol <- apply(wine[, -12], 2, var)
## meancol <- colMeans(wine[, -12])
## ae_1predict_or <- sapply(c(1:11), FUN = function(x) ae_1predict[, x] * sqrt(varcol[x]) + meancol[x])


## ----botteleneck-layer--------------------------------------------------------------------------------------------------------------------
# extract the bottleneck layer
intermediate_layer_model <- keras_model(inputs = ae_1$input, outputs = get_layer(ae_1, "bottleneck")$output)
intermediate_output <- predict(intermediate_layer_model, scaled_train)
ggplot(data.frame(PC1 = intermediate_output[,1], PC2 = intermediate_output[,2]), aes(x = PC1, y = PC2, col = wine$quality)) + geom_point()


## ----comparison--------------------------------------------------------------------------------------------------------------------------
# PCA reconstruction
pca.recon <- function(pca, x, k){
  mu <- matrix(rep(res.pca$center, nrow(pca$x)), nrow = nrow(res.pca$x), byrow = T)
  recon <- res.pca$x[,1:k] %*% t(res.pca$rotation[,1:k]) + mu
  mse <- mean((recon - x)^2)
  return(list(x = recon, mse = mse))
}
xhat <- rep(NA, 10)
for(k in 1:10){
  xhat[k] <- pca.recon(res.pca, scaled_train, k)$mse
}
ae.mse <- rep(NA, 5)
input_size <- 11
#m <- 6 # nb components
for(k in 1:10){
  modelk <- keras_model_sequential()
  modelk %>%
  layer_dense(units = k, input_shape = input_size, use_bias = TRUE, activation = "linear", name = "bottleneck") %>%
  layer_dense(units = input_size, use_bias = TRUE, activation = "linear")
  modelk %>% compile(
    loss = "mean_squared_error",
    optimizer = optimizer_sgd(learning_rate = 0.1)
  )
  modelk %>% fit(
    x = scaled_train,
    y = scaled_train,
    epochs = 50,
    verbose = 0,
  )
  ae.mse[k] <- unname(evaluate(modelk, scaled_train, scaled_train))
}
df <- data.frame(k = c(1:10, 1:10), mse = c(xhat, ae.mse), method = c(rep("acp", 10), rep("autoencodeur", 10)))
ggplot(df, aes(x = k, y = mse, col = method)) + geom_line()


## ----useful functions for variational autoencoder-------------------------------------------------------------------------------------------
# Warning keras:  k_random_normal, k_shape etc.
sampling <- function(arg) {
  z_mean <- arg[, 1:(latent_dim)]
  z_log_var <- arg[, (latent_dim + 1):(2 * latent_dim)]

  epsilon <- k_random_normal(
    shape = c(k_shape(z_mean)[[1]]),
    mean = 0.,
    stddev = epsilon_std
  )

  z_mean + k_exp(z_log_var / 2) * epsilon
}
# Loss function
vae_loss <- function(x, x_decoded, k1 = 1, k2 = 0.01) {
  mse_loss <- k_sum(loss_mean_squared_error(x, x_decoded))
  kl_loss <- -0.5 * k_sum(1 + z_log_var - k_square(z_mean) - k_exp(z_log_var))
  k1*mse_loss + k2*kl_loss
}


## ----variational autoencoder------------------------------------------------------------------------------------------------------------
set.seed(123)
# Parameters --------------------------------------------------------------
batch_size <- 32
latent_dim <- 6L
epochs_nb <- 50L
epsilon_std <- 1.0

# Model definition --------------------------------------------------------
x <- layer_input(shape = c(input_size))
z_mean <- layer_dense(x, latent_dim)
z_log_var <- layer_dense(x, latent_dim)

# note that "output_shape" isn't necessary with the TensorFlow backend
z <- layer_concatenate(list(z_mean, z_log_var)) %>%
  layer_lambda(sampling)

# On instancie les couches séparément pour pouvoir les réutiliser plus tard
decoder <- layer_dense(units = input_size, activation = "sigmoid")
x_decoded <- decoder(z)

# end-to-end autoencoder
vae <- keras_model(x, x_decoded)

# encoder, from inputs to latent space
encoder <- keras_model(x, z_mean)

# generator, from latent space to reconstructed inputs
decoder_input <- layer_input(shape = latent_dim)
x_decoded_2 <- decoder(decoder_input)
generator <- keras_model(decoder_input, x_decoded_2)

vae %>% compile(optimizer = "sgd", loss = vae_loss)

vae %>% fit(x = scaled_train, y = scaled_train, epochs = epochs_nb)

x_train_encoded <- predict(encoder, scaled_train, batch_size = batch_size)
## Representation in the latent space
x_train_encoded %>%
  as_tibble()  %>%
  ggplot(aes(x = V1, y = V2, colour = wine$quality)) +
  geom_point()


## ----session-info-------------------------------------------------------------------------------------------------------------------------
reticulate::py_config()
tensorflow::tf_config()

