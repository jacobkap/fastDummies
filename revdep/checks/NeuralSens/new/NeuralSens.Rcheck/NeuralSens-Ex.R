pkgname <- "NeuralSens"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('NeuralSens')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("ActFunc")
### * ActFunc

flush(stderr()); flush(stdout())

### Name: ActFunc
### Title: Activation function of neuron
### Aliases: ActFunc

### ** Examples

# Return the sigmoid activation function of a neuron
ActivationFunction <- ActFunc("sigmoid")
# Return the tanh activation function of a neuron
ActivationFunction <- ActFunc("tanh")
# Return the activation function of several layers of neurons
actfuncs <- c("linear","sigmoid","linear")
ActivationFunctions <- sapply(actfuncs, ActFunc)



cleanEx()
nameEx("AlphaSensAnalysis")
### * AlphaSensAnalysis

flush(stderr()); flush(stdout())

### Name: AlphaSensAnalysis
### Title: Sensitivity alpha-curve associated to MLP function
### Aliases: AlphaSensAnalysis

### ** Examples




cleanEx()
nameEx("AlphaSensCurve")
### * AlphaSensCurve

flush(stderr()); flush(stdout())

### Name: AlphaSensCurve
### Title: Sensitivity alpha-curve associated to MLP function of an input
###   variable
### Aliases: AlphaSensCurve

### ** Examples




cleanEx()
nameEx("CombineSens")
### * CombineSens

flush(stderr()); flush(stdout())

### Name: CombineSens
### Title: Sensitivity analysis plot over time of the data
### Aliases: CombineSens

### ** Examples




cleanEx()
nameEx("ComputeHessMeasures")
### * ComputeHessMeasures

flush(stderr()); flush(stdout())

### Name: ComputeHessMeasures
### Title: Plot sensitivities of a neural network model
### Aliases: ComputeHessMeasures

### ** Examples

## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR

## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 250
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                           data = nntrData,
                           linear.output = TRUE,
                           size = hidden_neurons,
                           decay = decay,
                           maxit = iters)
# Try SensAnalysisMLP
sens <- NeuralSens::SensAnalysisMLP(nnetmod, trData = nntrData, plot = FALSE)



cleanEx()
nameEx("ComputeSensMeasures")
### * ComputeSensMeasures

flush(stderr()); flush(stdout())

### Name: ComputeSensMeasures
### Title: Plot sensitivities of a neural network model
### Aliases: ComputeSensMeasures

### ** Examples

## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR

## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 250
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                           data = nntrData,
                           linear.output = TRUE,
                           size = hidden_neurons,
                           decay = decay,
                           maxit = iters)
# Try SensAnalysisMLP
sens <- NeuralSens::SensAnalysisMLP(nnetmod, trData = nntrData, plot = FALSE)



cleanEx()
nameEx("Der2ActFunc")
### * Der2ActFunc

flush(stderr()); flush(stdout())

### Name: Der2ActFunc
### Title: Second derivative of activation function of neuron
### Aliases: Der2ActFunc

### ** Examples

# Return derivative of the sigmoid activation function of a neuron
ActivationFunction <- Der2ActFunc("sigmoid")
# Return derivative of the tanh activation function of a neuron
ActivationFunction <- Der2ActFunc("tanh")
# Return derivative of the activation function of several layers of neurons
actfuncs <- c("linear","sigmoid","linear")
ActivationFunctions <- sapply(actfuncs, Der2ActFunc)



cleanEx()
nameEx("Der3ActFunc")
### * Der3ActFunc

flush(stderr()); flush(stdout())

### Name: Der3ActFunc
### Title: Third derivative of activation function of neuron
### Aliases: Der3ActFunc

### ** Examples

# Return derivative of the sigmoid activation function of a neuron
ActivationFunction <- Der3ActFunc("sigmoid")
# Return derivative of the tanh activation function of a neuron
ActivationFunction <- Der3ActFunc("tanh")
# Return derivative of the activation function of several layers of neurons
actfuncs <- c("linear","sigmoid","linear")
ActivationFunctions <- sapply(actfuncs, Der3ActFunc)



cleanEx()
nameEx("DerActFunc")
### * DerActFunc

flush(stderr()); flush(stdout())

### Name: DerActFunc
### Title: Derivative of activation function of neuron
### Aliases: DerActFunc

### ** Examples

