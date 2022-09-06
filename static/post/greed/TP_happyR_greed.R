## ----setup, include=FALSE------------------------------------------
library(knitr)
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.align = "center"
)


## ----setup2, include=T, message=FALSE------------------------------
library(greed)
library(future) # allows parralel processing in greed()
library(aricode) # for ari computation
library(Matrix)
library(igraph)
library(mclust)

# data wrangling
library(dplyr) 
library(tidyr)
library(purrr)
library(tidygraph)

# advanced ploting 
library(ggpubr) 
library(ggplot2)
library(ggraph)
library(ggwordcloud)
library(kableExtra)

set.seed(2134)

future::plan("multisession", workers=1) # increase workers for parallel processing


## ----greed-call, eval=FALSE----------------------------------------
#> sol = greed(
#>    X                  , # dataset to cluster (mandatory)
#>    K = 20             , # number of initial clusters (optional)
#>    model = Gmm()      , # model to use and its prior parameters (optional)
#>    alg = Hybrid()     , # algorithm to use and its parameters (optional)
#>    verbose= FALSE    )  # verbosity level (optional)


## ----sbm-sim, include=T--------------------------------------------
N=16^00
K=15
prop=rep(1/K,K)
lambda  = 0.1
lambda_o = 0.025
Ks=5
theta = bdiag(lapply(1:(K/Ks), function(k){matrix(lambda_o,Ks,Ks)+diag(rep(lambda,Ks))}))+0.001
sbm = rsbm(N,prop,theta)
dim(sbm$x)


## ----plot-true-theta, include=TRUE, fig.align='center', out.width="50%"----

theta.long=tibble(p=as.numeric(theta),k=rep(1:K,K),l=rep(1:K,each=K))

ggplot(theta.long)+
  geom_tile(aes(x=l,y=k,fill=p))+
  scale_x_discrete()+
  scale_y_discrete()+
  ggplot2::scale_fill_distiller("Link density", palette = "Greys", direction = 1, limits = c(0, max(theta)))+theme_minimal()+coord_equal()


## ----greed-sbmsim, include=T---------------------------------------
sol_sbmsim <- greed(X = sbm$x, model = Sbm(), alg = Hybrid(pop_size = 40))
K(sol_sbmsim)


## ----ari-partition, out.width="50%"--------------------------------
cl <- clustering(sol_sbmsim)
table(truth=sbm$cl, est=cl) %>% kable(row.names = T) %>% kable_styling(full_width = F)
aricode::ARI(sbm$cl, cl)


## ----plotting-solsbm, fig.show="hold", out.width="50%"-------------
plot(sol_sbmsim, type="tree")
plot(sol_sbmsim, type="path")


## ----block-solsbm, fig.show='hold', out.width="50%"----------------
plot(sol_sbmsim, type="blocks")


## ----nodelink, out.width="50%"-------------------------------------
plot(sol_sbmsim, type="nodelink")


## ----cut-K3, out.width="50%"---------------------------------------
sol_sbm_K3 = cut(sol_sbmsim, 3)
table(clustering(sol_sbm_K3), sbm$cl) %>% kable(row.names=T)
plot(sol_sbm_K3, type="blocks")


## ----example-coef--------------------------------------------------
hat_theta= coef(sol_sbmsim)$theta
mean(abs(hat_theta-theta)) # l1 relative error, no permutation needed here.


## ------------------------------------------------------------------
data(Books)

sol_dcsbm <- greed(Books$X,model = DcSbm())

sol_sbm   <- greed(Books$X,model = Sbm())



## ------------------------------------------------------------------
prior(sol_dcsbm)@type
prior(sol_sbm)@type


## ---- fig.show='hold',out.width="100%",fig.width=8,fig.height=3.5,fig.cap="Block matrix representation of the DcSbm and Sbm solution found with greed on the Book network."----
bl_sbm = plot(sol_sbm,type='blocks')
bl_dcsbm = plot(sol_dcsbm,type='blocks')
ggarrange(bl_sbm,bl_dcsbm)


## ---- fig.show='hold',out.width="70%",fig.width=8,fig.height=5.5, message=FALSE,fig.cap="Ggraph plot of the book network with node colors given by the clustering found with greed and an Sbm model."----

