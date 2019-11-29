pkgname <- "psychNET"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('psychNET')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("psychNET-package")
### * psychNET-package

flush(stderr()); flush(stdout())

### Name: psychNET-package
### Title: psychNET : Psychometric network modelling for multivariate time
###   series data.
### Aliases: psychNET-package
### Keywords: package

### ** Examples

# Load the R package psychNET
library(psychNET)



cleanEx()
nameEx("psychNET")
### * psychNET

flush(stderr()); flush(stdout())

### Name: psychNET
### Title: Psychometric networks estimated by multivariate time series
###   methods.
### Aliases: psychNET

### ** Examples

## load the psychNET library
library(psychNET)

## load the Canada dataset from the 'vars' package
data("Canada", package = "vars")
Canada_data_frame <- data.frame(Canada)

## fit a VAR model
VAR_model <- psychNET(Canada_data_frame, model = "VAR", lag = 1, type = "const")
# print the result
VAR_model
# summarize the resulting network
summary(VAR_model)
# summarize the VAR model using the original summary method
vars:::summary.varest(VAR_model$fit)
# plot the VAR model results using the original plot method
vars:::plot.varest(VAR_model$fit)
# plot the resulting network
plot(VAR_model)

## fit a sparse VAR model
sparse_VAR_model <- psychNET(Canada_data_frame, model = "SVAR", lag = 1)
# print the result
sparse_VAR_model
# summarize the resulting network
summary(sparse_VAR_model)
# plot the sparse VAR model results using the original plot method
sparsevar::plotVAR(sparse_VAR_model$fit)
# plot the resulting network
plot(sparse_VAR_model)

## fit a sparse VAR model as the one in the 'bigtime' package
sparse_lassVAR_model <- psychNET(Canada_data_frame, 
model = "SVARHL",penalty = "LASSO", lag = 1, VARgran=c(500,1000))
# print the result
sparse_lassVAR_model
# summarize the resulting network
summary(sparse_lassVAR_model)
# plot the resulting network
plot(sparse_lassVAR_model)




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
