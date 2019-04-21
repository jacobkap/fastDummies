context("Order of dummy columns are right")

load(system.file("testdata", "fastDummies_data.rda",
                 package = "fastDummies"))

test_that("Order of dummy columns is right when using sort_columns", {

  expect_equal(grep("gender_", names(dummy_cols(fastDummies_example, sort_columns = TRUE)), value = T),
               c("gender_female", "gender_male"))
  expect_equal(grep("gender_", names(dummy_cols(fastDummies_example_DT, sort_columns = TRUE)), value = T),
               c("gender_female", "gender_male"))
  expect_equal(grep("gender_", names(dummy_cols(fastDummies_example_tibble, sort_columns = TRUE)), value = T),
               c("gender_female", "gender_male"))

})
