
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/fastDummies)](https://cran.r-project.org/package=fastDummies)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/jacobkap/fastDummies?branch=master&svg=true)](https://ci.appveyor.com/project/jacobkap/fastDummies)
[![Build
Status](https://travis-ci.org/jacobkap/fastDummies.svg?branch=master)](https://travis-ci.org/jacobkap/fastDummies)
[![Coverage
status](https://codecov.io/gh/jacobkap/fastDummies/branch/master/graph/badge.svg)](https://codecov.io/github/jacobkap/fastDummies?branch=master)
[![](https://cranlogs.r-pkg.org/badges/fastDummies)](https://cran.rstudio.com/web/packages/fastDummies/index.html)

## Overview

The goal of fastDummies is to quickly create dummy variables (columns)
and dummy rows. Creating dummy variables is possible through base R or
other packages, but this package is much faster than those methods.

## Installation

``` r
To install this package, use the code
install.packages("fastDummies")


# The development version is available on Github.
# install.packages("devtools")
devtools::install_github("jacobkap/fastDummies")
```

## Usage

``` r
library(fastDummies)
```

There are two functions in this package:

  - `dummy_cols()` lets you make dummy variables (`dummy_columns()` is a
    clone of `dummy_cols()`)  
  - `dummy_rows()` which lets you make dummy rows.
