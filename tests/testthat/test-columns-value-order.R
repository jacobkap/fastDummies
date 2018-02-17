context("Order of dummy column values are right")

load(system.file("testdata", "fastDummies_data.rda",
                 package = "fastDummies"))

test_that("Order of dummy columns (e.g. 0,0,1,0) is right", {

  expect_equal(dummy_cols(fastDummies_example)$gender_male, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example)$gender_female, c(0, 0, 1))
  expect_equal(dummy_cols(fastDummies_example,
                          select_columns = "gender")$gender_male, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example,
                          remove_first_dummy = TRUE)$gender_female, c(0, 0, 1))
  expect_equal(dummy_cols(fastDummies_example, select_columns = "gender",
                          remove_first_dummy = TRUE)$gender_female, c(0, 0, 1))

  expect_equal(dummy_cols(fastDummies_example)$animals_dog, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example)$animals_cat, c(0, 0, 1))
  expect_equal(dummy_cols(fastDummies_example,
                          remove_first_dummy = TRUE)$animals_cat, c(0, 0, 1))
  expect_equal(dummy_cols(fastDummies_example, select_columns = "animals",
                          remove_first_dummy = TRUE)$animals_cat, c(0, 0, 1))





  expect_equal(dummy_cols(fastDummies_example_DT)$gender_male, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example_DT)$gender_female, c(0, 0, 1))
  expect_equal(dummy_cols(fastDummies_example_DT,
                          select_columns = "gender")$gender_male, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example_DT,
                          remove_first_dummy = TRUE)$gender_female, c(0, 0, 1))
  expect_equal(dummy_cols(fastDummies_example_DT, select_columns = "gender",
                          remove_first_dummy = TRUE)$gender_female, c(0, 0, 1))

  expect_equal(dummy_cols(fastDummies_example_DT)$animals_dog, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example_DT)$animals_cat, c(0, 0, 1))
  expect_equal(dummy_cols(fastDummies_example_DT,
                          remove_first_dummy = TRUE)$animals_cat, c(0, 0, 1))
  expect_equal(dummy_cols(fastDummies_example_DT, select_columns = "animals",
                          remove_first_dummy = TRUE)$animals_cat, c(0, 0, 1))





  expect_equal(dummy_cols(fastDummies_example_tibble)$gender_male, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example_tibble)$gender_female, c(0, 0, 1))
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          select_columns = "gender")$gender_male, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          remove_first_dummy = TRUE)$gender_female, c(0, 0, 1))
  expect_equal(dummy_cols(fastDummies_example_tibble, select_columns = "gender",
                          remove_first_dummy = TRUE)$gender_female, c(0, 0, 1))

  expect_equal(dummy_cols(fastDummies_example_tibble)$animals_dog, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example_tibble)$animals_cat, c(0, 0, 1))
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          remove_first_dummy = TRUE)$animals_cat, c(0, 0, 1))
  expect_equal(dummy_cols(fastDummies_example_tibble, select_columns = "animals",
                          remove_first_dummy = TRUE)$animals_cat, c(0, 0, 1))

})




