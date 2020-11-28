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
### Title: Add Health data about substance use
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
### Title: Main function of gscaLCA by using fuzzy clustering GSCA
### Aliases: gscaLCA

### ** Examples


#AddHealth data with 3 clusters with 500 samples
AH.sample= AddHealth[1:500,]
R3 = gscaLCA (dat = AH.sample,
               varnames = names(AddHealth)[2:6],
               ID.var = "AID",
               num.class = 3,
               num.factor = "EACH",
               Boot.num = 0)
summary(R3)
R3$model.fit      # Model fit
R3$LCprevalence   # Latent Class Prevalence
R3$RespProb       # Item Response Probability
head(R3$membership)     # Membership for all observations

# AddHealth data with 3 clusters with 500 samples with two covariates
R3_2C = gscaLCA (dat = AH.sample,
                 varnames = names(AddHealth)[2:6],
                 ID.var = "AID",
                 num.class = 3,
                 num.factor = "EACH",
                 Boot.num = 0,
                 multiple.Core = FALSE,
                 covnames = names(AddHealth)[7:8], # Gender and Edu
                 cov.model = c(1, 0),   # Only Gender varaible is added to the gscaLCR.
                 multinomial.ref = "MAX")

# To print with the results of multinomial regression with hard partitioning of the gscaLCR,
# use the option of "multinomial.hard".
summary(R3_2C, "multinomial.hard")





cleanEx()
nameEx("gscaLCR")
### * gscaLCR

flush(stderr()); flush(stdout())

### Name: gscaLCR
### Title: The 2nd and 3rd step of gscaLCA, which are the partitioning and
###   fitting regression
### Aliases: gscaLCR

### ** Examples

R2 = gscaLCA (dat = AddHealth[1:500, ], # Data has to include the possible covarite to run gscaLCR
               varnames = names(AddHealth)[2:6],
               ID.var = "AID",
               num.class = 3,
               num.factor = "EACH",
               Boot.num = 0,
               multiple.Core = F)

R2.gender = gscaLCR (R2, covnames = "Gender")
summary(R2.gender,  "multinomial.hard") # hard partitioning with multinomial regression
summary(R2.gender,  "multinomial.soft") # soft partitioning with multinomial regression
summary(R2.gender,  "binomial.hard")    # hard partitioning with binomial regression
summary(R2.gender,  "binomial.soft")    # soft partitioning with binomial regression




cleanEx()
nameEx("summary.gscaLCA")
### * summary.gscaLCA

flush(stderr()); flush(stdout())

### Name: summary.gscaLCA
### Title: Summary of gscaLCA output or gscaLCR output
### Aliases: summary.gscaLCA

### ** Examples

# summary(R2)



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