# Return derivative of the sigmoid activation function of a neuron
ActivationFunction <- DerActFunc("sigmoid")
# Return derivative of the tanh activation function of a neuron
ActivationFunction <- DerActFunc("tanh")
# Return derivative of the activation function of several layers of neurons
actfuncs <- c("linear","sigmoid","linear")
ActivationFunctions <- sapply(actfuncs, DerActFunc)



cleanEx()
nameEx("HessDotPlot")
### * HessDotPlot

flush(stderr()); flush(stdout())

### Name: HessDotPlot
### Title: Second derivatives 3D scatter or surface plot against input
###   values
### Aliases: HessDotPlot

### ** Examples

## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR
## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 250
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                      data = nntrData,
                      linear.output = TRUE,
                      size = hidden_neurons,
                      decay = decay,
                      maxit = iters)
# Try HessDotPlot
NeuralSens::HessDotPlot(nnetmod, fdata = nntrData, surface = TRUE, color = "WD")



cleanEx()
nameEx("HessFeaturePlot")
### * HessFeaturePlot

flush(stderr()); flush(stdout())

### Name: HessFeaturePlot
### Title: Feature sensitivity plot
### Aliases: HessFeaturePlot

### ** Examples

## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR

## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 250
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                           data = nntrData,
                           linear.output = TRUE,
                           size = hidden_neurons,
                           decay = decay,
                           maxit = iters)
# Try SensAnalysisMLP
hess <- NeuralSens::HessianMLP(nnetmod, trData = nntrData, plot = FALSE)
NeuralSens::HessFeaturePlot(hess)



cleanEx()
nameEx("HessianMLP")
### * HessianMLP

flush(stderr()); flush(stdout())

### Name: HessianMLP
### Title: Sensitivity of MLP models
### Aliases: HessianMLP HessianMLP.default HessianMLP.train
###   HessianMLP.H2OMultinomialModel HessianMLP.H2ORegressionModel
###   HessianMLP.list HessianMLP.mlp HessianMLP.nn HessianMLP.nnet
###   HessianMLP.nnetar HessianMLP.numeric

### ** Examples

## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR
## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 100
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                      data = nntrData,
                      linear.output = TRUE,
                      size = hidden_neurons,
                      decay = decay,
                      maxit = iters)
# Try HessianMLP
NeuralSens::HessianMLP(nnetmod, trData = nntrData, plot = FALSE)



cleanEx()
nameEx("PlotSensMLP")
### * PlotSensMLP

flush(stderr()); flush(stdout())

### Name: PlotSensMLP
### Title: Neural network structure sensitivity plot
### Aliases: PlotSensMLP

### ** Examples

## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR
## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 100
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                      data = nntrData,
                      linear.output = TRUE,
                      size = hidden_neurons,
                      decay = decay,
                      maxit = iters)
# Try SensAnalysisMLP
NeuralSens::PlotSensMLP(nnetmod, trData = nntrData)



cleanEx()
nameEx("SensAnalysisMLP")
### * SensAnalysisMLP

flush(stderr()); flush(stdout())

### Name: SensAnalysisMLP
### Title: Sensitivity of MLP models
### Aliases: SensAnalysisMLP SensAnalysisMLP.default SensAnalysisMLP.train
###   SensAnalysisMLP.H2OMultinomialModel
###   SensAnalysisMLP.H2ORegressionModel SensAnalysisMLP.list
###   SensAnalysisMLP.mlp SensAnalysisMLP.nn SensAnalysisMLP.nnet
###   SensAnalysisMLP.nnetar SensAnalysisMLP.numeric

### ** Examples

## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR
## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 100
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                      data = nntrData,
                      linear.output = TRUE,
                      size = hidden_neurons,
                      decay = decay,
                      maxit = iters)
# Try SensAnalysisMLP
NeuralSens::SensAnalysisMLP(nnetmod, trData = nntrData)



cleanEx()
nameEx("SensDotPlot")
### * SensDotPlot

flush(stderr()); flush(stdout())

### Name: SensDotPlot
### Title: Sensitivity scatter plot against input values
### Aliases: SensDotPlot

### ** Examples

## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR
## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 250
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                      data = nntrData,
                      linear.output = TRUE,
                      size = hidden_neurons,
                      decay = decay,
                      maxit = iters)
# Try SensDotPlot
NeuralSens::SensDotPlot(nnetmod, fdata = nntrData)



cleanEx()
nameEx("SensFeaturePlot")
### * SensFeaturePlot

flush(stderr()); flush(stdout())

