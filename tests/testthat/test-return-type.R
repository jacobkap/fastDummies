context("test-return-type")

load(system.file("testdata", "fastDummies_data.rda",
                 package = "fastDummies"))

test_that("tibble input returns tibble", {
  expect_is(dummy_cols(tibble::as_tibble(crime)),                         "tbl_df")
  expect_is(dummy_cols(tibble::as_tibble(crime[, "city", drop = FALSE])), "tbl_df")
  expect_is(dummy_cols(tibble::as_tibble(crime[, "year", drop = FALSE])), "tbl_df")
  expect_is(dummy_cols(tibble::as_tibble(crime_full)),                    "tbl_df")
  expect_is(dummy_cols(tibble::as_tibble(fastDummies_example)),           "tbl_df")
  expect_is(dummy_cols(tibble::as_tibble(fastDummies_full)),              "tbl_df")
  expect_is(dummy_cols(tibble::as_tibble(no_dummies_needed)),             "tbl_df")

  expect_is(dummy_rows(tibble::as_tibble(crime)),               "tbl_df")
  expect_is(dummy_rows(tibble::as_tibble(crime_full)),          "tbl_df")
  expect_is(dummy_rows(tibble::as_tibble(fastDummies_example)), "tbl_df")
  expect_is(dummy_rows(tibble::as_tibble(fastDummies_full)),    "tbl_df")
  expect_is(dummy_rows(tibble::as_tibble(no_dummies_needed)),   "tbl_df")

})

test_that("data.frame input returns data.frame", {
  expect_is(dummy_cols(crime),               "data.frame")
  expect_is(dummy_cols(crime$city),          "data.frame")
  expect_is(dummy_cols(crime$year),          "data.frame")
  expect_is(dummy_cols(crime_full),          "data.frame")
  expect_is(dummy_cols(fastDummies_example), "data.frame")
  expect_is(dummy_cols(fastDummies_full),    "data.frame")
  expect_is(dummy_cols(no_dummies_needed),   "data.frame")

  expect_is(dummy_rows(crime),               "data.frame")
  expect_is(dummy_rows(crime_full),          "data.frame")
  expect_is(dummy_rows(fastDummies_example), "data.frame")
  expect_is(dummy_rows(fastDummies_full),    "data.frame")
  expect_is(dummy_rows(no_dummies_needed),   "data.frame")

})

test_that("data.table input returns data.table", {
  expect_is(dummy_cols(data.table::as.data.table(crime)),               "data.table")
  expect_is(dummy_cols(data.table::as.data.table(crime$city)),          "data.table")
  expect_is(dummy_cols(data.table::as.data.table(crime$year)),          "data.table")
  expect_is(dummy_cols(data.table::as.data.table(crime_full)),          "data.table")
  expect_is(dummy_cols(data.table::as.data.table(fastDummies_example)), "data.table")
  expect_is(dummy_cols(data.table::as.data.table(fastDummies_full)),    "data.table")
  expect_is(dummy_cols(data.table::as.data.table(no_dummies_needed)),   "data.table")

  expect_is(dummy_rows(data.table::as.data.table(crime)),               "data.table")
  expect_is(dummy_rows(data.table::as.data.table(crime_full)),          "data.table")
  expect_is(dummy_rows(data.table::as.data.table(fastDummies_example)), "data.table")
  expect_is(dummy_rows(data.table::as.data.table(fastDummies_full)),    "data.table")
  expect_is(dummy_rows(data.table::as.data.table(no_dummies_needed)),   "data.table")
})
