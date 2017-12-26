context("Order of dummy column values are right")

load(system.file("testdata", "dummy_cols_test.rda",
                 package = "fastDummies"))

gender_all <- dummy_cols(gender)
gender_select <- dummy_cols(gender, select_columns = "gender")
gender_rm_first <- dummy_cols(gender, remove_first_dummy = TRUE)
animals_all <- dummy_cols(animals)
animals_select <- dummy_cols(animals, select_columns = "animals")
animals_rm_first <- dummy_cols(animals, remove_first_dummy = TRUE)

multi_all <- dummy_cols(multi)
multi_rm_first <- dummy_cols(multi, remove_first_dummy = TRUE)
multi_gender <- dummy_cols(multi, select_columns = "gender")
multi_animals <- dummy_cols(multi, select_columns = "animals")
multi_gender_rm_first <- dummy_cols(multi, select_columns = "gender",
                                    remove_first_dummy = TRUE)
multi_animals_rm_first <- dummy_cols(multi, select_columns = "animals",
                                     remove_first_dummy = TRUE)

test_that("Order of dummy columns (e.g. 0,0,1,0) is right", {

  expect_equal(gender_all$gender_male,        c(1, 1, 1, 0))
  expect_equal(gender_all$gender_female,      c(0, 0, 0, 1))
  expect_equal(gender_select$gender_male,     c(1, 1, 1, 0))
  expect_equal(gender_select$gender_female,   c(0, 0, 0, 1))
  expect_equal(gender_rm_first$gender_female, c(0, 0, 0, 1))

  expect_equal(animals_all$animals_cat,       c(1, 1, 0, 0, 0, 1, 0))
  expect_equal(animals_all$animals_dog,       c(0, 0, 1, 0, 0, 0, 1))
  expect_equal(animals_all$animals_bear,      c(0, 0, 0, 1, 1, 0, 0))
  expect_equal(animals_select$animals_cat,    c(1, 1, 0, 0, 0, 1, 0))
  expect_equal(animals_select$animals_dog,    c(0, 0, 1, 0, 0, 0, 1))
  expect_equal(animals_select$animals_bear,   c(0, 0, 0, 1, 1, 0, 0))
  expect_equal(animals_rm_first$animals_dog,  c(0, 0, 1, 0, 0, 0, 1))
  expect_equal(animals_rm_first$animals_bear, c(0, 0, 0, 1, 1, 0, 0))

  expect_equal(multi_all$gender_male, c(1, 1, 0, 0, 1))
  expect_equal(multi_all$gender_female, c(0, 0, 1, 1, 0))
  expect_equal(multi_gender$gender_male, c(1, 1, 0, 0, 1))
  expect_equal(multi_gender$gender_female, c(0, 0, 1, 1, 0))
  expect_equal(multi_rm_first$gender_female, c(0, 0, 1, 1, 0))
  expect_equal(multi_gender_rm_first$gender_female, c(0, 0, 1, 1, 0))

  expect_equal(multi_all$animals_dog, c(1, 1, 1, 0, 0))
  expect_equal(multi_all$animals_cat, c(0, 0, 0, 1, 0))
  expect_equal(multi_all$animals_bear, c(0, 0, 0, 0, 1))
  expect_equal(multi_rm_first$animals_cat, c(0, 0, 0, 1, 0))
  expect_equal(multi_rm_first$animals_bear, c(0, 0, 0, 0, 1))
  expect_equal(multi_animals_rm_first$animals_cat, c(0, 0, 0, 1, 0))
  expect_equal(multi_animals_rm_first$animals_bear, c(0, 0, 0, 0, 1))

})




test_that("Order of non-dummy columns is same", {
  animals_list <- factor(c("cat", "cat", "dog", "bear",
                           "bear", "cat", "dog"))
  gender_list <- factor(c("male", "male", "male", "female"))
  multi_gender_list <- factor(c("male", "male", "female",
                                "female", "male"))
  multi_animals_list <- factor(c("dog", "dog", "dog", "cat", "bear"))

  expect_equal(gender_all$gender,        gender_list)
  expect_equal(gender_select$gender,     gender_list)
  expect_equal(gender_rm_first$gender,   gender_list)

  expect_equal(animals_all$animals,        animals_list)
  expect_equal(animals_select$animals,     animals_list)
  expect_equal(animals_rm_first$animals,   animals_list)

  expect_equal(multi_all$numbers, multi$numbers)
  expect_equal(multi_rm_first$numbers, multi$numbers)
  expect_equal(multi_gender$numbers, multi$numbers)
  expect_equal(multi_animals$numbers, multi$numbers)
  expect_equal(multi_gender_rm_first$numbers, multi$numbers)
  expect_equal(multi_animals_rm_first$numbers, multi$numbers)

  expect_equal(multi_all$gender, multi_gender_list)
  expect_equal(multi_rm_first$gender, multi_gender_list)
  expect_equal(multi_gender$gender, multi_gender_list)
  expect_equal(multi_animals$gender, multi_gender_list)
  expect_equal(multi_gender_rm_first$gender, multi_gender_list)
  expect_equal(multi_animals_rm_first$gender, multi_gender_list)

  expect_equal(multi_all$animals, multi_animals_list)
  expect_equal(multi_rm_first$animals, multi_animals_list)
  expect_equal(multi_gender$animals, multi_animals_list)
  expect_equal(multi_animals$animals, multi_animals_list)
  expect_equal(multi_gender_rm_first$animals, multi_animals_list)
  expect_equal(multi_animals_rm_first$animals, multi_animals_list)
})
