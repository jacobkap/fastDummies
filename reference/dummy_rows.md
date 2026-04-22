# Fast creation of dummy rows

dummy_rows() quickly creates dummy rows to fill in missing rows based on
all combinations of available character, factor, and date columns (if
not otherwise specified). This is useful for creating balanced panel
data. Columns that are not character, factor, or dates are filled in
with NA (or whatever value you specify).

## Usage

``` r
dummy_rows(
  .data,
  select_columns = NULL,
  dummy_value = NA,
  dummy_indicator = FALSE
)
```

## Arguments

- .data:

  An object with the data set you want to make dummy columns from.

- select_columns:

  If NULL (default), uses all character, factor, and Date columns to
  produce categories to make the dummy rows by. If not NULL, you
  manually enter a string or vector of strings of columns name(s).

- dummy_value:

  Value of the row for columns that are not selected. Default is a value
  of NA.

- dummy_indicator:

  Adds binary column to say if row is dummy or not (i.e. included in
  original data or not)

## Value

A data.frame (or tibble or data.table, depending on input data type)
with same number of columns as inputted data and original rows plus the
newly created dummy rows

## See also

[`dummy_cols`](https://jacobkap.github.io/fastDummies/reference/dummy_cols.md)
For creating dummy columns

Other dummy functions:
[`dummy_cols()`](https://jacobkap.github.io/fastDummies/reference/dummy_cols.md),
[`dummy_columns()`](https://jacobkap.github.io/fastDummies/reference/dummy_columns.md)

## Examples

``` r
crime <- data.frame(city = c("SF", "SF", "NYC"),
    year = c(1990, 2000, 1990),
    crime = 1:3)

dummy_rows(crime)
#>   city year crime
#> 1   SF 1990     1
#> 2   SF 2000     2
#> 3  NYC 1990     3
# Include year column
dummy_rows(crime, select_columns = c("city", "year"))
#>   city year crime
#> 1   SF 1990     1
#> 2   SF 2000     2
#> 3  NYC 1990     3
#> 4  NYC 2000    NA
# m=Make dummy value 0
dummy_rows(crime, select_columns = c("city", "year"),
    dummy_value = 0)
#>   city year crime
#> 1   SF 1990     1
#> 2   SF 2000     2
#> 3  NYC 1990     3
#> 4  NYC 2000     0
# Add a dummy indicator
dummy_rows(crime, select_columns = c("city", "year"),
    dummy_indicator = TRUE)
#>   city year crime dummy_indicator
#> 1   SF 1990     1               0
#> 2   SF 2000     2               0
#> 3  NYC 1990     3               0
#> 4  NYC 2000    NA               1
```
