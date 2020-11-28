## ----echo=FALSE---------------------------------------------------------------
knitr::kable(data.frame(animals = c("dog", "dog", "cat")))

## ----setup, echo=TRUE---------------------------------------------------------
fastDummies_example <- data.frame(numbers = 1:3,
                    gender  = c("male", "male", "female"),
                    animals = c("dog", "dog", "cat"),
                    dates   = as.Date(c("2012-01-01", "2011-12-31",
                                          "2012-01-01")),
                    stringsAsFactors = FALSE)
knitr::kable(fastDummies_example)

## ----echo=TRUE----------------------------------------------------------------
results <- fastDummies::dummy_cols(fastDummies_example)
knitr::kable(results)

## ----echo=TRUE----------------------------------------------------------------
results <- fastDummies::dummy_cols(fastDummies_example, select_columns = "numbers")
knitr::kable(results)

## ----echo=TRUE----------------------------------------------------------------
results <- fastDummies::dummy_cols(fastDummies_example, remove_first_dummy = TRUE)
knitr::kable(results)

