test_that("test findDMCFB", {
    set.seed(1980)
    nr <- 1000; nc <- 4
    metht <- matrix(as.integer(runif(nr * nc, 0, 100)), nr)
    methc <- matrix(rbinom(n=nr*nc,c(metht),prob = runif(nr*nc)),nr,nc)
    methl <- methc/metht
    r1 <- GRanges(rep('chr1', nr), IRanges(1:nr, width=1), strand='*')
    names(r1) <- 1:nr
    cd1 <- DataFrame(Group=rep(c('G1','G2'),each=nc/2),row.names=LETTERS[1:nc])
    OBJ1 <- cBSDMC(rowRanges=r1,methReads=methc,totalReads=metht,
                    methLevels = methl, colData=cd1)
    OBJ2 <- findDMCFB(OBJ1, bwa=10, bwb=10, nBurn=50, nMC=50, nThin=1,
                      alpha=0.05, nCores=2, pSize=500, sfiles=FALSE)
    expect_equal(methReads(OBJ2)[1,1], methReads(OBJ1)[1,1])
})
