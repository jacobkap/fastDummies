context("Makes correct dummy columns")

load(system.file("testdata", "fastDummies_data.rda",
                 package = "fastDummies"))
most_frequent <- data.frame(animal = c("dog",
                                       "cat",
                                       "cat",
                                       "gorilla",
                                       "gorilla",
                                       "gorilla"),
                            day    = c("monday",
                                       "tuesday",
                                       "wednesday",
                                       "wednesday",
                                       "friday",
                                       "saturday"),
                            hour = 1:6)

sort_order_example <- data.frame(numbers = 1:12,
                                 month = c("February",
                                           "January",
                                           "March",
                                           "July",
                                           "June",
                                           "May",
                                           "April",
                                           "August",
                                           "October",
                                           "September",
                                           "December",
                                           "November"))
sort_order_example$month <- factor(sort_order_example$month,
                                   levels = as.character(sort_order_example$month))


sort_order_example2       <- sort_order_example
sort_order_example2$month <- as.character(sort_order_example2$month)

fastDummies_example2         <- fastDummies_example
fastDummies_example2$gender  <- as.character(fastDummies_example2$gender)
fastDummies_example2$animals <- as.character(fastDummies_example2$animals)


test_that("The correct dummy columns are made - default", {
  expect_named(dummy_cols(sort_order_example),
               c("numbers",
                 "month",
                 "month_February",
                 "month_January",
                 "month_March",
                 "month_July",
                 "month_June",
                 "month_May",
                 "month_April",
                 "month_August",
                 "month_October",
                 "month_September",
                 "month_December",
                 "month_November"))

  expect_named(dummy_cols(c("a", "b")),
               c("x",
                 "x_a",
                 "x_b"))

  expect_named(dummy_cols(1:2),
               c("x",
                 "x_1",
                 "x_2"))

  expect_named(dummy_cols(sort_order_example2),
               c("numbers",
                 "month",
                 "month_April",
                 "month_August",
                 "month_December",
                 "month_February",
                 "month_January",
                 "month_July",
                 "month_June",
                 "month_March",
                 "month_May",
                 "month_November",
                 "month_October",
                 "month_September"))


  expect_named(dummy_cols(fastDummies_example),
               c("numbers",
                 "gender",
                 "animals",
                 "dates",
                 "gender_female",
                 "gender_male",
                 "animals_cat",
                 "animals_dog"))
  expect_named(dummy_cols(fastDummies_example2),
               c("numbers",
                 "gender",
                 "animals",
                 "dates",
                 "gender_female",
                 "gender_male",
                 "animals_cat",
                 "animals_dog"))


  expect_named(dummy_cols(fastDummies_example[, "gender", drop = FALSE]),
               c("gender",
                 "gender_female",
                 "gender_male"))

  expect_named(dummy_cols(fastDummies_example[, "animals", drop = FALSE]),
               c("animals",
                 "animals_cat",
                 "animals_dog"))

  expect_named(dummy_cols(fastDummies_example2[, "gender", drop = FALSE]),
               c("gender",
                 "gender_female",
                 "gender_male"))

  expect_named(dummy_cols(fastDummies_example2[, "animals", drop = FALSE]),
               c("animals",
                 "animals_cat",
                 "animals_dog"))



  expect_named(dummy_cols(fastDummies_example[, "numbers", drop = FALSE]),
               c("numbers",
                 "numbers_1",
                 "numbers_2",
                 "numbers_3"))


})


test_that("The correct dummy columns are made - select_columns", {
  expect_named(dummy_cols(fastDummies_example[, "gender", drop = FALSE],
                          select_columns = "gender"),
               c("gender",
                 "gender_female",
                 "gender_male"))



  expect_named(dummy_cols(fastDummies_example, select_columns = "numbers"),
               c("numbers",
                 "gender",
                 "animals",
                 "dates",
                 "numbers_1",
                 "numbers_2",
                 "numbers_3"))


  expect_named(dummy_cols(fastDummies_example[, "animals", drop = FALSE]),
               c("animals",
                 "animals_cat",
                 "animals_dog"))

  # animal first in select_columns
  expect_named(dummy_cols(fastDummies_example, select_columns = c("animals",
                                                                  "gender")),
               c("numbers",
                 "gender",
                 "animals",
                 "dates",
                 "animals_cat",
                 "animals_dog",
                 "gender_female",
                 "gender_male"))

  # gender first in select_columns
  expect_named(dummy_cols(fastDummies_example,
                          select_columns = c("gender", "animals")),
               c("numbers",
                 "gender",
                 "animals",
                 "dates",
                 "gender_female",
                 "gender_male",
                 "animals_cat",
                 "animals_dog"))
  expect_named(dummy_cols(fastDummies_example, select_columns = "animals"),
               c("numbers",
                 "gender",
                 "animals",
                 "dates",
                 "animals_cat",
                 "animals_dog"))
  expect_named(dummy_cols(fastDummies_example, select_columns = "gender"),
               c("numbers",
                 "gender",
                 "animals",
                 "dates",
                 "gender_female",
                 "gender_male"))

  expect_named(dummy_cols(fastDummies_example,
                          select_columns = c("gender", "numbers")),
               c("numbers",
                 "gender",
                 "animals",
                 "dates",
                 "gender_female",
                 "gender_male",
                 "numbers_1",
                 "numbers_2",
                 "numbers_3"))

})