### Name: SensFeaturePlot
### Title: Feature sensitivity plot
### Aliases: SensFeaturePlot

### ** Examples

## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR

## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 250
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                           data = nntrData,
                           linear.output = TRUE,
                           size = hidden_neurons,
                           decay = decay,
                           maxit = iters)
# Try SensAnalysisMLP
sens <- NeuralSens::SensAnalysisMLP(nnetmod, trData = nntrData, plot = FALSE)
NeuralSens::SensFeaturePlot(sens)



cleanEx()
nameEx("SensMatPlot")
### * SensMatPlot

flush(stderr()); flush(stdout())

### Name: SensMatPlot
### Title: Plot sensitivities of a neural network model
### Aliases: SensMatPlot

### ** Examples

## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR
## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 100
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                      data = nntrData,
                      linear.output = TRUE,
                      size = hidden_neurons,
                      decay = decay,
                      maxit = iters)
# Try HessianMLP
H <- NeuralSens::HessianMLP(nnetmod, trData = nntrData, plot = FALSE)
NeuralSens::SensMatPlot(H)
S <- NeuralSens::SensAnalysisMLP(nnetmod, trData = nntrData, plot = FALSE)
NeuralSens::SensMatPlot(H, S, senstype = "interactions")



cleanEx()
nameEx("SensTimePlot")
### * SensTimePlot

flush(stderr()); flush(stdout())

### Name: SensTimePlot
### Title: Sensitivity analysis plot over time of the data
### Aliases: SensTimePlot

### ** Examples

## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR
fdata[,3] <- ifelse(as.data.frame(fdata)[,3] %in% c("SUN","SAT"), 0, 1)
## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 250
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                      data = nntrData,
                      linear.output = TRUE,
                      size = hidden_neurons,
                      decay = decay,
                      maxit = iters)
# Try SensTimePlot
NeuralSens::SensTimePlot(nnetmod, fdata = nntrData, date.var = NULL)



cleanEx()
nameEx("SensitivityPlots")
### * SensitivityPlots

flush(stderr()); flush(stdout())

### Name: SensitivityPlots
### Title: Plot sensitivities of a neural network model
### Aliases: SensitivityPlots

### ** Examples

## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR

## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 250
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                           data = nntrData,
                           linear.output = TRUE,
                           size = hidden_neurons,
                           decay = decay,
                           maxit = iters)
# Try SensAnalysisMLP
sens <- NeuralSens::SensAnalysisMLP(nnetmod, trData = nntrData, plot = FALSE)
NeuralSens::SensitivityPlots(sens)



cleanEx()
nameEx("diag3Darray-set")
### * diag3Darray-set

flush(stderr()); flush(stdout())

### Name: diag3Darray<-
### Title: Define function to change the diagonal of array
### Aliases: diag3Darray<-

### ** Examples

x <- array(1, dim = c(3,3,3))
diag3Darray(x) <- c(2,2,2)
x
#  , , 1
#
#  [,1] [,2] [,3]
#  [1,]    2    1    1
#  [2,]    1    1    1
#  [3,]    1    1    1
#
#  , , 2
#
#  [,1] [,2] [,3]
#  [1,]    1    1    1
#  [2,]    1    2    1
#  [3,]    1    1    1
#
#  , , 3
#
#  [,1] [,2] [,3]
#  [1,]    1    1    1
#  [2,]    1    1    1
#  [3,]    1    1    2



cleanEx()
nameEx("diag3Darray")
### * diag3Darray

flush(stderr()); flush(stdout())

### Name: diag3Darray
### Title: Define function to create a 'diagonal' array or get the diagonal
###   of an array
### Aliases: diag3Darray

### ** Examples

x <- diag3Darray(c(1,4,6), dim = 3)
x
# , , 1
#
# [,1] [,2] [,3]
# [1,]    1    0    0
# [2,]    0    0    0
# [3,]    0    0    0
#
# , , 2
#
# [,1] [,2] [,3]
# [1,]    0    0    0
# [2,]    0    4    0
# [3,]    0    0    0
#
# , , 3
#
# [,1] [,2] [,3]
# [1,]    0    0    0
# [2,]    0    0    0
# [3,]    0    0    6
diag3Darray(x)
# 1, 4, 6



cleanEx()
nameEx("diag4Darray-set")
### * diag4Darray-set

flush(stderr()); flush(stdout())

### Name: diag4Darray<-
### Title: Define function to change the diagonal of array
### Aliases: diag4Darray<-

