pkgname <- "deepdive"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('deepdive')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("deepforest")
### * deepforest

flush(stderr()); flush(stdout())

### Name: deepforest
### Title: Build or train bagged deeptree or deepnet of multiple
###   architecture
### Aliases: deepforest

### ** Examples


require(deepdive)

x<-data.frame(x1=runif(10),x2=runif(10))
y<-data.frame(y=10*x$x1+20*x$x2+20)

mdeepf<-deepforest(x,y,
                  networkCount=2,
                  layerChoice=c(2:3),
                  unitsChoice=c(4:10),
                  cutVarSizePercent=0.6,
                  cutDataSizePercent=0.6,
                  activation = c('relu',"sin"),
                  reluLeak=0.01,
                  modelType ='regress',
                  iterations = 10,
                  eta = 10 ^-2,
                  seed=2,
                  gradientClip=0.8,
                  regularisePar=0,
                  optimiser="adam",
                  parMomentum=0.9,
                  inputSizeImpact=1,
                  parRmsPropZeroAdjust=10^-8,
                  parRmsProp=0.9999,
                  treeLeaves=NA,
                  treeMinSplitPercent=0.3,
                  treeMinSplitCount=100,
                  treeCp=0.01 ,
                  errorCover=0.2,
                  treeAugment=TRUE,
                  printItrSize=100,
                  showProgress=TRUE,
                  stopError=0.01,
                  miniBatchSize=64,
                  useBatchProgress=TRUE)



cleanEx()
nameEx("deepnet")
### * deepnet

flush(stderr()); flush(stdout())

### Name: deepnet
### Title: Build and train an Artificial Neural Network of any size
### Aliases: deepnet

### ** Examples

require(deepdive)

x <- data.frame(x1 = runif(10),x2 = runif(10))
y<- data.frame(y=20*x$x1 +30*x$x2+10)

#train
modelnet<-deepnet(x,y,c(2,2),
activation = c('relu',"sigmoid"),
reluLeak = 0.01,
modelType = "regress",
iterations =5,
eta=0.8,
optimiser="adam")

#predict
predDeepNet<-predict.deepnet(modelnet,newData=x)

#evaluate
sqrt(mean((predDeepNet$ypred-y$y)^2))





cleanEx()
nameEx("deeptree")
### * deeptree

flush(stderr()); flush(stdout())

### Name: deeptree
### Title: Descision Tree augmented by Artificial Neural Network
### Aliases: deeptree

### ** Examples


require(deepdive)

x <- data.frame(x1 = runif(10),x2 = runif(10))

y<- data.frame(y=20*x$x1 +30* x$x2 +10)

deepTreeMod<-deeptree(x,
y,
hiddenLayerUnits=c(4,4),
activation = c('relu',"sin"),
reluLeak=0.01,
modelType ='regress',
iterations = 1000,
eta = 0.4,
seed=2,
gradientClip=0.8,
regularisePar=0,
optimiser="adam",
parMomentum=0.9,
inputSizeImpact=1,
parRmsPropZeroAdjust=10^-8,
parRmsProp=0.9999,
treeLeaves=NA,
treeMinSplitPercent=0.4,
treeMinSplitCount=100,
stackPred =NA,
stopError=4,
miniBatchSize=64,
useBatchProgress=TRUE,
ignoreNAerror=FALSE)




### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
