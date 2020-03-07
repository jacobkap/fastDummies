Submitting this update at request of Kurt Hornik who alerted me that the package
fails tests for the development version on Ubuntu devices due to stringsAsFactors = FALSE
update for R 4.0.0. 

## Test environments

* local Windows install, R 3.6.1
* Ubuntu 16.04.6 (on travis-ci), R 3.6.2
* AppVeyor, R 3.6.2
* win-builder (devel and release)
* Rhub
    + Windows Server 2008 R2 SP1, R-devel, 32/64 bit
    + Ubuntu Linux 16.04 LTS, R-release, GCC
    + Fedora Linux, R-devel, clang, gfortran


## R CMD check results

There were no ERRORs or WARNINGs. There was one NOTE that said some words in the NEWS.md file are mispelled. These words are not mispelled.
   
## Reverse dependencies

There are five reverse dependencies. revdepcheck::revdep_check() returns OK for all five.