### ** Examples

x <- array(1, dim = c(4,4,4,4))
diag4Darray(x) <- c(2,2,2,2)
x
# , , 1, 1
#
#      [,1] [,2] [,3] [,4]
# [1,]    2    1    1    1
# [2,]    1    1    1    1
# [3,]    1    1    1    1
# [4,]    1    1    1    1
#
# , , 2, 1
#
#      [,1] [,2] [,3] [,4]
# [1,]    1    1    1    1
# [2,]    1    1    1    1
# [3,]    1    1    1    1
# [4,]    1    1    1    1
#
# , , 3, 1
#
#      [,1] [,2] [,3] [,4]
# [1,]    1    1    1    1
# [2,]    1    1    1    1
# [3,]    1    1    1    1
# [4,]    1    1    1    1
#
# , , 4, 1
#
#      [,1] [,2] [,3] [,4]
# [1,]    1    1    1    1
# [2,]    1    1    1    1
# [3,]    1    1    1    1
# [4,]    1    1    1    1
#
# , , 1, 2
#
#      [,1] [,2] [,3] [,4]
# [1,]    1    1    1    1
# [2,]    1    1    1    1
# [3,]    1    1    1    1
# [4,]    1    1    1    1
#
# , , 2, 2
#
#      [,1] [,2] [,3] [,4]
# [1,]    1    1    1    1
# [2,]    1    2    1    1
# [3,]    1    1    1    1
# [4,]    1    1    1    1
#
# , , 3, 2
#
#      [,1] [,2] [,3] [,4]
# [1,]    1    1    1    1
# [2,]    1    1    1    1
# [3,]    1    1    1    1
# [4,]    1    1    1    1
#
# , , 4, 2
#
#      [,1] [,2] [,3] [,4]
# [1,]    1    1    1    1
# [2,]    1    1    1    1
# [3,]    1    1    1    1
# [4,]    1    1    1    1
#
# , , 1, 3
#
#      [,1] [,2] [,3] [,4]
# [1,]    1    1    1    1
# [2,]    1    1    1    1
# [3,]    1    1    1    1
# [4,]    1    1    1    1
#
# , , 2, 3
#
#      [,1] [,2] [,3] [,4]
# [1,]    1    1    1    1
# [2,]    1    1    1    1
# [3,]    1    1    1    1
# [4,]    1    1    1    1
#
# , , 3, 3
#
#      [,1] [,2] [,3] [,4]
# [1,]    1    1    1    1
# [2,]    1    1    1    1
# [3,]    1    1    2    1
# [4,]    1    1    1    1
#
# , , 4, 3
#
#      [,1] [,2] [,3] [,4]
# [1,]    1    1    1    1
# [2,]    1    1    1    1
# [3,]    1    1    1    1
# [4,]    1    1    1    1
#
# , , 1, 4
#
#      [,1] [,2] [,3] [,4]
# [1,]    1    1    1    1
# [2,]    1    1    1    1
# [3,]    1    1    1    1
# [4,]    1    1    1    1
#
# , , 2, 4
#
#      [,1] [,2] [,3] [,4]
# [1,]    1    1    1    1
# [2,]    1    1    1    1
# [3,]    1    1    1    1
# [4,]    1    1    1    1
#
# , , 3, 4
#
#      [,1] [,2] [,3] [,4]
# [1,]    1    1    1    1
# [2,]    1    1    1    1
# [3,]    1    1    1    1
# [4,]    1    1    1    1
#
# , , 4, 4
#
#      [,1] [,2] [,3] [,4]
# [1,]    1    1    1    1
# [2,]    1    1    1    1
# [3,]    1    1    1    1
# [4,]    1    1    1    2



cleanEx()
nameEx("diag4Darray")
### * diag4Darray

flush(stderr()); flush(stdout())

### Name: diag4Darray
### Title: Define function to create a 'diagonal' array or get the diagonal
###   of an array
### Aliases: diag4Darray

### ** Examples

