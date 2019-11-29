pkgname <- "gscaLCA"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('gscaLCA')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("AddHealth")
### * AddHealth

flush(stderr()); flush(stdout())

### Name: AddHealth
### Title: Add Health data about substance use and abuse
### Aliases: AddHealth
### Keywords: datasets

### ** Examples

data(AddHealth)
str(AddHealth)
head(AddHealth)




cleanEx()
nameEx("TALIS")
### * TALIS

flush(stderr()); flush(stdout())

### Name: TALIS
### Title: Teaching and Learning International Survey
### Aliases: TALIS
### Keywords: datasets

### ** Examples

str(TALIS)
head(TALIS)




cleanEx()
nameEx("gscaLCA")
### * gscaLCA

flush(stderr()); flush(stdout())

### Name: gscaLCA
### Title: Main function of LCA by using fuzzy clustering GSCA
### Aliases: gscaLCA

### ** Examples


# ddHealth data with 2 clusters with 1000 samples
AH.sample= AddHealth[1:1000,]
R2 = gscaLCA(AH.sample, varnames = names(AddHealth)[2:6], num.cluster = 2, Boot.num=0)

R2$model.fit      # Model fit
R2$LCprevalence   # Latent Class Prevalence
R2$RespProb       # Item Reponse Probability
R2$membership     # Membership for all observations





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
