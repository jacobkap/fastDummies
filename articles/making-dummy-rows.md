# Making dummy rows with dummy_rows()

When dealing with data, there are often missing rows. While truly
handling missing data is far beyond the scope of this package, the
function
[`dummy_rows()`](https://jacobkap.github.io/fastDummies/reference/dummy_rows.md)
lets you add those missing rows back into the data.

The function takes all character, factor, and Date columns, finds all
possible combinations of their values, and adds the rows that are not in
the original data set. Any columns not used in creating the combinations
(e.g. numeric) are given a value of NA (unless otherwise specified with
*dummy_value*).

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
|--------:|:-------|:--------|:-----------|
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
|--------:|:-------|:--------|:-----------|
|       1 | male   | dog     | 2012-01-01 |
|       2 | male   | dog     | 2011-12-31 |
|       3 | female | cat     | 2012-01-01 |
|      NA | female | cat     | 2011-12-31 |
|      NA | male   | cat     | 2011-12-31 |
|      NA | female | dog     | 2011-12-31 |
|      NA | male   | cat     | 2012-01-01 |
|      NA | female | dog     | 2012-01-01 |

When we run the function we can see that there are indeed 8 rows
possible, and that the 5 rows missing from the original data have been
added.

To explicitly see which rows are new, set the *dummy_indicator*
parameter to TRUE. This provides a column called dummy_indicator with a
value of 0 if the row is in the original data and 1 if it was added.

``` r
results <- fastDummies::dummy_rows(fastDummies_example, dummy_indicator = TRUE)
knitr::kable(results)
```

| numbers | gender | animals | dates      | dummy_indicator |
|--------:|:-------|:--------|:-----------|----------------:|
|       1 | male   | dog     | 2012-01-01 |               0 |
|       2 | male   | dog     | 2011-12-31 |               0 |
|       3 | female | cat     | 2012-01-01 |               0 |
|      NA | female | cat     | 2011-12-31 |               1 |
|      NA | male   | cat     | 2011-12-31 |               1 |
|      NA | female | dog     | 2011-12-31 |               1 |
|      NA | male   | cat     | 2012-01-01 |               1 |
|      NA | female | dog     | 2012-01-01 |               1 |

By default, columns not used for making the combinations are given a
value of NA in the new rows. You can choose the value given with the
parameter *dummy_value*. It takes an input, a string or single number.

``` r
results1 <- fastDummies::dummy_rows(fastDummies_example, dummy_value = 0)
results2 <- fastDummies::dummy_rows(fastDummies_example, dummy_value = "new value")
knitr::kable(results1)
```

| numbers | gender | animals | dates      |
|--------:|:-------|:--------|:-----------|
|       1 | male   | dog     | 2012-01-01 |
|       2 | male   | dog     | 2011-12-31 |
|       3 | female | cat     | 2012-01-01 |
|       0 | female | cat     | 2011-12-31 |
|       0 | male   | cat     | 2011-12-31 |
|       0 | female | dog     | 2011-12-31 |
|       0 | male   | cat     | 2012-01-01 |
|       0 | female | dog     | 2012-01-01 |

``` r
knitr::kable(results2)
```

| numbers   | gender | animals | dates      |
|:----------|:-------|:--------|:-----------|
| 1         | male   | dog     | 2012-01-01 |
| 2         | male   | dog     | 2011-12-31 |
| 3         | female | cat     | 2012-01-01 |
| new value | female | cat     | 2011-12-31 |
| new value | male   | cat     | 2011-12-31 |
| new value | female | dog     | 2011-12-31 |
| new value | male   | cat     | 2012-01-01 |
| new value | female | dog     | 2012-01-01 |

The parameter *select_columns* lets you choose which columns to use when
making the combinations. It accepts a string or vector of column names.
This can come in handy when you want to include a numeric column, such
as years, when making the combinations. A new data set will help
demonstrate this. This data set shows (imaginary) crime in New York City
and San Francisco during 1990 and 2000. The problem is that there is no
row for New York City for 2000. We want to add that row.

``` r
crime <- data.frame(city = c("SF", "SF", "NYC"),
                    year = c(1990, 2000, 1990),
                    crime = 1:3)
knitr::kable(crime)
```

| city | year | crime |
|:-----|-----:|------:|
| SF   | 1990 |     1 |
| SF   | 2000 |     2 |
| NYC  | 1990 |     3 |

Using the default parameters for
[`dummy_rows()`](https://jacobkap.github.io/fastDummies/reference/dummy_rows.md)
doesn’t give us what we want since it only selects the city column. We
need to select both city and year to get all the combinations we want.

``` r
results <- fastDummies::dummy_rows(crime, select_columns = c("city", "year"))
knitr::kable(results)
```

| city | year | crime |
|:-----|-----:|------:|
| SF   | 1990 |     1 |
| SF   | 2000 |     2 |
| NYC  | 1990 |     3 |
| NYC  | 2000 |    NA |
