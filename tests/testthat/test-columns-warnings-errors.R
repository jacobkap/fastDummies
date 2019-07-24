context("Checks dummy_cols for warnings and errors")

load(system.file("testdata", "fastDummies_data.rda",
                 package = "fastDummies"))

error_data <- data.frame(numbers = 1:10,
                         number2 = 11:20,
                         stringsAsFactors = FALSE)

test <- structure(list(
  Theory = structure(c(NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 1L, NA, NA, NA, NA, 1L, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 1L, 1L, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 6L, 6L, 6L, 9L, 9L, NA, 1L, 1L, NA, NA, NA, NA, NA, 1L, 1L, 6L, NA, 1L, 1L, 1L, NA, NA, 1L, 1L, NA, 2L, NA, 1L, 1L, 4L, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 1L, NA, 1L, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, NA, NA, 1L, 1L, 1L, NA, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, NA, NA, NA, NA, NA, NA, NA, NA, NA, 1L, NA, NA, NA, 1L, NA, NA, 2L, NA, NA, NA, NA, 9L, 9L, 1L, 1L, 1L, 6L, 6L, 1L, 1L, NA, 1L, 1L, 1L, 1L, 1L, 1L, 1L, NA, NA, NA, NA, NA, 1L, 1L, 1L, 8L, 1L, NA, 6L, 1L, 1L, 1L, NA, NA, NA, NA, NA, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 1L, 1L, 1L, NA, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 1L, 1L, 1L, 1L, NA, 1L, 8L, NA, 8L, 8L, NA, NA, NA, NA, 2L, 1L, 2L, 10L, 1L, 1L, 1L, 1L, 1L, NA, NA, NA, 6L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 6L, NA, NA, NA, NA, NA, NA, 1L, NA, 9L, NA, NA, NA, 1L, 1L, 1L, 1L, NA, NA, NA, NA, NA, NA, NA, NA, NA, 1L, NA, 1L, NA, 1L, NA, 1L, 1L, 1L, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 1L, 1L, NA, 9L, 9L, 9L, 9L, 9L, 9L, 1L, 1L, 1L, 1L, 2L, NA, NA, NA, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 6L, 6L, 6L, 6L, 6L, 7L, NA, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, NA, 1L, 1L, NA, 1L, 1L, 1L, 1L, 1L), .Label = c("Behaviourism", "Behaviourism, Cognitive", "Behaviourism, Gestalt", "Behaviourism, Psychodynamic", "Behaviourism, Psychodynamic, Cognitive", "Cognitive", "Functionalism", "Gestalt", "Psychodynamic", "Structuralism"), class = "factor"),
  Format = structure(c(1L, 1L, 24L, 1L, 1L, 1L, 1L, 2L, 1L, 10L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 1L, 2L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 12L, 1L, 1L, 2L, 1L, 1L, 19L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 6L, 1L, 1L, 1L, 1L, 3L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 1L, 1L, 1L, 12L, 1L, 1L, 1L, 5L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 11L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 15L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 13L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 7L, 12L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 8L, 1L, 1L, 1L, 1L, 1L, 5L, 1L, 1L, 1L, 1L, 7L, 1L, 1L, 15L, 1L, 5L, 25L, 5L, 24L, 2L, 2L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 15L, 1L, 1L, 1L, 1L, 20L, 1L, 18L, 12L, 1L, 1L, NA, 20L, 20L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 25L, 15L, 16L, 15L, 15L, 1L, 1L, 1L, 1L, 19L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 12L, 12L, 5L, 5L, 1L, 2L, 1L, 1L, 1L, 1L, 1L, 14L, 1L, 1L, 1L, 1L, 14L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 15L, 12L, NA, 15L, 1L, NA, NA, 1L, 1L, 6L, 1L, 1L, 1L, 1L, 14L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 12L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L, 1L, 22L, 1L, 21L, 23L, 5L, 1L, 1L, 1L, 1L, 10L, 1L, 1L, 1L, 1L, 5L, 17L, 1L, 17L, 6L, 1L, 1L, 9L, 1L, 1L, 1L, 1L, 1L, 1L, 2L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 12L, 1L, 18L, 1L, 21L, 18L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 5L, 12L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 24L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 6L, 1L, 1L, 1L, 1L, 1L, 4L, 1L, 1L, 1L), .Label = c("16mm", "16mm, 35mm", "16mm, 35mm, VHS", "16mm, AVI", "16mm, Digital", "16mm, DVD", "16mm, DVD, Betacam SP", "16mm, DVD, Digital, Betacam SP", "16mm, DVD, Mini-DV", "16mm, MP4", "16mm, MPG", "16mm, VHS", "16mm, VHS, AVI", "16mm, VHS, Digital", "16mm, VHS, DVD", "16mm, VHS, DVD, Digital, AVI", "35mm", "8mm", "8mm, 16mm", "DVD", "DVD, AVI", "Mini-DV", "MPG", "VHS", "VHS, DVD, Digital"), class = "factor")),
  .Names = c("Theory", "Format"), row.names = c(NA, -427L),
  class = c("tbl_df", "tbl", "data.frame"))


