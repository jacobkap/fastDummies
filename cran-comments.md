## Test environments

* local Windows install, R 4.4.1
* Rhub
    + linux (R-devel)
    + macos-arm64 (R-devel)
    + macos (R-devel)
    + windows (R-devel)
* win-builder (devel)

## R CMD check results

There were no ERRORs or WARNINGs or NOTES.

## Reverse dependencies

There are 42 reverse dependencies. revdepcheck::revdep_check() returns OK for 40. The packages cbcTools 0.5.0 and logitr 1.1.2 both have errors. In both cases, according to the 00check.log file produced by revdep_check, the issue is an inability to open a port. The issue is unrelated to fastDummies. 
 

