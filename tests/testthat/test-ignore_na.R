context("test-ignore_na")

most_frequent <- data.frame(animal = c("dog", NA, "cat",
                                       NA, "gorilla",
                                       "gorilla"),
                            day    = c("monday", "tuesday",
                                       "wednesday", "wednesday",
                                       "friday", "saturday"),
                            hour = 1:6)

test_that("ignore-na parameter works", {
  expect_named(dummy_cols(most_frequent, select_columns = "animal"),
               c("animal", "day", "hour", "animal_dog",
                 "animal_NA", "animal_cat", "animal_gorilla"))
  expect_named(dummy_cols(most_frequent, select_columns = "animal",
                          ignore_na = TRUE),
               c("animal", "day", "hour", "animal_dog",
                 "animal_cat", "animal_gorilla"))


  expect_equal(dummy_cols(most_frequent,
                          select_columns = "animal")$animal_cat, c(0, 0, 1, 0 ,0 ,0))
  expect_equal(dummy_cols(most_frequent,
                          ignore_na = TRUE)$animal_cat, c(0, 0, 1, 0 ,0 ,0))

  expect_equal(dummy_cols(most_frequent,
                          select_columns = "animal")$animal_gorilla, c(0, 0, 0, 0, 1, 1))
  expect_equal(dummy_cols(most_frequent,
                          ignore_na = TRUE)$animal_gorilla, c(0, 0, 0, 0, 1, 1))

  expect_equal(dummy_cols(most_frequent,
                          select_columns = "animal")$animal_NA, c(0, 1, 0, 1, 0, 0))

})
