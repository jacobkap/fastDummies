library(dplyr)
library(fastDummies)

crime <- data.frame(
  city  = c("SF", "SF", "NYC"),
  year  = c(1990, 2000, 1990),
  crime = 1:3
)

crime_grouped <- group_by(crime, city)
is_grouped_df(crime_grouped)  # TRUE

# dummy_cols drops the grouping
result <- dummy_cols(crime_grouped, select_columns = "year")
is_grouped_df(result)   # FALSE  <-- bug: should be TRUE
group_vars(result)       # character(0)  <-- bug: should be "city"

# dummy_rows drops the grouping too
result2 <- dummy_rows(crime_grouped, select_columns = "year")
is_grouped_df(result2)  # FALSE  <-- bug: should be TRUE
group_vars(result2)      # character(0)  <-- bug: should be "city"
