context("test-ignore_na")

na_test <- data.frame(numbers = 1:5,
                      animals = c("cat", "dog", NA, "dog", NA),
                      stringsAsFactors = FALSE)

most_frequent <- data.frame(animal = c("dog",
                                       NA,
                                       "cat",
                                       NA,
                                       "gorilla",
                                       "gorilla"),
                            day    = c("monday",
                                       "tuesday",
                                       "wednesday",
                                       "wednesday",
                                       "friday",
                                       "saturday"),
                            hour = 1:6)

test_that("ignore-na parameter works", {
  expect_named(dummy_cols(na_test),
               c("numbers",
                 "animals",
                 "animals_cat",
                 "animals_dog",
                 "animals_NA"))
  expect_named(dummy_cols(na_test, ignore_na = TRUE),
               c("numbers",
                 "animals",
                 "animals_cat",
                 "animals_dog"))


  expect_named(dummy_cols(most_frequent, select_columns = "animal"),
               c("animal",
                 "day",
                 "hour",
                 "animal_cat",
                 "animal_dog",
                 "animal_gorilla",
                 "animal_NA"))
  expect_named(dummy_cols(most_frequent, select_columns = "animal",
                          ignore_na = TRUE),
               c("animal",
                 "day",
                 "hour",
                 "animal_cat",
                 "animal_dog",
                 "animal_gorilla"))


  expect_equal(dummy_cols(most_frequent,
                          select_columns = "animal")$animal_cat,
               c(0, NA, 1, NA ,0 ,0))
  expect_equal(dummy_cols(most_frequent,
                          ignore_na = TRUE)$animal_cat,
               c(0, NA, 1, NA ,0 ,0))

  expect_equal(dummy_cols(most_frequent,
                          select_columns = "animal")$animal_gorilla,
               c(0, NA, 0, NA, 1, 1))
  expect_equal(dummy_cols(most_frequent,
                          ignore_na = TRUE)$animal_gorilla,
               c(0, NA, 0, NA, 1, 1))

  expect_equal(dummy_cols(most_frequent,
                          select_columns = "animal")$animal_NA,
               c(0, 1, 0, 1, 0, 0))


  expect_equal(dummy_cols(na_test)$animals_cat,
               c(1, 0, NA, 0, NA))
  expect_equal(dummy_cols(na_test)$animals_dog,
               c(0, 1, NA, 1, NA))
  expect_equal(dummy_cols(na_test)$animals_NA,
               c(0, 0, 1, 0, 1))

  expect_equal(dummy_cols(na_test, ignore_na = TRUE)$animals_cat,
               c(1, 0, NA, 0, NA))
  expect_equal(dummy_cols(na_test, ignore_na = TRUE)$animals_dog,
               c(0, 1, NA, 1, NA))

})
