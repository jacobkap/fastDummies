pkgname <- "bnpa"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('bnpa')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("boot.strap.bn")
### * boot.strap.bn

flush(stderr()); flush(stdout())

### Name: boot.strap.bn
### Title: Executes a bootstrap during the learning of a BN structure
### Aliases: boot.strap.bn

### ** Examples

## Not run: 
##D # Clean environment
##D closeAllConnections()
##D rm(list=ls())
##D # Set enviroment
##D # setwd("to your working directory")
##D # Load packages
##D library(bnpa)
##D # Use working data sets from package
##D data(dataQualiN)
##D # Start the cluster
##D cl <- bnpa::create.cluster()
##D # Set the number of replications
##D nreplicates=1000
##D # Set the algorithm to be used
##D bn.algorithm="hc"
##D # Executes a parallel bootstrap process
##D data.bn.boot.strap=bnlearn::boot.strength(data = dataQualiN, R = nreplicates, algorithm =
##D bn.algorithm, cluster=cl, algorithm.args=list(score="bic"), cpdag = FALSE)
##D # Release the cluster
##D parallel::stopCluster(cl)
##D head(data.bn.boot.strap)
## End(Not run)



cleanEx()
nameEx("check.algorithms")
### * check.algorithms

flush(stderr()); flush(stdout())

### Name: check.algorithms
### Title: Verifies the BN learning algorithms
### Aliases: check.algorithms

### ** Examples

# Clean environment
closeAllConnections()
rm(list=ls())
# Set enviroment
# setwd("~/your working directory")
# Load packages
library(bnpa)
# Set what BN learning algorithms will be used
bn.learn.algorithms <- c("gs", "hc")
# Check these algorithms
check.algorithms(bn.learn.algorithms)



cleanEx()
nameEx("check.dichotomic.one.var")
### * check.dichotomic.one.var

flush(stderr()); flush(stdout())

### Name: check.dichotomic.one.var
### Title: Verify if one specific variable of a data set is dichotomic
### Aliases: check.dichotomic.one.var

### ** Examples

# Clean environment
closeAllConnections()
rm(list=ls())
# Set enviroment
# setwd("to your working directory")
# Load packages
library(bnpa)
# Use working data sets from package
data(dataQuantC)
head(dataQuantC)
# Show the structure of data set
str(dataQuantC)
# Set variable name
variable.name = "A"
# data set has not dichotomic variables and function will return FALSE
check.dichotomic.one.var(dataQuantC, variable.name)
# Adding dichotomic data to dataQuantC
dataQuantC$Z <- round(runif(500, min=0, max=1),0)
# Show the new structure of data set
str(dataQuantC)
# Set variable name
variable.name = "Z"
# Now data set has dichotomic variables and function will return TRUE
check.dichotomic.one.var(dataQuantC, variable.name)



cleanEx()
nameEx("check.levels.one.variable")
### * check.levels.one.variable

flush(stderr()); flush(stdout())

### Name: check.levels.one.variable
### Title: Check the levels of a categorical variable
### Aliases: check.levels.one.variable

### ** Examples

# Clean environment
closeAllConnections()
rm(list=ls())
# Set enviroment
# setwd("to your working directory")
# Load packages
library(bnpa)
# Use working data sets from package
data(dataQualiN)
head(dataQualiN)
# Adding random data to dataQualiN, function will return TRUE
dataQualiN$Z <- round(runif(500, min=0, max=1000),2)
# Converting the numeric variable into factor
dataQualiN$Z <- factor(dataQualiN$Z)
# Set the variable name to a non categorical one
variable.name = "Z"
# Count the number o levels of a specific variable
number.of.levels <- check.levels.one.variable(dataQualiN, variable.name)
number.of.levels
# Set the variable name to a categorical variable
variable.name = "A"
# Count the number o levels of a specific variable
number.of.levels <- check.levels.one.variable(dataQualiN, variable.name)
number.of.levels



cleanEx()
nameEx("check.na")
### * check.na