test_that("Error on stop conditions", {

  expect_error(dummy_cols(error_data))
  expect_error(dummy_cols(error_data), paste0("No character or factor columns found. ",
               "Please use select_columns to choose columns."))
})

test_that("Including non-existing in
          select_columns leads to warning", {

            expect_warning(dummy_cols(fastDummies_example[, "gender",
                                                          drop = FALSE],
                                      select_columns = c("gender", "fake")))
            expect_warning(dummy_cols(fastDummies_example[, "gender",
                                                          drop = FALSE],
                                      select_columns = c("fake", "gender")))
            expect_warning(dummy_cols(fastDummies_example[, "gender",
                                                          drop = FALSE],
                                      select_columns = c("fake", "gender",
                                                         "fake")))
          })

test_that("Only having non-existing column in select_columns returns error", {

  expect_error(dummy_cols(fastDummies_example, select_columns = "number"))
  expect_error(dummy_cols(fastDummies_example[, "numbers", drop = FALSE],
                          select_columns = "number"))
  expect_error(dummy_cols(fastDummies_example[, "gender", drop = FALSE],
                          select_columns = "gen"))
  expect_error(dummy_cols(fastDummies_example, select_columns = ""))
  expect_error(dummy_cols(no_dummies_needed, select_columns = ""))
  expect_error(dummy_cols(crime, select_columns = ""))
  expect_error(dummy_cols(fastDummies_example[, "gender", drop = FALSE],
                          select_columns = ""))
})

test_that("no errors or warnings", {
  expect_silent(dummy_cols(fastDummies_example))
  expect_silent(dummy_cols(no_dummies_needed))
  expect_silent(dummy_cols(no_dummies_needed_DT))
  expect_silent(dummy_cols(no_dummies_needed_tibble))
  expect_silent(dummy_cols(crime))
  expect_silent(dummy_cols(crime_full))
  expect_silent(dummy_cols(crime_DT))
  expect_silent(dummy_cols(crime_full_DT))
  expect_silent(dummy_cols(crime_tibble))
  expect_silent(dummy_cols(crime_full_tibble))
  expect_silent(dummy_cols(fastDummies_example))
  expect_silent(dummy_cols(fastDummies_example_DT))
  expect_silent(dummy_cols(fastDummies_example_tibble))
  expect_silent(dummy_cols(fastDummies_full))
  expect_silent(dummy_cols(fastDummies_full_DT))
  expect_silent(dummy_cols(fastDummies_full_tibble))

  expect_silent(dummy_cols(test, select_columns = "Theory", split = ", "))
  expect_silent(dummy_cols(test, select_columns = "Theory", split = ","))
})

test_that("error if both remove options are true", {
  expect_error(dummy_cols(no_dummies_needed,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(no_dummies_needed_DT,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(no_dummies_needed_tibble,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(crime,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(crime_full,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(crime_DT,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(crime_full_DT,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(crime_tibble,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(crime_full_tibble,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(fastDummies_example,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(fastDummies_example_DT,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(fastDummies_example_tibble,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(fastDummies_full,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(fastDummies_full_DT,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
  expect_error(dummy_cols(fastDummies_full_tibble,
                          remove_first_dummy = TRUE,
                          remove_most_frequent_dummy = TRUE))
})
