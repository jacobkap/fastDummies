context("Checks dummy_rows for warnings and errors")

load(system.file("testdata", "fastDummies_data.rda",
                 package = "fastDummies"))

test_that("There are warnings or errors", {
  # One column data.frame or vector
  expect_error(dummy_rows(fastDummies_example$gender))
  expect_error(dummy_rows(fastDummies_example$dates))
  expect_error(dummy_rows(fastDummies_example$numbers))
  expect_error(dummy_rows(fastDummies_example[, "gender", drop = FALSE]))
  expect_error(dummy_rows(fastDummies_example[, "dates", drop = FALSE]))
  expect_error(dummy_rows(fastDummies_example[, "numbers", drop = FALSE]))


})
