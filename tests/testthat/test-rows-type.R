context("Columns don't change type")

load(system.file("testdata", "fastDummies_data.rda",
                 package = "fastDummies"))

test_that("Columns keep same type", {

  expect_is(dummy_rows(no_dummies_needed)$animals, "factor")
  expect_is(dummy_rows(no_dummies_needed,
                       dummy_indicator = TRUE)$animals, "factor")
  expect_is(dummy_rows(no_dummies_needed,
                       select_columns = "animals",
                       dummy_indicator = TRUE)$animals, "factor")

  expect_is(dummy_rows(crime)$city, "factor")
  expect_is(dummy_rows(crime)$year, "numeric")
  expect_is(dummy_rows(crime)$crime, "integer")
  expect_is(dummy_rows(crime,
                       dummy_indicator = TRUE)$city, "factor")
  expect_is(dummy_rows(crime,
                       dummy_indicator = TRUE)$dummy_indicator, "integer")
  expect_is(dummy_rows(crime,
                       dummy_indicator = TRUE)$year, "numeric")
  expect_is(dummy_rows(crime,
                       select_columns = "city",
                       dummy_indicator = TRUE)$city, "factor")
  expect_is(dummy_rows(crime,
                       select_columns = "year",
                       dummy_indicator = TRUE)$year, "numeric")

  expect_is(dummy_rows(fastDummies_example)$dates, "Date")
  expect_is(dummy_rows(fastDummies_example,
                       select_columns = "dates")$dates, "Date")
  expect_is(dummy_rows(fastDummies_example,
                       select_columns = "dates",
                       dummy_indicator = TRUE)$dates, "Date")


})
