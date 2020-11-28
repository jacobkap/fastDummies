## ----echo=TRUE----------------------------------------------------------------
fastDummies_example <- data.frame(numbers = 1:3,
                    gender  = c("male", "male", "female"),
                    animals = c("dog", "dog", "cat"),
                    dates   = as.Date(c("2012-01-01", "2011-12-31",
                                          "2012-01-01")),
                    stringsAsFactors = FALSE)
knitr::kable(fastDummies_example)

## ----echo=TRUE----------------------------------------------------------------
results <- fastDummies::dummy_rows(fastDummies_example)
knitr::kable(results)

## ----echo=TRUE----------------------------------------------------------------
results <- fastDummies::dummy_rows(fastDummies_example, dummy_indicator = TRUE)
knitr::kable(results)

## ----echo=TRUE----------------------------------------------------------------
results1 <- fastDummies::dummy_rows(fastDummies_example, dummy_value = 0)
results2 <- fastDummies::dummy_rows(fastDummies_example, dummy_value = "new value")
knitr::kable(results1)
knitr::kable(results2)

## ----echo = TRUE--------------------------------------------------------------
crime <- data.frame(city = c("SF", "SF", "NYC"),
                    year = c(1990, 2000, 1990),
                    crime = 1:3)
knitr::kable(crime)

## ----echo=TRUE----------------------------------------------------------------
results <- fastDummies::dummy_rows(crime, select_columns = c("city", "year"))
knitr::kable(results)