flush(stderr()); flush(stdout())

### Name: check.na
### Title: Verify variables with NA
### Aliases: check.na

### ** Examples

# Clean environment
closeAllConnections()
rm(list=ls())
# Set enviroment
# setwd("to your working directory")
# Load packages
library(bnpa)
# Use working data sets from package
data(dataQuantC)
head(dataQuantC)
# Adding NAs to dataQuantC # credits for the random NA code for: https://goo.gl/Xj6caY
dataQuantC <- as.data.frame(lapply(dataQuantC, function(cc) cc[ sample(c(TRUE, NA),
                             prob = c(0.85, 0.15), size = length(cc), replace = TRUE) ]))
# Checking the Nas
check.na(dataQuantC)



cleanEx()
nameEx("check.ordered.one.var")
### * check.ordered.one.var

flush(stderr()); flush(stdout())

### Name: check.ordered.one.var
### Title: Verify if one specific variable of a data set is an ordered
###   factor
### Aliases: check.ordered.one.var

### ** Examples

# Clean environment
closeAllConnections()
rm(list=ls())
# Set enviroment
# setwd("to your working directory")
# Load packages
library(bnpa)
# Use working data sets from package
data(dataQualiN)
head(dataQualiN)
# Transform variable A into ordered factor
dataQualiN$A <- ordered(dataQualiN$A)
# Check variable A and return TRUE
var.name <- "A"
check.ordered.one.var(dataQualiN, var.name)
# Check variable B and return FALSE
var.name <- "B"
check.ordered.one.var(dataQualiN, var.name)



cleanEx()
nameEx("check.ordered.to.pa")
### * check.ordered.to.pa

flush(stderr()); flush(stdout())

### Name: check.ordered.to.pa
### Title: Verifies if there are ordered factor variables to be declared in
###   the pa model building process
### Aliases: check.ordered.to.pa

### ** Examples

# Clean environment
closeAllConnections()
rm(list=ls())
# Set enviroment
# setwd("~/your working directory")
# Load packages
library(bnpa)
# Load the dataset
data(dataQualiN) # Pre-Loaded
# Build the BN structure
bn.structure<-bnlearn::hc(dataQualiN)
# Show the BN structure learned
bnlearn::graphviz.plot(bn.structure)
# Tranforms variables A and B in ordered factor
dataQualiN$A <- as.ordered(dataQualiN$A)
dataQualiN$B <- as.ordered(dataQualiN$B)
# Generates a list with variables to be ordered and exogenous variables
cat.var.to.use.in.pa <- bnpa::check.ordered.to.pa(bn.structure, dataQualiN)
# Show the variables
cat.var.to.use.in.pa



cleanEx()
nameEx("check.outliers")
### * check.outliers

flush(stderr()); flush(stdout())

### Name: check.outliers
### Title: Indentifies and gives an option to remove outliers
### Aliases: check.outliers

### ** Examples

# Clean environment
closeAllConnections()
rm(list=ls())
# Set enviroment
# setwd("to your working directory")
# Load packages
library(bnpa)
# Load the data set
data(dataQuantC) # Pre-Loaded
# Set a variable to ask before remove outlier or not
ask.before = "Y" # or ask.before = "N"
# Call the procedure to check if there are outliers
dataQuantC <- check.outliers(dataQuantC, ask.before)



cleanEx()
nameEx("check.type.one.var")
### * check.type.one.var

flush(stderr()); flush(stdout())

### Name: check.type.one.var
### Title: Verify the type of one variable
### Aliases: check.type.one.var

### ** Examples

# Clean environment
closeAllConnections()
rm(list=ls())
# Set enviroment
# setwd("to your working directory")
# Load packages
library(bnpa)
# Use working data sets from package
data(dataQuantC)
head(dataQuantC)
# Adding random data to dataQuantC, function will return TRUE
dataQuantC$Z <- round(runif(500, min=0, max=1000),2)
# Converting the numeric variable into factor
dataQuantC$Z <- factor(dataQuantC$Z)
# Check and return a numeric value correspondig to the variable type
# Set the variable name
variable.name = "A"
# identify the type
check.type.one.var(dataQuantC, show.message=0, variable.name)
# Set the variable name
variable.name = "Z"
# identify the type
check.type.one.var(dataQuantC, show.message=0, variable.name)



