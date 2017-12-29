context("Order of dummy column values are right")

load(system.file("testdata", "dummy_cols_test.rda",
                 package = "fastDummies"))

test_that("Order of dummy columns (e.g. 0,0,1,0) is right", {

  expect_equal(dummy_cols(gender)$gender_male,        c(1, 1, 1, 0))
  expect_equal(dummy_cols(gender)$gender_female,      c(0, 0, 0, 1))
  expect_equal(dummy_cols(gender, select_columns = "gender")$gender_male,     c(1, 1, 1, 0))
  expect_equal(dummy_cols(gender, select_columns = "gender")$gender_female,   c(0, 0, 0, 1))
  expect_equal(dummy_cols(gender, remove_first_dummy = TRUE)$gender_female, c(0, 0, 0, 1))

  expect_equal(dummy_cols(animals)$animals_cat,       c(1, 1, 0, 0, 0, 1, 0))
  expect_equal(dummy_cols(animals)$animals_dog,       c(0, 0, 1, 0, 0, 0, 1))
  expect_equal(dummy_cols(animals)$animals_bear,      c(0, 0, 0, 1, 1, 0, 0))
  expect_equal(dummy_cols(animals, select_columns = "animals")$animals_cat,    c(1, 1, 0, 0, 0, 1, 0))
  expect_equal(dummy_cols(animals, select_columns = "animals")$animals_dog,    c(0, 0, 1, 0, 0, 0, 1))
  expect_equal(dummy_cols(animals, select_columns = "animals")$animals_bear,   c(0, 0, 0, 1, 1, 0, 0))
  expect_equal(dummy_cols(animals, remove_first_dummy = TRUE)$animals_dog,  c(0, 0, 1, 0, 0, 0, 1))
  expect_equal(dummy_cols(animals, remove_first_dummy = TRUE)$animals_bear, c(0, 0, 0, 1, 1, 0, 0))

  expect_equal(dummy_cols(multi)$gender_male, c(1, 1, 0, 0, 1))
  expect_equal(dummy_cols(multi)$gender_female, c(0, 0, 1, 1, 0))
  expect_equal(dummy_cols(multi, select_columns = "gender")$gender_male, c(1, 1, 0, 0, 1))
  expect_equal(dummy_cols(multi, select_columns = "gender")$gender_female, c(0, 0, 1, 1, 0))
  expect_equal(dummy_cols(multi, remove_first_dummy = TRUE)$gender_female, c(0, 0, 1, 1, 0))
  expect_equal(dummy_cols(multi, select_columns = "gender",                                     remove_first_dummy = TRUE)$gender_female, c(0, 0, 1, 1, 0))

  expect_equal(dummy_cols(multi)$animals_dog, c(1, 1, 1, 0, 0))
  expect_equal(dummy_cols(multi)$animals_cat, c(0, 0, 0, 1, 0))
  expect_equal(dummy_cols(multi)$animals_bear, c(0, 0, 0, 0, 1))
  expect_equal(dummy_cols(multi, remove_first_dummy = TRUE)$animals_cat, c(0, 0, 0, 1, 0))
  expect_equal(dummy_cols(multi, remove_first_dummy = TRUE)$animals_bear, c(0, 0, 0, 0, 1))
  expect_equal(dummy_cols(multi, select_columns = "animals",                                      remove_first_dummy = TRUE)$animals_cat, c(0, 0, 0, 1, 0))
  expect_equal(dummy_cols(multi, select_columns = "animals",                                      remove_first_dummy = TRUE)$animals_bear, c(0, 0, 0, 0, 1))

})




test_that("Order of non-dummy columns is same", {
  animals_list <- factor(c("cat", "cat", "dog", "bear",
                           "bear", "cat", "dog"))
  gender_list <- factor(c("male", "male", "male", "female"))
  multi_gender_list <- factor(c("male", "male", "female",
                                "female", "male"))
  multi_animals_list <- factor(c("dog", "dog", "dog", "cat", "bear"))

  expect_equal(dummy_cols(gender)$gender,        gender_list)
  expect_equal(dummy_cols(gender, select_columns = "gender")$gender,     gender_list)
  expect_equal(dummy_cols(gender, remove_first_dummy = TRUE)$gender,   gender_list)

  expect_equal(dummy_cols(animals)$animals,        animals_list)
  expect_equal(dummy_cols(animals, select_columns = "animals")$animals,     animals_list)
  expect_equal(dummy_cols(animals, remove_first_dummy = TRUE)$animals,   animals_list)

  expect_equal(dummy_cols(multi)$numbers, multi$numbers)
  expect_equal(dummy_cols(multi, remove_first_dummy = TRUE)$numbers, multi$numbers)
  expect_equal(dummy_cols(multi, select_columns = "gender")$numbers, multi$numbers)
  expect_equal(dummy_cols(multi, select_columns = "animals")$numbers, multi$numbers)
  expect_equal(dummy_cols(multi, select_columns = "gender",                                     remove_first_dummy = TRUE)$numbers, multi$numbers)
  expect_equal(dummy_cols(multi, select_columns = "animals",                                      remove_first_dummy = TRUE)$numbers, multi$numbers)

  expect_equal(dummy_cols(multi)$gender, multi_gender_list)
  expect_equal(dummy_cols(multi, remove_first_dummy = TRUE)$gender, multi_gender_list)
  expect_equal(dummy_cols(multi, select_columns = "gender")$gender, multi_gender_list)
  expect_equal(dummy_cols(multi, select_columns = "animals")$gender, multi_gender_list)
  expect_equal(dummy_cols(multi, select_columns = "gender",                                     remove_first_dummy = TRUE)$gender, multi_gender_list)
  expect_equal(dummy_cols(multi, select_columns = "animals",                                      remove_first_dummy = TRUE)$gender, multi_gender_list)

  expect_equal(dummy_cols(multi)$animals, multi_animals_list)
  expect_equal(dummy_cols(multi, remove_first_dummy = TRUE)$animals, multi_animals_list)
  expect_equal(dummy_cols(multi, select_columns = "gender")$animals, multi_animals_list)
  expect_equal(dummy_cols(multi, select_columns = "animals")$animals, multi_animals_list)
  expect_equal(dummy_cols(multi, select_columns = "gender",                                     remove_first_dummy = TRUE)$animals, multi_animals_list)
  expect_equal(dummy_cols(multi, select_columns = "animals",                                      remove_first_dummy = TRUE)$animals, multi_animals_list)
})
