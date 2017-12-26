context("Makes correct dummy columns")

load(system.file("testdata", "dummy_cols_test.rda",
                 package = "fastDummies"))


test_that("The correct dummy columns are made - default", {
  expect_named(dummy_cols(gender), c("gender", "gender_male", "gender_female"))

  expect_named(dummy_cols(animals), c("animals", "animals_cat", "animals_dog",
                                      "animals_bear"))

  expect_named(dummy_cols(multi), c("numbers", "gender", "animals",
                                    "gender_male",
                                    "gender_female",
                                    "animals_dog", "animals_cat",
                                    "animals_bear"))

})


test_that("The correct dummy columns are made - select_columns", {
  expect_named(dummy_cols(gender, select_columns = "gender"),
               c("gender", "gender_male", "gender_female"))


  expect_named(dummy_cols(animals),
               c("animals", "animals_cat", "animals_dog", "animals_bear"))

  # animal first in select_columns
  expect_named(dummy_cols(multi, select_columns = c("animals", "gender")),
               c("numbers", "gender", "animals", "gender_male",
                 "gender_female", "animals_dog",
                 "animals_cat", "animals_bear"))
  # gender first in select_columns
  expect_named(dummy_cols(multi, select_columns = c("gender", "animals")),
               c("numbers", "gender", "animals", "gender_male",
                 "gender_female",
                 "animals_dog", "animals_cat", "animals_bear"))
  expect_named(dummy_cols(multi, select_columns = "animals"),
               c("numbers", "gender", "animals", "animals_dog",
                 "animals_cat", "animals_bear"))
  expect_named(dummy_cols(multi, select_columns = "gender"),
               c("numbers", "gender", "animals", "gender_male",
                 "gender_female"))

})


test_that("Remove first dummy leads to proper dummy columns being made", {
  expect_named(dummy_cols(gender, remove_first_dummy = TRUE),
               c("gender", "gender_female"))
  expect_named(dummy_cols(gender, select_columns = "gender",
                          remove_first_dummy = TRUE),
               c("gender", "gender_female"))


  expect_named(dummy_cols(animals, remove_first_dummy = TRUE),
               c("animals", "animals_dog", "animals_bear"))
  expect_named(dummy_cols(animals, select_columns = "animals",
                          remove_first_dummy = TRUE),
               c("animals", "animals_dog", "animals_bear"))



  expect_named(dummy_cols(multi, remove_first_dummy = TRUE),
               c("numbers", "gender", "animals", "gender_female",
                 "animals_cat", "animals_bear"))
  expect_named(dummy_cols(multi, select_columns = c("gender", "animals"),
                          remove_first_dummy = TRUE),
               c("numbers", "gender", "animals", "gender_female",
                 "animals_cat", "animals_bear"))
  expect_named(dummy_cols(multi, select_columns = "gender" ,
                          remove_first_dummy = TRUE),
               c("numbers", "gender",  "animals", "gender_female"))
  expect_named(dummy_cols(multi, select_columns = "animals",
                          remove_first_dummy = TRUE),
               c("numbers", "gender", "animals",
                 "animals_cat", "animals_bear"))
})

