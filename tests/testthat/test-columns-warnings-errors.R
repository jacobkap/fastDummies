context("Checks dummy_cols for warnings and errors")

load(system.file("testdata", "fastDummies_data.rda",
                 package = "fastDummies"))

test_that("Including non-existing in
          select_columns leads to warning", {

            expect_warning(dummy_cols(fastDummies_example[, "gender",
                                                          drop = FALSE],
                                      select_columns = c("gender", "fake")))
            expect_warning(dummy_cols(fastDummies_example[, "gender",
                                                          drop = FALSE],
                                      select_columns = c("fake", "gender")))
            expect_warning(dummy_cols(fastDummies_example[, "gender",
                                                          drop = FALSE],
                                      select_columns = c("fake", "gender",
                                                         "fake")))
})

test_that("Only having non-existing column in select_columns returns error", {

  expect_error(dummy_cols(fastDummies_example, select_columns = "number"))
  expect_error(dummy_cols(fastDummies_example[, "numbers", drop = FALSE], select_columns = "number"))
  expect_error(dummy_cols(fastDummies_example[, "gender", drop = FALSE],
                          select_columns = "gen"))
  expect_error(dummy_cols(fastDummies_example, select_columns = ""))
  expect_error(dummy_cols(no_dummies_needed, select_columns = ""))
  expect_error(dummy_cols(crime, select_columns = ""))
  expect_error(dummy_cols(fastDummies_example[, "gender", drop = FALSE],
                          select_columns = ""))
})

test_that("no errors or warnings", {
  expect_silent(dummy_cols(fastDummies_example))
  expect_silent(dummy_cols(no_dummies_needed))
  expect_silent(dummy_cols(no_dummies_needed_DT))
  expect_silent(dummy_cols(no_dummies_needed_tibble))
  expect_silent(dummy_cols(crime))
  expect_silent(dummy_cols(crime_full))
  expect_silent(dummy_cols(crime_DT))
  expect_silent(dummy_cols(crime_full_DT))
  expect_silent(dummy_cols(crime_tibble))
  expect_silent(dummy_cols(crime_full_tibble))
  expect_silent(dummy_cols(fastDummies_example))
  expect_silent(dummy_cols(fastDummies_example_DT))
  expect_silent(dummy_cols(fastDummies_example_tibble))
  expect_silent(dummy_cols(fastDummies_full))
  expect_silent(dummy_cols(fastDummies_full_DT))
  expect_silent(dummy_cols(fastDummies_full_tibble))
})

test_that("error if both remove options are true", {
  expect_error(dummy_cols(no_dummies_needed,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(no_dummies_needed_DT,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(no_dummies_needed_tibble,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(crime,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(crime_full,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(crime_DT,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(crime_full_DT,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(crime_tibble,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(crime_full_tibble,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(fastDummies_example,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(fastDummies_example_DT,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(fastDummies_example_tibble,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(fastDummies_full,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(fastDummies_full_DT,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(fastDummies_full_tibble,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
})