x <- diag4Darray(c(1,3,6,2), dim = 4)
x
# , , 1, 1
#
#      [,1] [,2] [,3] [,4]
# [1,]    1    0    0    0
# [2,]    0    0    0    0
# [3,]    0    0    0    0
# [4,]    0    0    0    0
#
# , , 2, 1
#
#      [,1] [,2] [,3] [,4]
# [1,]    0    0    0    0
# [2,]    0    0    0    0
# [3,]    0    0    0    0
# [4,]    0    0    0    0
#
# , , 3, 1
#
#      [,1] [,2] [,3] [,4]
# [1,]    0    0    0    0
# [2,]    0    0    0    0
# [3,]    0    0    0    0
# [4,]    0    0    0    0
#
# , , 4, 1
#
#      [,1] [,2] [,3] [,4]
# [1,]    0    0    0    0
# [2,]    0    0    0    0
# [3,]    0    0    0    0
# [4,]    0    0    0    0
#
# , , 1, 2
#
#      [,1] [,2] [,3] [,4]
# [1,]    0    0    0    0
# [2,]    0    0    0    0
# [3,]    0    0    0    0
# [4,]    0    0    0    0
#
# , , 2, 2
#
#      [,1] [,2] [,3] [,4]
# [1,]    0    0    0    0
# [2,]    0    3    0    0
# [3,]    0    0    0    0
# [4,]    0    0    0    0
#
# , , 3, 2
#
#      [,1] [,2] [,3] [,4]
# [1,]    0    0    0    0
# [2,]    0    0    0    0
# [3,]    0    0    0    0
# [4,]    0    0    0    0
#
# , , 4, 2
#
#      [,1] [,2] [,3] [,4]
# [1,]    0    0    0    0
# [2,]    0    0    0    0
# [3,]    0    0    0    0
# [4,]    0    0    0    0
#
# , , 1, 3
#
#      [,1] [,2] [,3] [,4]
# [1,]    0    0    0    0
# [2,]    0    0    0    0
# [3,]    0    0    0    0
# [4,]    0    0    0    0
#
# , , 2, 3
#
#      [,1] [,2] [,3] [,4]
# [1,]    0    0    0    0
# [2,]    0    0    0    0
# [3,]    0    0    0    0
# [4,]    0    0    0    0
#
# , , 3, 3
#
#      [,1] [,2] [,3] [,4]
# [1,]    0    0    0    0
# [2,]    0    0    0    0
# [3,]    0    0    6    0
# [4,]    0    0    0    0
#
# , , 4, 3
#
#      [,1] [,2] [,3] [,4]
# [1,]    0    0    0    0
# [2,]    0    0    0    0
# [3,]    0    0    0    0
# [4,]    0    0    0    0
#
# , , 1, 4
#
#      [,1] [,2] [,3] [,4]
# [1,]    0    0    0    0
# [2,]    0    0    0    0
# [3,]    0    0    0    0
# [4,]    0    0    0    0
#
# , , 2, 4
#
#      [,1] [,2] [,3] [,4]
# [1,]    0    0    0    0
# [2,]    0    0    0    0
# [3,]    0    0    0    0
# [4,]    0    0    0    0
#
# , , 3, 4
#
#      [,1] [,2] [,3] [,4]
# [1,]    0    0    0    0
# [2,]    0    0    0    0
# [3,]    0    0    0    0
# [4,]    0    0    0    0
#
# , , 4, 4
#
#      [,1] [,2] [,3] [,4]
# [1,]    0    0    0    0
# [2,]    0    0    0    0
# [3,]    0    0    0    0
# [4,]    0    0    0    2
diag4Darray(x)
# 1, 3, 6, 2



cleanEx()
nameEx("plot.HessMLP")
### * plot.HessMLP

flush(stderr()); flush(stdout())

### Name: plot.HessMLP
### Title: Plot method for the HessMLP Class
### Aliases: plot.HessMLP

### ** Examples

#' ## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR

## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 250
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                           data = nntrData,
                           linear.output = TRUE,
                           size = hidden_neurons,
                           decay = decay,
                           maxit = iters)
# Try HessianMLP
sens <- NeuralSens::HessianMLP(nnetmod, trData = nntrData, plot = FALSE)



cleanEx()
nameEx("plot.SensMLP")
### * plot.SensMLP

flush(stderr()); flush(stdout())

### Name: plot.SensMLP
### Title: Plot method for the SensMLP Class
### Aliases: plot.SensMLP

### ** Examples

#' ## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR

## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 250
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                           data = nntrData,
                           linear.output = TRUE,
                           size = hidden_neurons,
                           decay = decay,
                           maxit = iters)
# Try SensAnalysisMLP
sens <- NeuralSens::SensAnalysisMLP(nnetmod, trData = nntrData, plot = FALSE)



cleanEx()
nameEx("print.HessMLP")
### * print.HessMLP

