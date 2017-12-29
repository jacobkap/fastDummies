context("dummy_indicator is only integers 0 and 1")

load(system.file("testdata", "dummy_rows_test.rda",
                 package = "fastDummies"))

test_that("dummy_indicator is binary column", {

  # With dummy_indicator TRUE
  expect_true((unique(dummy_rows(no_dummies_needed,
                                 dummy_indicator = TRUE)$dummy_indicator) %in%
               c(0)))
  expect_true(all(unique(dummy_rows(rows_dates,
                                 dummy_indicator = TRUE)$dummy_indicator) %in%
               0:1))
  expect_true(all(unique(dummy_rows(rows_no_dummies,
                                 dummy_indicator = TRUE)$dummy_indicator) %in%
               0:1))
  expect_true(all(unique(dummy_rows(small_rows,
                                 dummy_indicator = TRUE)$dummy_indicator) %in%
               0:1))


  # with set dummy_value
  expect_true(all(unique(dummy_rows(no_dummies_needed,
                                dummy_indicator = TRUE,
                                dummy_value = "test")$dummy_indicator) %in%
                0:1))
  expect_true(all(unique(dummy_rows(rows_dates,
                                dummy_indicator = TRUE,
                                dummy_value = "test")$dummy_indicator) %in%
                0:1))
  expect_true(all(unique(dummy_rows(rows_no_dummies,
                                dummy_indicator = TRUE,
                                dummy_value = "test")$dummy_indicator) %in%
                0:1))
  expect_true(all(unique(dummy_rows(small_rows,
                                dummy_indicator = TRUE,
                                dummy_value = "test")$dummy_indicator) %in%
                0:1))

  # With columns selected TRUE
  expect_true(all(unique(dummy_rows(no_dummies_needed,
                                dummy_indicator = TRUE,
                                select_columns = "animals")$dummy_indicator) %in%
                0))
  expect_true(all(unique(dummy_rows(rows_dates,
                                dummy_indicator = TRUE,
                                select_columns = "dates")$dummy_indicator) %in%
                0:1))
  expect_true(all(unique(dummy_rows(rows_no_dummies,
                                dummy_indicator = TRUE)$dummy_indicator) %in%
                0:1))
  expect_true(all(unique(dummy_rows(small_rows,
                                dummy_indicator = TRUE,
                                select_columns = "numbers")$dummy_indicator) %in%
                0:1))
})
