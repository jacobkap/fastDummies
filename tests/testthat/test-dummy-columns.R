context("Makes correct dummy columns")

load(system.file("testdata", "fastDummies_data.rda",
                 package = "fastDummies"))


test_that("The correct dummy columns are made - default", {
  expect_named(dummy_cols(fastDummies_example[, "gender", drop = FALSE]),
               c("gender", "gender_male", "gender_female"))

  expect_named(dummy_cols(fastDummies_example[, "animals", drop = FALSE]),
               c("animals", "animals_dog", "animals_cat"))

  expect_named(dummy_cols(fastDummies_example),
               c("numbers", "gender", "animals",
                 "dates", "gender_male", "gender_female",
                 "animals_dog", "animals_cat"))

})


test_that("The correct dummy columns are made - select_columns", {
  expect_named(dummy_cols(fastDummies_example[, "gender", drop = FALSE], select_columns = "gender"),
               c("gender", "gender_male", "gender_female"))


  expect_named(dummy_cols(fastDummies_example[, "animals", drop = FALSE]),
               c("animals", "animals_dog", "animals_cat"))

  # animal first in select_columns
  expect_named(dummy_cols(fastDummies_example, select_columns = c("animals", "gender")),
               c("numbers", "gender", "animals", "dates", "gender_male",
                 "gender_female", "animals_dog",
                 "animals_cat"))
  # gender first in select_columns
  expect_named(dummy_cols(fastDummies_example, select_columns = c("gender", "animals")),
               c("numbers", "gender", "animals", "dates", "gender_male",
                 "gender_female",
                 "animals_dog", "animals_cat"))
  expect_named(dummy_cols(fastDummies_example, select_columns = "animals"),
               c("numbers", "gender", "animals", "dates", "animals_dog",
                 "animals_cat"))
  expect_named(dummy_cols(fastDummies_example, select_columns = "gender"),
               c("numbers", "gender", "animals", "dates", "gender_male",
                 "gender_female"))

})


test_that("Remove first dummy leads to proper dummy columns being made", {
  expect_named(dummy_cols(fastDummies_example[, "gender", drop = FALSE], remove_first_dummy = TRUE),
               c("gender", "gender_female"))


  expect_named(dummy_cols(fastDummies_example[, "animals", drop = FALSE], remove_first_dummy = TRUE),
               c("animals", "animals_cat"))



  expect_named(dummy_cols(fastDummies_example, remove_first_dummy = TRUE),
               c("numbers", "gender", "animals", "dates", "gender_female",
                 "animals_cat"))
  expect_named(dummy_cols(fastDummies_example, select_columns = c("gender", "animals"),
                          remove_first_dummy = TRUE),
               c("numbers", "gender", "animals", "dates", "gender_female",
                 "animals_cat"))
  expect_named(dummy_cols(fastDummies_example, select_columns = "gender" ,
                          remove_first_dummy = TRUE),
               c("numbers", "gender",  "animals", "dates", "gender_female"))
  expect_named(dummy_cols(fastDummies_example, select_columns = "animals",
                          remove_first_dummy = TRUE),
               c("numbers", "gender", "animals", "dates",
                 "animals_cat"))
})

