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
nameEx("CombineSens")
### * CombineSens

flush(stderr()); flush(stdout())

### Name: CombineSens
### Title: Sensitivity analysis plot over time of the data
### Aliases: CombineSens

### ** Examples

## Not run: 
##D # mod should be a neural network classification model
##D sens <- SensAnalysisMLP(mod)
##D combinesens <- CombineSens(sens)
##D rawsens <- SensAnalysisMLP(mod, .rawSens = TRUE)
##D meanCombinerawSens <- CombineSens(rawsens, "mean")
##D sqmeanCombinerawSens <- CombineSens(rawsens, "sqmean")
## End(Not run)



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
nameEx("SensAnalysisMLP")
### * SensAnalysisMLP

flush(stderr()); flush(stdout())

### Name: SensAnalysisMLP
### Title: Sensitivity of NNET models
### Aliases: SensAnalysisMLP SensAnalysisMLP.default SensAnalysisMLP.train
###   SensAnalysisMLP.H2OMultinomialModel
###   SensAnalysisMLP.H2ORegressionModel SensAnalysisMLP.list
###   SensAnalysisMLP.mlp SensAnalysisMLP.nn SensAnalysisMLP.nnet
###   SensAnalysisMLP.nnetar SensAnalysisMLP.numeric

### ** Examples

## Load data -------------------------------------------------------------------
data("DAILY_DEMAND_TR")
fdata <- DAILY_DEMAND_TR
fdata[,3] <- ifelse(as.data.frame(fdata)[,3] %in% c("SUN","SAT"), 0, 1)
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
sensraw <- NeuralSens::SensAnalysisMLP(nnetmod, trData = nntrData, plot = FALSE, .rawSens = TRUE)
NeuralSens::SensFeaturePlot(sensraw, fdata = nntrData)



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
sensraw <- NeuralSens::SensAnalysisMLP(nnetmod, trData = nntrData, plot = FALSE, .rawSens = TRUE)
NeuralSens::SensitivityPlots(der = sensraw[,,1])



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
