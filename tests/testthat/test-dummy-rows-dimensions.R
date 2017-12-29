context("dummy_rows returns proper dimensions")

load(system.file("testdata", "dummy_rows_test.rda",
                 package = "fastDummies"))


test_that("dummy_rows returns same number of columns as inputted", {
  expect_equal(ncol(dummy_rows(no_dummies_needed)),       ncol(no_dummies_needed))
  expect_equal(ncol(dummy_rows(rows_dates)),       ncol(rows_dates))
  expect_equal(ncol(dummy_rows(rows_no_dummies)),      ncol(rows_no_dummies))
  expect_equal(ncol(dummy_rows(small_rows)),       ncol(small_rows))

  # With dummy_indicator TRUE
  expect_equal(ncol(dummy_rows(no_dummies_needed, dummy_indicator = TRUE)),
               ncol(no_dummies_needed) + 1)
  expect_equal(ncol(dummy_rows(rows_dates, dummy_indicator = TRUE)),
               ncol(rows_dates) + 1)
  expect_equal(ncol(dummy_rows(rows_no_dummies, dummy_indicator = TRUE)),
               ncol(rows_no_dummies) + 1)
  expect_equal(ncol(dummy_rows(small_rows, dummy_indicator = TRUE)),
               ncol(small_rows) + 1)
})

test_that("Number of rows is as expected", {
  expect_equal(nrow(dummy_rows(no_dummies_needed)),      4 )
  expect_equal(nrow(dummy_rows(rows_dates)),       18)
  expect_equal(nrow(dummy_rows(rows_no_dummies)),      9)
  expect_equal(nrow(dummy_rows(small_rows)),       9)

  # With dummy_indicator TRUE
  expect_equal(nrow(dummy_rows(no_dummies_needed, dummy_indicator = TRUE)), 4)
  expect_equal(nrow(dummy_rows(rows_dates, dummy_indicator = TRUE)), 18)
  expect_equal(nrow(dummy_rows(rows_no_dummies, dummy_indicator = TRUE)), 9)
  expect_equal(nrow(dummy_rows(small_rows, dummy_indicator = TRUE)), 9)

})
