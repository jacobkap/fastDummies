context("dummy_rows returns no warnings, messages, or errors")

load(system.file("testdata", "fastDummies_data.rda",
                 package = "fastDummies"))


test_that("No warnings, messages, or errors", {
  expect_silent(dummy_rows(no_dummies_needed))
  expect_silent(dummy_rows(fastDummies_example))
  expect_silent(dummy_rows(crime))

  expect_silent(dummy_rows(no_dummies_needed, dummy_indicator = TRUE))
  expect_silent(dummy_rows(fastDummies_example, dummy_indicator = TRUE))
  expect_silent(dummy_rows(crime, dummy_indicator = TRUE))

  expect_silent(dummy_rows(no_dummies_needed, dummy_indicator = FALSE,
                           dummy_value = "dummy"))
  expect_silent(dummy_rows(fastDummies_example, dummy_indicator = FALSE,
                           dummy_value = "dummy"))
  expect_silent(dummy_rows(crime, dummy_indicator = FALSE,
                           dummy_value = "dummy"))

  expect_silent(dummy_rows(no_dummies_needed, dummy_indicator = TRUE,
                           dummy_value = "dummy"))
  expect_silent(dummy_rows(fastDummies_example, dummy_indicator = TRUE,
                           dummy_value = "dummy"))
  expect_silent(dummy_rows(crime, dummy_indicator = TRUE,
                           dummy_value = "dummy"))

  expect_silent(dummy_rows(no_dummies_needed, dummy_indicator = FALSE,
                           dummy_value = 1))
  expect_silent(dummy_rows(fastDummies_example, dummy_indicator = FALSE,
                           dummy_value = 1))
  expect_silent(dummy_rows(crime, dummy_indicator = FALSE,
                           dummy_value = 1))

  expect_silent(dummy_rows(no_dummies_needed, dummy_indicator = TRUE,
                           dummy_value = 1))
  expect_silent(dummy_rows(fastDummies_example, dummy_indicator = TRUE,
                           dummy_value = 1))
  expect_silent(dummy_rows(crime, dummy_indicator = TRUE,
                           dummy_value = 1))

  expect_silent(dummy_rows(no_dummies_needed, dummy_indicator = FALSE,
                           select_columns = "animals"))
  expect_silent(dummy_rows(no_dummies_needed, dummy_indicator = FALSE,
                           select_columns = "food"))
  expect_silent(dummy_rows(no_dummies_needed, dummy_indicator = FALSE,
                           select_columns = c("animals", "food")))
  expect_silent(dummy_rows(no_dummies_needed, dummy_indicator = FALSE,
                           select_columns = c("food", "animals")))

  expect_silent(dummy_rows(no_dummies_needed, dummy_indicator = TRUE,
                           select_columns = "animals"))
  expect_silent(dummy_rows(no_dummies_needed, dummy_indicator = TRUE,
                           select_columns = "food"))
  expect_silent(dummy_rows(no_dummies_needed, dummy_indicator = TRUE,
                           select_columns = c("animals", "food")))
  expect_silent(dummy_rows(no_dummies_needed, dummy_indicator = TRUE,
                           select_columns = c("food", "animals")))

  expect_silent(dummy_rows(fastDummies_example, dummy_indicator = FALSE,
                           select_columns = "animals"))
  expect_silent(dummy_rows(fastDummies_example, dummy_indicator = FALSE,
                           select_columns = "gender"))
  expect_silent(dummy_rows(fastDummies_example, dummy_indicator = FALSE,
                           select_columns = "dates"))
  expect_silent(dummy_rows(fastDummies_example, dummy_indicator = FALSE,
                           select_columns = c("gender", "animals")))
  expect_silent(dummy_rows(fastDummies_example, dummy_indicator = FALSE,
                           select_columns = c("gender", "dates", "animals")))


  expect_silent(dummy_rows(fastDummies_example, dummy_indicator = TRUE,
                           select_columns = "animals"))
  expect_silent(dummy_rows(fastDummies_example, dummy_indicator = TRUE,
                           select_columns = "gender"))
  expect_silent(dummy_rows(fastDummies_example, dummy_indicator = TRUE,
                           select_columns = "dates"))
  expect_silent(dummy_rows(fastDummies_example, dummy_indicator = TRUE,
                           select_columns = c("gender", "animals")))
  expect_silent(dummy_rows(fastDummies_example, dummy_indicator = TRUE,
                           select_columns = c("gender", "dates", "animals")))


  expect_silent(dummy_rows(crime, dummy_indicator = FALSE,
                           select_columns = "city"))
  expect_silent(dummy_rows(crime, dummy_indicator = FALSE,
                           select_columns = "year"))
  expect_silent(dummy_rows(crime, dummy_indicator = FALSE,
                           select_columns = c("city", "year")))
  expect_silent(dummy_rows(crime, dummy_indicator = FALSE,
                           select_columns = c("year", "city")))

  expect_silent(dummy_rows(crime, dummy_indicator = TRUE,
                           select_columns = "city"))
  expect_silent(dummy_rows(crime, dummy_indicator = TRUE,
                           select_columns = "year"))
  expect_silent(dummy_rows(crime, dummy_indicator = TRUE,
                           select_columns = c("city", "year")))
  expect_silent(dummy_rows(crime, dummy_indicator = TRUE,
                           select_columns = c("year", "city")))

})
