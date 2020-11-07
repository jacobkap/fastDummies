context("Order of dummy column values are right")

load(system.file("testdata", "fastDummies_data.rda",
                 package = "fastDummies"))

split_example <- data.frame(owner = 1:4,
                            pets = c("dog", "dog, cat, hamster", "cat",
                                     "hamster"), stringsAsFactors = FALSE)
numeric_order <- data.frame(photos = c(1, 5, 7, 2, 40, 23, 12, 6, 1))

test_that("Order of dummy columns (e.g. 0,0,1,0) is right", {


  expect_equal(dummy_cols(1:3)$x_1, c(1, 0, 0))
  expect_equal(dummy_cols(1:3)$x_2, c(0, 1, 0))
  expect_equal(dummy_cols(1:3)$x_3, c(0, 0, 1))

  expect_equal(dummy_cols(c("a", "b", "c"))$x_a, c(1, 0, 0))
  expect_equal(dummy_cols(c("a", "b", "c"))$x_b, c(0, 1, 0))
  expect_equal(dummy_cols(c("a", "b", "c"))$x_c, c(0, 0, 1))

  expect_equal(dummy_cols(fastDummies_example)$gender_female, c(0, 0, 1))
  expect_equal(dummy_cols(fastDummies_example)$gender_male, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example)$gender_female, c(0, 0, 1))
  expect_equal(dummy_cols(fastDummies_example,
                          select_columns = "gender")$gender_male, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example,
                          remove_first_dummy = TRUE)$gender_male, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example, select_columns = "gender",
                          remove_first_dummy = TRUE)$gender_male, c(1, 1, 0))

  expect_equal(dummy_cols(fastDummies_example)$animals_dog, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example)$animals_cat, c(0, 0, 1))
  expect_equal(dummy_cols(fastDummies_example,
                          remove_first_dummy = TRUE)$animals_dog, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example, select_columns = "animals",
                          remove_first_dummy = TRUE)$animals_dog, c(1, 1, 0))

  expect_named(dummy_cols(numeric_order), c("photos",
                                            "photos_1",
                                            "photos_2",
                                            "photos_5",
                                            "photos_6",
                                            "photos_7",
                                            "photos_12",
                                            "photos_23",
                                            "photos_40"))


  # Splitter test
  expect_equal(dummy_cols(split_example, split = ",")$pets_dog, c(1, 1, 0, 0))
  expect_equal(dummy_cols(split_example, split = ",")$pets_cat, c(0, 1, 1, 0))
  expect_equal(dummy_cols(split_example, split = ",")$pets_hamster, c(0, 1, 0, 1))


  expect_equal(dummy_cols(fastDummies_example_DT)$gender_male, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example_DT)$gender_female, c(0, 0, 1))
  expect_equal(dummy_cols(fastDummies_example_DT,
                          select_columns = "gender")$gender_male, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example_DT,
                          remove_first_dummy = TRUE)$gender_male, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example_DT, select_columns = "gender",
                          remove_first_dummy = TRUE)$gender_male, c(1, 1, 0))

  expect_equal(dummy_cols(fastDummies_example_DT)$animals_dog, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example_DT)$animals_cat, c(0, 0, 1))
  expect_equal(dummy_cols(fastDummies_example_DT,
                          remove_first_dummy = TRUE)$animals_dog, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example_DT, select_columns = "animals",
                          remove_first_dummy = TRUE)$animals_dog, c(1, 1, 0))





  expect_equal(dummy_cols(fastDummies_example_tibble)$gender_male, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example_tibble)$gender_female, c(0, 0, 1))
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          select_columns = "gender")$gender_male, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          remove_first_dummy = TRUE)$gender_male, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example_tibble, select_columns = "gender",
                          remove_first_dummy = TRUE)$gender_male, c(1, 1, 0))

  expect_equal(dummy_cols(fastDummies_example_tibble)$animals_dog, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example_tibble)$animals_cat, c(0, 0, 1))
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          remove_first_dummy = TRUE)$animals_dog, c(1, 1, 0))
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          select_columns = "animals",
                          remove_first_dummy = TRUE)$animals_dog, c(1, 1, 0))

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
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          select_columns = "gender",
                          remove_first_dummy = TRUE)$numbers,
               fastDummies_example_tibble$numbers)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          select_columns = "animals",
                          remove_first_dummy = TRUE)$numbers,
               fastDummies_example_tibble$numbers)

  expect_equal(dummy_cols(fastDummies_example_tibble)$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          remove_first_dummy = TRUE)$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          select_columns = "gender")$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          select_columns = "animals")$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          select_columns = "gender",
                          remove_first_dummy = TRUE)$gender, gender_list)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          select_columns = "animals",
                          remove_first_dummy = TRUE)$gender, gender_list)

  expect_equal(dummy_cols(fastDummies_example_tibble)$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          remove_first_dummy = TRUE)$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          select_columns = "gender")$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          select_columns = "animals")$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          select_columns = "gender",
                          remove_first_dummy = TRUE)$animals, animals_list)
  expect_equal(dummy_cols(fastDummies_example_tibble,
                          select_columns = "animals",
                          remove_first_dummy = TRUE)$animals, animals_list)
})
