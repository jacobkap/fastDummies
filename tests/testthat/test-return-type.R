context("test-return-type")

load(system.file("testdata", "fastDummies_data.rda",
                 package = "fastDummies"))

test_that("tibble input returns tibble", {
  expect_is(dummy_cols(tibble::as.tibble(crime)), "tbl_df")
  expect_is(dummy_cols(tibble::as.tibble(crime$city)), "tbl_df")
  expect_is(dummy_cols(tibble::as.tibble(crime$year)), "tbl_df")
  expect_is(dummy_cols(tibble::as.tibble(crime_full)), "tbl_df")
  expect_is(dummy_cols(tibble::as.tibble(fastDummies_example)), "tbl_df")
  expect_is(dummy_cols(tibble::as.tibble(fastDummies_full)), "tbl_df")
  expect_is(dummy_cols(tibble::as.tibble(no_dummies_needed)), "tbl_df")

  expect_is(dummy_rows(tibble::as.tibble(crime)), "tbl_df")
  expect_is(dummy_rows(tibble::as.tibble(crime_full)), "tbl_df")
  expect_is(dummy_rows(tibble::as.tibble(fastDummies_example)), "tbl_df")
  expect_is(dummy_rows(tibble::as.tibble(fastDummies_full)), "tbl_df")
  expect_is(dummy_rows(tibble::as.tibble(no_dummies_needed)), "tbl_df")

})

test_that("data.frame input returns data.frame", {
  expect_equal("data.frame", class(dummy_cols(crime))[1])
  expect_equal("data.frame", class(dummy_cols(crime$city))[1])
  expect_equal("data.frame", class(dummy_cols(crime$year))[1])
  expect_equal("data.frame", class(dummy_cols(crime_full))[1])
  expect_equal("data.frame", class(dummy_cols(fastDummies_example))[1])
  expect_equal("data.frame", class(dummy_cols(fastDummies_full))[1])
  expect_equal("data.frame", class(dummy_cols(no_dummies_needed))[1])

  expect_equal("data.frame", class(dummy_rows(crime))[1])
  expect_equal("data.frame", class(dummy_rows(crime_full))[1])
  expect_equal("data.frame", class(dummy_rows(fastDummies_example))[1])
  expect_equal("data.frame", class(dummy_rows(fastDummies_full))[1])
  expect_equal("data.frame", class(dummy_rows(no_dummies_needed))[1])
})

test_that("data.table input returns data.table", {
  expect_is(dummy_cols(data.table::as.data.table(crime)), "data.table")
  expect_is(dummy_cols(data.table::as.data.table(crime$city)), "data.table")
  expect_is(dummy_cols(data.table::as.data.table(crime$year)), "data.table")
  expect_is(dummy_cols(data.table::as.data.table(crime_full)), "data.table")
  expect_is(dummy_cols(data.table::as.data.table(fastDummies_example)), "data.table")
  expect_is(dummy_cols(data.table::as.data.table(fastDummies_full)), "data.table")
  expect_is(dummy_cols(data.table::as.data.table(no_dummies_needed)), "data.table")

  expect_is(dummy_rows(data.table::as.data.table(crime)), "data.table")
  expect_is(dummy_rows(data.table::as.data.table(crime_full)), "data.table")
  expect_is(dummy_rows(data.table::as.data.table(fastDummies_example)), "data.table")
  expect_is(dummy_rows(data.table::as.data.table(fastDummies_full)), "data.table")
  expect_is(dummy_rows(data.table::as.data.table(no_dummies_needed)), "data.table")
})
