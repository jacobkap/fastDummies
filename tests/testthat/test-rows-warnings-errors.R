context("Checks dummy_rows for warnings, errors, and silent")

load(system.file("testdata", "fastDummies_data.rda",
                 package = "fastDummies"))


error_data <- data.frame(numbers = 1:10,
                         number2 = 11:20,
                         stringsAsFactors = FALSE)

test_that("Error on stop conditions", {

  expect_error(dummy_rows(error_data))
  expect_error(dummy_rows(error_data),
               paste0("No character, factor, or Date columns found.",
                      " Please use select_columns"))
})

test_that("There are warnings or errors", {
  # One column data.frame or vector
  expect_error(dummy_rows(fastDummies_example$gender))
  expect_error(dummy_rows(fastDummies_example$dates))
  expect_error(dummy_rows(fastDummies_example$numbers))
  expect_error(dummy_rows(fastDummies_example[, "gender",  drop = FALSE]))
  expect_error(dummy_rows(fastDummies_example[, "dates",   drop = FALSE]))
  expect_error(dummy_rows(fastDummies_example[, "numbers", drop = FALSE]))

  expect_error(dummy_rows(fastDummies_example_tibble$gender))
  expect_error(dummy_rows(fastDummies_example_tibble$dates))
  expect_error(dummy_rows(fastDummies_example_tibble$numbers))
  expect_error(dummy_rows(fastDummies_example_tibble[, "gender",  drop = FALSE]))
  expect_error(dummy_rows(fastDummies_example_tibble[, "dates",   drop = FALSE]))
  expect_error(dummy_rows(fastDummies_example_tibble[, "numbers", drop = FALSE]))

  expect_error(dummy_rows(fastDummies_example_DT$gender))
  expect_error(dummy_rows(fastDummies_example_DT$dates))
  expect_error(dummy_rows(fastDummies_example_DT$numbers))
  expect_error(dummy_rows(fastDummies_example_DT[, "gender",  drop = FALSE]))
  expect_error(dummy_rows(fastDummies_example_DT[, "dates",   drop = FALSE]))
  expect_error(dummy_rows(fastDummies_example_DT[, "numbers", drop = FALSE]))


})

test_that("There are no warnings or errors", {
  expect_silent(dummy_cols(crime))
  expect_silent(dummy_cols(crime$city))
  expect_silent(dummy_cols(crime$year))
  expect_silent(dummy_cols(crime_full))
  expect_silent(dummy_cols(fastDummies_example))
  expect_silent(dummy_cols(fastDummies_full))
  expect_silent(dummy_cols(no_dummies_needed))

  expect_silent(dummy_cols(crime_DT))
  expect_silent(dummy_cols(crime_DT$city))
  expect_silent(dummy_cols(crime_DT$year))
  expect_silent(dummy_cols(crime_full_DT))
  expect_silent(dummy_cols(fastDummies_example_DT))
  expect_silent(dummy_cols(fastDummies_full_DT))
  expect_silent(dummy_cols(no_dummies_needed_DT))

  expect_silent(dummy_cols(crime_tibble))
  expect_silent(dummy_cols(crime_tibble$city))
  expect_silent(dummy_cols(crime_tibble$year))
  expect_silent(dummy_cols(crime_full_tibble))
  expect_silent(dummy_cols(fastDummies_example_tibble))
  expect_silent(dummy_cols(fastDummies_full_tibble))
  expect_silent(dummy_cols(no_dummies_needed_tibble))

  expect_silent(dummy_rows(crime))
  expect_silent(dummy_rows(crime_full))
  expect_silent(dummy_rows(fastDummies_example))
  expect_silent(dummy_rows(fastDummies_full))
  expect_silent(dummy_rows(no_dummies_needed))

  expect_silent(dummy_rows(crime_DT))
  expect_silent(dummy_rows(crime_full_DT))
  expect_silent(dummy_rows(fastDummies_example_DT))
  expect_silent(dummy_rows(fastDummies_full_DT))
  expect_silent(dummy_rows(no_dummies_needed_DT))

  expect_silent(dummy_rows(crime_tibble))
  expect_silent(dummy_rows(crime_full_tibble))
  expect_silent(dummy_rows(fastDummies_example_tibble))
  expect_silent(dummy_rows(fastDummies_full_tibble))
  expect_silent(dummy_rows(no_dummies_needed_tibble))
})