test_that("Remove first dummy leads to proper dummy columns being made", {
  expect_named(dummy_cols(fastDummies_example[, "gender", drop = FALSE],
                          remove_first_dummy = TRUE),
               c("gender",
                 "gender_male"))

  expect_named(dummy_cols(fastDummies_example[, "numbers", drop = FALSE],
                          remove_first_dummy = TRUE),
               c("numbers",
                 "numbers_2",
                 "numbers_3"))


  expect_named(dummy_cols(fastDummies_example[, "animals", drop = FALSE],
                          remove_first_dummy = TRUE),
               c("animals",
                 "animals_dog"))



  expect_named(dummy_cols(fastDummies_example, remove_first_dummy = TRUE),
               c("numbers",
                 "gender",
                 "animals",
                 "dates",
                 "gender_male",
                 "animals_dog"))
  expect_named(dummy_cols(fastDummies_example, select_columns = c("gender",
                                                                  "animals"),
                          remove_first_dummy = TRUE),
               c("numbers",
                 "gender",
                 "animals",
                 "dates",
                 "gender_male",
                 "animals_dog"))
  expect_named(dummy_cols(fastDummies_example, select_columns = "gender",
                          remove_first_dummy = TRUE),
               c("numbers",
                 "gender",
                 "animals",
                 "dates",
                 "gender_male"))
  expect_named(dummy_cols(fastDummies_example, select_columns = "animals",
                          remove_first_dummy = TRUE),
               c("numbers",
                 "gender",
                 "animals",
                 "dates",
                 "animals_dog"))

  expect_named(dummy_cols(fastDummies_example, select_columns = "numbers",
                          remove_first_dummy = TRUE),
               c("numbers",
                 "gender",
                 "animals",
                 "dates",
                 "numbers_2",
                 "numbers_3"))
  expect_named(dummy_cols(fastDummies_example,
                          select_columns = c("animals", "numbers"),
                          remove_first_dummy = TRUE),
               c("numbers",
                 "gender",
                 "animals",
                 "dates",
                 "animals_dog",
                 "numbers_2",
                 "numbers_3"))
})

test_that("remove_most_frequent_dummy works", {
  expect_named(dummy_cols(.data = data.frame(X = as.factor(c("a", "b", "b", "c", "c"))),
                          remove_most_frequent_dummy = TRUE),
               c("X",
                 "X_a",
                 "X_c"))

  expect_named(dummy_cols(most_frequent, remove_most_frequent_dummy = TRUE),
               c("animal",
                 "day",
                 "hour",
                 "animal_cat",
                 "animal_dog",
                 "day_friday",
                 "day_monday",
                 "day_saturday",
                 "day_tuesday"))
  expect_named(dummy_cols(most_frequent, select_columns = c("animal", "day"),
                          remove_most_frequent_dummy = TRUE),
               c("animal",
                 "day",
                 "hour",
                 "animal_cat",
                 "animal_dog",
                 "day_friday",
                 "day_monday",
                 "day_saturday",
                 "day_tuesday"))
  expect_named(dummy_cols(most_frequent, select_columns = "animal",
                          remove_most_frequent_dummy = TRUE),
               c("animal",
                 "day",
                 "hour",
                 "animal_cat",
                 "animal_dog"))
  expect_named(dummy_cols(most_frequent, select_columns = "day",
                          remove_most_frequent_dummy = TRUE),
               c("animal",
                 "day",
                 "hour",
                 "day_friday",
                 "day_monday",
                 "day_saturday",
                 "day_tuesday"))
  expect_named(dummy_cols(most_frequent, select_columns = "hour",
                          remove_most_frequent_dummy = TRUE),
               c("animal",
                 "day",
                 "hour",
                 "hour_2",
                 "hour_3",
                 "hour_4",
                 "hour_5",
                 "hour_6"))

})


test_that("remove_selected_columns works", {
  expect_named(dummy_cols(most_frequent, remove_selected_columns = TRUE),
               c("hour",
                 "animal_cat",
                 "animal_dog",
                 "animal_gorilla",
                 "day_friday",
                 "day_monday",
                 "day_saturday",
                 "day_tuesday",
                 "day_wednesday"))
  expect_named(dummy_cols(most_frequent, select_columns = c("animal", "day"),
                          remove_selected_columns = TRUE),
               c("hour",
                 "animal_cat",
                 "animal_dog",
                 "animal_gorilla",
                 "day_friday",
                 "day_monday",
                 "day_saturday",
                 "day_tuesday",
                 "day_wednesday"))
  expect_named(dummy_cols(most_frequent, select_columns = "animal",
                          remove_selected_columns = TRUE),
               c("day",
                 "hour",
                 "animal_cat",
                 "animal_dog",
                 "animal_gorilla"))
  expect_named(dummy_cols(most_frequent, select_columns = "day",
                          remove_selected_columns = TRUE),
               c("animal",
                 "hour",
                 "day_friday",
                 "day_monday",
                 "day_saturday",
                 "day_tuesday",
                 "day_wednesday"))
  expect_named(dummy_cols(most_frequent, select_columns = "hour",
                          remove_selected_columns = TRUE),
               c( "animal",
                  "day",
                  "hour_1",
                  "hour_2",
                  "hour_3",
                  "hour_4",
                  "hour_5",
                  "hour_6"))

})