flush(stderr()); flush(stdout())

### Name: print.HessMLP
### Title: Print method for the HessMLP Class
### Aliases: print.HessMLP

### ** Examples

## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR

## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 250
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                           data = nntrData,
                           linear.output = TRUE,
                           size = hidden_neurons,
                           decay = decay,
                           maxit = iters)
# Try HessianMLP
sens <- NeuralSens::HessianMLP(nnetmod, trData = nntrData, plot = FALSE)
sens



cleanEx()
nameEx("print.SensMLP")
### * print.SensMLP

flush(stderr()); flush(stdout())

### Name: print.SensMLP
### Title: Print method for the SensMLP Class
### Aliases: print.SensMLP

### ** Examples

## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR

## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 250
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                           data = nntrData,
                           linear.output = TRUE,
                           size = hidden_neurons,
                           decay = decay,
                           maxit = iters)
# Try SensAnalysisMLP
sens <- NeuralSens::SensAnalysisMLP(nnetmod, trData = nntrData, plot = FALSE)
sens



cleanEx()
nameEx("print.summary.HessMLP")
### * print.summary.HessMLP

flush(stderr()); flush(stdout())

### Name: print.summary.HessMLP
### Title: Print method of the summary HessMLP Class
### Aliases: print.summary.HessMLP

### ** Examples

## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR

## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 250
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                           data = nntrData,
                           linear.output = TRUE,
                           size = hidden_neurons,
                           decay = decay,
                           maxit = iters)
# Try HessianMLP
sens <- NeuralSens::HessianMLP(nnetmod, trData = nntrData, plot = FALSE)
print(summary(sens))



cleanEx()
nameEx("print.summary.SensMLP")
### * print.summary.SensMLP

flush(stderr()); flush(stdout())

### Name: print.summary.SensMLP
### Title: Print method of the summary SensMLP Class
### Aliases: print.summary.SensMLP

### ** Examples

## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR

## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 250
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                           data = nntrData,
                           linear.output = TRUE,
                           size = hidden_neurons,
                           decay = decay,
                           maxit = iters)
# Try SensAnalysisMLP
sens <- NeuralSens::SensAnalysisMLP(nnetmod, trData = nntrData, plot = FALSE)
print(summary(sens))



cleanEx()
nameEx("summary.HessMLP")
### * summary.HessMLP

flush(stderr()); flush(stdout())

### Name: summary.HessMLP
### Title: Summary Method for the HessMLP Class
### Aliases: summary.HessMLP

### ** Examples

## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR

## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 250
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                           data = nntrData,
                           linear.output = TRUE,
                           size = hidden_neurons,
                           decay = decay,
                           maxit = iters)
# Try HessianMLP
sens <- NeuralSens::HessianMLP(nnetmod, trData = nntrData, plot = FALSE)
summary(sens)



cleanEx()
nameEx("summary.SensMLP")
### * summary.SensMLP

flush(stderr()); flush(stdout())

### Name: summary.SensMLP
### Title: Summary Method for the SensMLP Class
### Aliases: summary.SensMLP

### ** Examples

## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR

## Parameters of the NNET ------------------------------------------------------
hidden_neurons <- 5
iters <- 250
decay <- 0.1

################################################################################
#########################  REGRESSION NNET #####################################
################################################################################
## Regression dataframe --------------------------------------------------------
# Scale the data
fdata.Reg.tr <- fdata[,2:ncol(fdata)]
fdata.Reg.tr[,3] <- fdata.Reg.tr[,3]/10
fdata.Reg.tr[,1] <- fdata.Reg.tr[,1]/1000

# Normalize the data for some models
preProc <- caret::preProcess(fdata.Reg.tr, method = c("center","scale"))
nntrData <- predict(preProc, fdata.Reg.tr)

#' ## TRAIN nnet NNET --------------------------------------------------------
# Create a formula to train NNET
form <- paste(names(fdata.Reg.tr)[2:ncol(fdata.Reg.tr)], collapse = " + ")
form <- formula(paste(names(fdata.Reg.tr)[1], form, sep = " ~ "))

set.seed(150)
nnetmod <- nnet::nnet(form,
                           data = nntrData,
                           linear.output = TRUE,
                           size = hidden_neurons,
                           decay = decay,
                           maxit = iters)
# Try SensAnalysisMLP
sens <- NeuralSens::SensAnalysisMLP(nnetmod, trData = nntrData, plot = FALSE)
summary(sens)



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
