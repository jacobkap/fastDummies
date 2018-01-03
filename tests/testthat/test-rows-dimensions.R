context("dummy_rows returns proper dimensions")

load(system.file("testdata", "fastDummies_data.rda",
                 package = "fastDummies"))


test_that("dummy_rows returns same number of columns as inputted", {
  expect_equal(ncol(dummy_rows(no_dummies_needed)), ncol(no_dummies_needed))
  expect_equal(ncol(dummy_rows(fastDummies_example)), ncol(fastDummies_example))
  expect_equal(ncol(dummy_rows(crime)), ncol(crime))

  # With dummy_indicator TRUE
  expect_equal(ncol(dummy_rows(no_dummies_needed, dummy_indicator = TRUE)),
               ncol(no_dummies_needed) + 1)
  expect_equal(ncol(dummy_rows(fastDummies_example, dummy_indicator = TRUE)),
               ncol(fastDummies_example) + 1)
  expect_equal(ncol(dummy_rows(crime, dummy_indicator = TRUE)),
               ncol(crime) + 1)
})

test_that("Number of rows is as expected", {
  expect_equal(nrow(dummy_rows(no_dummies_needed)),      4 )
  expect_equal(nrow(dummy_rows(fastDummies_example)),       8)
  expect_equal(nrow(dummy_rows(crime)),       3)
  expect_equal(nrow(dummy_rows(crime,
                               select_columns = c("city", "year"))),       4)

  # With dummy_indicator TRUE
  expect_equal(nrow(dummy_rows(no_dummies_needed, dummy_indicator = TRUE)), 4)
  expect_equal(nrow(dummy_rows(fastDummies_example, dummy_indicator = TRUE)), 8)
  expect_equal(nrow(dummy_rows(crime, dummy_indicator = TRUE)), 3)
  expect_equal(nrow(dummy_rows(crime, dummy_indicator = TRUE,
                               select_columns = c("city", "year"))), 4)


})
