# Fast creation of dummy variables

dummy_columns() quickly creates dummy (binary) columns from character
and factor type columns in the inputted data. This function is useful
for statistical analysis when you want binary columns rather than
character columns.

## Usage

``` r
dummy_columns(
  .data,
  select_columns = NULL,
  remove_first_dummy = FALSE,
  remove_most_frequent_dummy = FALSE,
  ignore_na = FALSE,
  split = NULL,
  remove_selected_columns = FALSE,
  omit_colname_prefix = FALSE,
  return_generated_variables = FALSE
)
```

## Arguments

- .data:

  An object with the data set you want to make dummy columns from.

- select_columns:

  Vector of column names that you want to create dummy variables from.
  If NULL (default), uses all character and factor columns.

- remove_first_dummy:

  Removes the first dummy of every variable such that only n-1 dummies
  remain. This avoids multicollinearity issues in models.

- remove_most_frequent_dummy:

  Removes the most frequently observed category such that only n-1
  dummies remain. If there is a tie for most frequent, will remove the
  first (by alphabetical order) category that is tied for most frequent.

- ignore_na:

  If TRUE, ignores any NA values in the column. If FALSE (default), then
  it will make a dummy column for value_NA and give a 1 in any row which
  has a NA value.

- split:

  A string to split a column when multiple categories are in the cell.
  For example, if a variable is Pets and the rows are "cat", "dog", and
  "turtle", each of these pets would become its own dummy column. If one
  row is "cat, dog", then a split value of "," this row would have a
  value of 1 for both the cat and dog dummy columns.

- remove_selected_columns:

  If TRUE (not default), removes the columns used to generate the dummy
  columns.

- omit_colname_prefix:

  If TRUE (not default) and \`length(select_columns) == 1\`, omit
  pre-pending the name of \`select_columns\` to the names of the newly
  generated dummy columns

- return_generated_variables:

  If TRUE (not default), returns a vector of the names of the variables
  that would be generated. Does not modify the inputted data.

## See also

[`dummy_rows`](https://jacobkap.github.io/fastDummies/reference/dummy_rows.md)
For creating dummy rows

Other dummy functions:
[`dummy_cols()`](https://jacobkap.github.io/fastDummies/reference/dummy_cols.md),
[`dummy_rows()`](https://jacobkap.github.io/fastDummies/reference/dummy_rows.md)

## Examples

``` r
crime <- data.frame(
  city = c("SF", "SF", "NYC"),
  year = c(1990, 2000, 1990),
  crime = 1:3
)
dummy_cols(crime)
#>   city year crime city_NYC city_SF
#> 1   SF 1990     1        0       1
#> 2   SF 2000     2        0       1
#> 3  NYC 1990     3        1       0
# Include year column
dummy_cols(crime, select_columns = c("city", "year"))
#>   city year crime city_NYC city_SF year_1990 year_2000
#> 1   SF 1990     1        0       1         1         0
#> 2   SF 2000     2        0       1         0         1
#> 3  NYC 1990     3        1       0         1         0
# Remove first dummy for each pair of dummy columns made
dummy_cols(crime,
  select_columns = c("city", "year"),
  remove_first_dummy = TRUE
)
#>   city year crime city_SF year_2000
#> 1   SF 1990     1       1         0
#> 2   SF 2000     2       1         1
#> 3  NYC 1990     3       0         0
```