cleanEx()
nameEx("check.types")
### * check.types

flush(stderr()); flush(stdout())

### Name: check.types
### Title: Verify types of variable
### Aliases: check.types

### ** Examples

# Clean environment
closeAllConnections()
rm(list=ls())
# Set enviroment
# setwd("to your working directory")
# Load packages
library(bnpa)
# Use working data sets from package
data(dataQuantC)
# Show first lines of data set
head(dataQuantC)
# Check and return a numeric value
show.message <- 1
bnpa::check.types(dataQuantC, show.message)
# Adding random data to dataQuantC, function will return TRUE
dataQuantC$Z <- round(runif(500, min=0, max=1000),2)
# Converting the numeric variable into factor
dataQuantC$Z <- factor(dataQuantC$Z)
# Check and return a numeric value correspondig to: 1=integer, 2=numeric, 3=factor, 4=integer and
# numeric, 5=integer and  factor, 6=numeric and factor or 7=integer, numeric and factor.
show.message <- 1
bnpa::check.types(dataQuantC, show.message)
# Supressing the message
show.message <- 0
bnpa::check.types(dataQuantC, show.message)



cleanEx()
nameEx("check.variables.to.be.ordered")
### * check.variables.to.be.ordered

flush(stderr()); flush(stdout())

### Name: check.variables.to.be.ordered
### Title: Check if the variables need to be ordered
### Aliases: check.variables.to.be.ordered

### ** Examples

# Clean environment
closeAllConnections()
rm(list=ls())
# Set enviroment
# setwd("to your working directory")
# Load packages
library(bnpa)
# Use working data sets from package
data(dataQualiN)
# Show first lines of data set
head(dataQualiN)
# Insert categorical variables with more than 2 levels
dataQualiN$test.variable[dataQualiN$A == "yes"] <- "low"
dataQualiN$test.variable[dataQualiN$B == "yes"] <- "medium"
dataQualiN$test.variable[dataQualiN$X == "yes"] <- "high"
# Transform it to factor variable
dataQualiN$test.variable <- as.factor(dataQualiN$test.variable)
# Check the necessity to transform in ordered variables
bnpa::check.variables.to.be.ordered(dataQualiN)



cleanEx()
nameEx("convert.confusion.matrix")
### * convert.confusion.matrix

flush(stderr()); flush(stdout())

### Name: convert.confusion.matrix
### Title: Converts the position of any element of confusion matrix to VP,
###   FP, FN, VN
### Aliases: convert.confusion.matrix

### ** Examples

# Clean environment
closeAllConnections()
rm(list=ls())
# Set enviroment
# setwd("to your working directory")
# Load packages
library(bnpa)
# Creates a confusion matrix
confusion.matrix <-matrix(c(12395, 4, 377, 1), nrow=2, ncol=2, byrow=TRUE)
# Creates a vector with the position of VP, FP, FN, VN
cm.position <- c(4,3,2,1)
# Shows the original confusion matrix
confusion.matrix
# Converts the confusion matrix
confusion.matrix <- convert.confusion.matrix(confusion.matrix, cm.position)
# Shows the converted confusion matrix
confusion.matrix



cleanEx()
nameEx("create.cluster")
### * create.cluster

flush(stderr()); flush(stdout())

### Name: create.cluster
### Title: Create a Parallel Socket Cluster
### Aliases: create.cluster

### ** Examples

