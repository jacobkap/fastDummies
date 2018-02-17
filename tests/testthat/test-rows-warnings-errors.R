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

  expect_error(dummy_rows(fastDummies_example_tibble$gender))
  expect_error(dummy_rows(fastDummies_example_tibble$dates))
  expect_error(dummy_rows(fastDummies_example_tibble$numbers))
  expect_error(dummy_rows(fastDummies_example_tibble[, "gender", drop = FALSE]))
  expect_error(dummy_rows(fastDummies_example_tibble[, "dates", drop = FALSE]))
  expect_error(dummy_rows(fastDummies_example_tibble[, "numbers", drop = FALSE]))

  expect_error(dummy_rows(fastDummies_example_DT$gender))
  expect_error(dummy_rows(fastDummies_example_DT$dates))
  expect_error(dummy_rows(fastDummies_example_DT$numbers))
  expect_error(dummy_rows(fastDummies_example_DT[, "gender", drop = FALSE]))
  expect_error(dummy_rows(fastDummies_example_DT[, "dates", drop = FALSE]))
  expect_error(dummy_rows(fastDummies_example_DT[, "numbers", drop = FALSE]))


})
