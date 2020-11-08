context("Original Columns don't change type")

load(system.file("testdata", "fastDummies_data.rda",
                 package = "fastDummies"))

fastDummies_example_character <- fastDummies_example
fastDummies_example_character$animals <- as.character(fastDummies_example_character$animals)

test_that("Original columns keep same type", {

  expect_is(dummy_cols(fastDummies_example)$numbers, "integer")
  expect_is(dummy_cols(fastDummies_example)$animals, "factor")
  expect_is(dummy_cols(fastDummies_example_character)$animals, "character")
  expect_is(dummy_cols(fastDummies_example)$dates, "Date")
  expect_is(dummy_cols(fastDummies_example,
                       remove_first_dummy = TRUE)$numbers, "integer")
  expect_is(dummy_cols(fastDummies_example,
                       remove_first_dummy = TRUE)$animals, "factor")
  expect_is(dummy_cols(fastDummies_example,
                       remove_first_dummy = TRUE)$dates, "Date")
  expect_is(dummy_cols(c("a", "b", "c"))$x, "character")
  expect_is(dummy_cols(c(1.1, 1.2, 1.3))$x, "numeric")

})

test_that("New columns are integer", {
  expect_is(dummy_cols(fastDummies_example)$gender_male, "integer")
  expect_is(dummy_cols(fastDummies_example,
                       select_columns = "numbers")$numbers_1, "integer")
  expect_is(dummy_cols(fastDummies_example,
                       select_columns = "dates")[, "dates_2012-01-01"],
            "integer")
  expect_is(dummy_cols(c("a", "b", "c"))$x_a, "integer")
  expect_is(dummy_cols(c(1.1, 1.2, 1.3))$x_1.1, "integer")

})