test_that("Order of non-dummy columns is same", {
  gender_list <- factor(c("male", "male", "female"))
  animals_list <- factor(c("dog", "dog", "cat"))


  expect_equal(dummy_cols(fastDummies_example)$numbers,
               fastDummies_example$numbers)
  expect_equal(dummy_cols(fastDummies_example,
                          remove_first_dummy = TRUE)$numbers,
               fastDummies_example$numbers)
  expect_equal(dummy_cols(fastDummies_example,
                          select_columns = "gender")$numbers,
               fastDummies_example$numbers)
  expect_equal(dummy_cols(fastDummies_example,
                          select_columns = "animals")$numbers,
               fastDummies_example$numbers)
  expect_equal(dummy_cols(fastDummies_example, select_columns = "gender",
                          remove_first_dummy = TRUE)$numbers,
               fastDummies_example$numbers)
  expect_equal(dummy_cols(fastDummies_example, select_columns = "animals",
                          remove_first_dummy = TRUE)$numbers,
               fastDummies_example$numbers)

  expect_equal(dummy_cols(fastDummies_example)$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example,
                          remove_first_dummy = TRUE)$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example,
                          select_columns = "gender")$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example,
                          select_columns = "animals")$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example, select_columns = "gender",
                          remove_first_dummy = TRUE)$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example, select_columns = "animals",
                          remove_first_dummy = TRUE)$gender, gender_list)

  expect_equal(dummy_cols(fastDummies_example)$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example,
                          remove_first_dummy = TRUE)$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example,
                          select_columns = "gender")$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example,
                          select_columns = "animals")$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example, select_columns = "gender",
                          remove_first_dummy = TRUE)$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example, select_columns = "animals",
                          remove_first_dummy = TRUE)$animals, animals_list)





  expect_equal(dummy_cols(fastDummies_example_DT)$numbers,
               fastDummies_example_DT$numbers)
  expect_equal(dummy_cols(fastDummies_example_DT,
                          remove_first_dummy = TRUE)$numbers,
               fastDummies_example_DT$numbers)
  expect_equal(dummy_cols(fastDummies_example_DT,
                          select_columns = "gender")$numbers,
               fastDummies_example_DT$numbers)
  expect_equal(dummy_cols(fastDummies_example_DT,
                          select_columns = "animals")$numbers,
               fastDummies_example_DT$numbers)
  expect_equal(dummy_cols(fastDummies_example_DT, select_columns = "gender",
                          remove_first_dummy = TRUE)$numbers,
               fastDummies_example_DT$numbers)
  expect_equal(dummy_cols(fastDummies_example_DT, select_columns = "animals",
                          remove_first_dummy = TRUE)$numbers,
               fastDummies_example_DT$numbers)

  expect_equal(dummy_cols(fastDummies_example_DT)$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example_DT,
                          remove_first_dummy = TRUE)$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example_DT,
                          select_columns = "gender")$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example_DT,
                          select_columns = "animals")$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example_DT, select_columns = "gender",
                          remove_first_dummy = TRUE)$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example_DT, select_columns = "animals",
                          remove_first_dummy = TRUE)$gender, gender_list)

  expect_equal(dummy_cols(fastDummies_example_DT)$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example_DT,
                          remove_first_dummy = TRUE)$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example_DT,
                          select_columns = "gender")$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example_DT,
                          select_columns = "animals")$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example_DT, select_columns = "gender",
                          remove_first_dummy = TRUE)$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example_DT, select_columns = "animals",
                          remove_first_dummy = TRUE)$animals, animals_list)







  expect_equal(dummy_cols(fastDummies_example_tibble)$numbers,
               fastDummies_example_tibble$numbers)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          remove_first_dummy = TRUE)$numbers,
               fastDummies_example_tibble$numbers)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          select_columns = "gender")$numbers,
               fastDummies_example_tibble$numbers)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          select_columns = "animals")$numbers,
               fastDummies_example_tibble$numbers)
  expect_equal(dummy_cols(fastDummies_example_tibble, select_columns = "gender",
                          remove_first_dummy = TRUE)$numbers,
               fastDummies_example_tibble$numbers)
  expect_equal(dummy_cols(fastDummies_example_tibble, select_columns = "animals",
                          remove_first_dummy = TRUE)$numbers,
               fastDummies_example_tibble$numbers)

  expect_equal(dummy_cols(fastDummies_example_tibble)$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          remove_first_dummy = TRUE)$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          select_columns = "gender")$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          select_columns = "animals")$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example_tibble, select_columns = "gender",
                          remove_first_dummy = TRUE)$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example_tibble, select_columns = "animals",
                          remove_first_dummy = TRUE)$gender, gender_list)

  expect_equal(dummy_cols(fastDummies_example_tibble)$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          remove_first_dummy = TRUE)$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          select_columns = "gender")$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          select_columns = "animals")$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example_tibble, select_columns = "gender",
                          remove_first_dummy = TRUE)$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example_tibble, select_columns = "animals",
                          remove_first_dummy = TRUE)$animals, animals_list)
})