## Not run: 
##D ## Clean environment
##D closeAllConnections()
##D rm(list=ls())
##D # Set enviroment
##D # setwd("to your working directory")
##D # Load packages
##D library(bnpa)
##D # Use working data sets from package
##D data(dataQualiN)
##D # Start the cluster
##D cl <- bnpa::create.cluster()
##D # Set the number of replications
##D R=1000
##D # Set the algorithm to be used
##D algorithm="hc"
##D # Executes a parallel bootstrap process
##D data.bn.boot.strap=boot.strength(data=dataQualiN,R,algorithm,cluster=cl,
##D                                 algorithm.args=list(score="bic"),cpdag = FALSE)
##D # Release the cluster
##D parallel::stopCluster(cl)
## End(Not run)



cleanEx()
nameEx("create.dummies")
### * create.dummies

flush(stderr()); flush(stdout())

### Name: create.dummies
### Title: Creates dummy variables in the data set and remove master
###   variables
### Aliases: create.dummies

### ** Examples

# Clean environment
closeAllConnections()
rm(list=ls())
# Set enviroment
# setwd("to your working directory")
# Load packages
library(bnpa)
# Use working data sets from package
data(dataQualiN)
# Show the structure before
str(dataQualiN)
# Set possible dummy variables
dummy.vars <- c("A", "B")
# Create dummies
dataQualiN <- bnpa::create.dummies(dataQualiN, dummy.vars)
# Show the structure before
str(dataQualiN)



cleanEx()
nameEx("gera.bn.structure")
### * gera.bn.structure

flush(stderr()); flush(stdout())

### Name: gera.bn.structure
### Title: Learn the Bayesian Network structure from data and build a PA
###   model
### Aliases: gera.bn.structure

### ** Examples

## Not run: 
##D # Clean environment
##D closeAllConnections()
##D rm(list=ls())
##D # Set environment
##D # setwd("To your working directory")
##D # Load packages
##D library(bnpa)
##D # Load Data
##D data(dataQualiN)
##D # Set variables to work
##D nreplicates = 1000
##D white.list <- NULL
##D black.list <- "L-T"
##D cb.algorithms = c("gs")
##D sb.algorithms = c("hc")
##D cb.tests = "jt"
##D sb.tests = "aic"
##D optimized.option="FALSE"
##D outcome.var = "E"
##D build.pa = 0
##D # Learn the BN from data and save results (data & images)
##D gera.bn.structure(dataQualiN, white.list, black.list, nreplicates, cb.algorithms,sb.algorithms,
##D                  cb.tests, sb.tests, optimized.option, outcome.var, build.pa)
## End(Not run)



cleanEx()
nameEx("gera.pa")
### * gera.pa

flush(stderr()); flush(stdout())

### Name: gera.pa
### Title: Generates a PA model
### Aliases: gera.pa

### ** Examples

## Not run: 
##D # Clean environment
##D closeAllConnections()
##D rm(list=ls())
##D # Set enviroment
##D # setwd("To your working directory")
##D # Load packages
##D library(bnpa)
##D # Load data sets from package
##D data(dataQualiN)
##D # Show first lines
##D head(dataQualiN)
##D # Learn BN structure
##D bn.structure <- bnlearn::hc(dataQualiN)
##D bnlearn::graphviz.plot(bn.structure)
##D # Set variables
##D pa.name<-"docPAHC"
##D pa.imgname<-"imgPAHC"
##D bn.algorithm<-"hc"
##D bn.score.test<-"aic-g"
##D outcome.var<-"D"
##D # Generates the PA model from bn structure
##D gera.pa(bn.structure, dataQualiN, pa.name, pa.imgname, bn.algorithm, bn.score.test, outcome.var)
## End(Not run)



cleanEx()
nameEx("gera.pa.model")
### * gera.pa.model

flush(stderr()); flush(stdout())

### Name: gera.pa.model
### Title: Generates PA input model
### Aliases: gera.pa.model

### ** Examples

# Clean environment
closeAllConnections()
rm(list=ls())
# Set enviroment
# setwd("To your working directory")
# Load packages
library(bnpa)
library(bnlearn)
# load data sets from package
data(dataQualiN)
# Show first lines
head(dataQualiN)
# Learn BN structure
bn.structure <- hc(dataQualiN)
bnlearn::graphviz.plot(bn.structure)
# Set variables
# Generates the PA model from bn structure
pa.model <- gera.pa.model(bn.structure, dataQualiN)
pa.model