graph <- igraph::graph_from_adjacency_matrix(Books$X) %>% 
  as_tbl_graph() %>% 
  mutate(Popularity = centrality_degree())  %>% 
  activate(nodes) %>%
  mutate(cluster=factor(clustering(sol_sbm),1:K(sol_sbm)))

# plot using ggraph
ggraph(graph, layout = 'kk') + 
    geom_edge_link() + 
    geom_node_point(aes(size = Popularity,color=cluster))



## ---- fig.show='hold', out.width="100%", echo=FALSE, include=TRUE----
# Regular SBM
sol_sbm_k3 = cut(sol_sbm,3)
table(clustering(sol_sbm_k3), Books$label) %>% 
  kable(format='html', caption = "SBM", row.names = T) %>%
  kable_styling(full_width = F, position="float_left")

# DcSbm
table(clustering(sol_dcsbm), Books$label) %>% 
  kable(format='html', caption = "DC-SBM", row.names = T) %>%
  kable_styling(full_width = F, position="right")


## ------------------------------------------------------------------
table(clustering(cut(sol_sbm, 3)), clustering(sol_dcsbm))
aricode::ARI(clustering(cut(sol_sbm, 3)), clustering(sol_dcsbm))


## ----load-diabetes, include=T--------------------------------------
data(diabetes,package="mclust")
head(diabetes %>% sample_n(100))
X = diabetes[,-1]
X = data.frame(scale(X)) # centering and scaling


## ----greed-diabetes------------------------------------------------
sol = greed(X,model=Gmm())


## ----eval-diabetes-------------------------------------------------
table(diabetes$class, clustering(sol)) %>% kable(row.names = T) %>% kable_styling(full_width = F)


## ----mclust-diabetes-----------------------------------------------
sol_mclust = mclust::Mclust(data = X, G = 2:5)
aricode::ARI(sol_mclust$classification, diabetes$class)
aricode::ARI(clustering(sol), diabetes$class)
aricode::ARI(clustering(sol), sol_mclust$classification)


## ----tree-diabetes, out.width="50%"--------------------------------
plot(sol, type="tree")


## ----gmmpairs, out.width="50%"-------------------------------------
gmmpairs(sol, X)


## ----violins-diabetes----------------------------------------------
plot(sol, type="violins")


## ----diabetes-diaggmm-cut-params-----------------------------------
params = coef(sol)
names(params)
params$Sigmak[[2]]


## ----diabetes-gmm-0.01, fig.show='hold',out.width="50%",fig.width=8,fig.height=5.5, fig.cap="Matrix pairs plots of the clustering with user specified hyperparameters on the diabetes data."----
sol_dense = greed(X,model=Gmm(epsilon=0.01*diag(diag(cov(X))), tau =0.001), alg=Hybrid(pop_size = 100))
gmmpairs(sol_dense,X)


## ----cut-soldense--------------------------------------------------
aricode::ARI(clustering(cut(sol_dense, 3)), clustering(sol))


## ----loading-data--------------------------------------------------
data("mushroom")


## ----muhroom-data-table--------------------------------------------
mushroom[,1:10] %>% head() %>% knitr::kable()


## ----muhroom-data--------------------------------------------------
X = mushroom[,-1]
subset = sample(1:nrow(X), size = 1000)
label = mushroom$edibility[subset]


## ----cluster-mushroom----------------------------------------------
sol_mush<-greed(X[subset,], model=Lca())


## ------------------------------------------------------------------
table(label, clustering(sol_mush)) %>% knitr::kable()


## ----dendo-mushroom, fig.dim=c(5,4),fig.cap="Dendogram obtained with greed with the Lca model on the Mushroom dataset."----
plot(sol_mush, type='tree')


## ----cut-K2-mushroom-----------------------------------------------
sol2 = cut(sol_mush, 2)
table(label, clustering(sol2)) %>% knitr::kable(row.names = T) %>% kable_styling(full_width = F)


## ----plot-marginal-mush, out.width="90%"---------------------------
plot(cut(sol_mush,2), type="marginals")

