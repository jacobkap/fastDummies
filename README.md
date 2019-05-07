
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/fastDummies)](https://cran.r-project.org/package=fastDummies)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/jacobkap/fastDummies?branch=master&svg=true)](https://ci.appveyor.com/project/jacobkap/fastDummies)
[![Build
Status](https://travis-ci.org/jacobkap/fastDummies.svg?branch=master)](https://travis-ci.org/jacobkap/fastDummies)
[![Coverage
status](https://codecov.io/gh/jacobkap/fastDummies/branch/master/graph/badge.svg)](https://codecov.io/github/jacobkap/fastDummies?branch=master)
“[![](http://cranlogs.r-pkg.org/badges/grand-total/fastDummies?color=blue)](https://cran.r-project.org/package=fastDummies)”

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

# Dummy Columns

Dummy variables (or binary variables) are commonly used in statistical
analyses and in more simple descriptive statistics. A dummy column is
one which has a value of one when a categorical event occurs and a zero
when it doesn’t occur. In most cases this is a feature of the
event/person/object being described. For example, if the dummy variable
was for occupation being an R programmer, you can ask, “is this person
an R programmer?” When the answer is yes, they get a value of 1, when it
is no, they get a value of 0.

We’ll start with a simple example and then go into using the function
`dummy_cols()`. You can also use the function `dummy_columns()` which is
identical to `dummy_cols()`.

Imagine you have a data set about animals in a local shelter. One of the
columns in your data is what animal it is: dog or cat.

| animals |
| :------ |
| dog     |
| dog     |
| cat     |

To make dummy columns from this data, you would need to produce two new
columns. One would indicate if the animal is a dog, and the other would
indicate if the animal is a cat. Each row would get a value of 1 in the
column indicating which animal they are, and 0 in the other column.

| animals | dog | cat |
| ------- | --- | --- |
| dog     | 1   | 0   |
| dog     | 1   | 0   |
| cat     | 0   | 1   |

In the function dummy\_cols, the names of these new columns are
concatenated to the original column and separated by an underscore.

| animals | animals\_dog | animals\_cat |
| ------- | ------------ | ------------ |
| dog     | 1            | 0            |
| dog     | 1            | 0            |
| cat     | 0            | 1            |

With an example like this, it is fairly easy to make the dummy columns
yourself. `dummy_cols()` automates the process, and is useful when you
have many columns to general dummy variables from or with many
categories within the column.

``` r
fastDummies_example <- data.frame(numbers = 1:3,
                    gender  = c("male", "male", "female"),
                    animals = c("dog", "dog", "cat"),
                    dates   = as.Date(c("2012-01-01", "2011-12-31",
                                          "2012-01-01")),
                    stringsAsFactors = FALSE)
knitr::kable(fastDummies_example)
```

| numbers | gender | animals | dates      |
| ------: | :----- | :------ | :--------- |
|       1 | male   | dog     | 2012-01-01 |
|       2 | male   | dog     | 2011-12-31 |
|       3 | female | cat     | 2012-01-01 |

The object **fastDummies\_example** has two character type columns, one
integer column, and a Date column. By default, `dummy_cols()` will make
dummy variables from factor or character columns only. This is because
in most cases those are the only types of data you want dummy variables
from. If those are the only columns you want, then the function takes
your data set as the first parameter and returns a data.frame with the
newly created variables appended to the end of the original data.

``` r
results <- fastDummies::dummy_cols(fastDummies_example)
knitr::kable(results)
```

| numbers | gender | animals | dates      | gender\_male | gender\_female | animals\_dog | animals\_cat |
| ------: | :----- | :------ | :--------- | -----------: | -------------: | -----------: | -----------: |
|       1 | male   | dog     | 2012-01-01 |            1 |              0 |            1 |            0 |
|       2 | male   | dog     | 2011-12-31 |            1 |              0 |            1 |            0 |
|       3 | female | cat     | 2012-01-01 |            0 |              1 |            0 |            1 |

# Dummy Rows

When dealing with data, there are often missing rows. While truly
handling missing data is far beyond the scope of this package, the
function `dummy_rows()` lets you add those missing rows back into the
data.

The function takes all character, factor, and Date columns, finds all
possible combinations of their values, and adds the rows that are not in
the original data set. Any columns not used in creating the combinations
(e.g. numeric) are given a value of NA (unless otherwise specified with
*dummy\_value*).

Lets start with a simple example.

``` r
fastDummies_example <- data.frame(numbers = 1:3,
                    gender  = c("male", "male", "female"),
                    animals = c("dog", "dog", "cat"),
                    dates   = as.Date(c("2012-01-01", "2011-12-31",
                                          "2012-01-01")),
                    stringsAsFactors = FALSE)
knitr::kable(fastDummies_example)
```

| numbers | gender | animals | dates      |
| ------: | :----- | :------ | :--------- |
|       1 | male   | dog     | 2012-01-01 |
|       2 | male   | dog     | 2011-12-31 |
|       3 | female | cat     | 2012-01-01 |

This data set has four columns: two character, one Date, and one
numeric. The function by default will use the character and Date columns
in creating the combinations. First, a small amount of math to explain
the combinations. Each column has two distinct values - gender: male &
female; animals: dog & cat; dates: 2011-12-31 & 2011-12-31. To find the
number of possible combinations, multiple the number of unique values in
each column together. 2 \* 2 \* 2 = 8.

``` r
results <- fastDummies::dummy_rows(fastDummies_example)
knitr::kable(results)
```

| numbers | gender | animals | dates      |
| ------: | :----- | :------ | :--------- |
|       1 | male   | dog     | 2012-01-01 |
|       2 | male   | dog     | 2011-12-31 |
|       3 | female | cat     | 2012-01-01 |
|      NA | female | cat     | 2011-12-31 |
|      NA | male   | cat     | 2011-12-31 |
|      NA | female | dog     | 2011-12-31 |
|      NA | male   | cat     | 2012-01-01 |
|      NA | female | dog     | 2012-01-01 |