cleanEx()
nameEx("mount.wl.bl.list")
### * mount.wl.bl.list

flush(stderr()); flush(stdout())

### Name: mount.wl.bl.list
### Title: Mounts a white or black list
### Aliases: mount.wl.bl.list

### ** Examples

# Clean environment
closeAllConnections()
rm(list=ls())
# Set enviroment
# setwd("To your working directory")
# Load packages
library(bnpa)
library(bnlearn)
# Load data sets from package
data(dataQuantC)
# Show the first lines of data
head(dataQuantC)
# Learn the BN structure without black and white list
bn.structure <- hc(dataQuantC)
# Split graph panel in 2 columns
par(mfrow=c(1,2))
# Show the BN structure
bnlearn::graphviz.plot(bn.structure)
# Mounting the black list
black.list <- ("A-C,D-F")
black.list <- mount.wl.bl.list(black.list)
black.list
white.list <- ("A-B,D-G")
white.list <- mount.wl.bl.list(white.list)
white.list
# Learn the BN structure with black and white list
bn.structure <- hc(dataQuantC, whitelist = white.list, blacklist = black.list)
# Show the BN structure
bnlearn::graphviz.plot(bn.structure)



graphics::par(get("par.postscript", pos = 'CheckExEnv'))
cleanEx()
nameEx("outcome.predictor.var")
### * outcome.predictor.var

flush(stderr()); flush(stdout())

### Name: outcome.predictor.var
### Title: Builds a black list of predictor and/or outcome variable
### Aliases: outcome.predictor.var

### ** Examples

# Clean environment
closeAllConnections()
rm(list=ls())
# Set enviroment
# setwd("To your working directory")
# Load packages
library(bnpa)
library(bnlearn)
# Load data sets from package
data(dataQuantC)
# Show first lines
head(dataQuantC)
# Create an empty list or fill it before start
black.list <- ""
# Setting the type of var as typical "outcome" what means it will not point to any var
type.var <- "o"
# Setting variable "A" as "outcome" will create a black from this variable to all others
var.name <- "A"
# Creating the black list
black.list <- outcome.predictor.var(dataQuantC, var.name, type.var, black.list)
black.list
# Setting the type of var as typical "predictor" it will not be pointed from any other var
type.var <- "p"
# Setting variable "D" as "predictor" will create a blacklist from all others to it
var.name <- "D"
# Creating the black list
black.list <- outcome.predictor.var(dataQuantC, var.name, type.var, black.list)
black.list



cleanEx()
nameEx("preprocess.outliers")
### * preprocess.outliers

flush(stderr()); flush(stdout())

### Name: preprocess.outliers
### Title: Extract information of outliers
### Aliases: preprocess.outliers

### ** Examples

# Clean environment
closeAllConnections()
rm(list=ls())
# Set enviroment
# setwd("to your working directory")
# Load packages
library(bnpa)
# Load data sets from package
data(dataQuantC)
# Set parameters to function
variable.content <- dataQuantC$A
variable.name <- "A"
# Preprocess information
preprocess.information <- preprocess.outliers(dataQuantC, variable.content, variable.name)
num.outliers <- preprocess.information[[1]]
variable.content <- preprocess.information[[2]]
mean.of.outliers <- preprocess.information[[3]]



cleanEx()
nameEx("transf.into.ordinal")
### * transf.into.ordinal

flush(stderr()); flush(stdout())

### Name: transf.into.ordinal
### Title: Transform categorical variables into ordinal
### Aliases: transf.into.ordinal

### ** Examples

# Clean environment
closeAllConnections()
rm(list=ls())
# Set enviroment
# setwd("to your working directory")
# Load packages
library(bnpa)
#Load Data
data(dataQualiN)
# Transform all variables into ordinal
dataQualiN <- bnpa::transf.into.ordinal(dataQualiN)
str(dataQualiN)



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
