context("dummy_cols returns proper dimensions")

load(system.file("testdata", "fastDummies_data.rda",
                 package = "fastDummies"))


test_that("dummy_cols returns same number of rows as inputted", {
  expect_equal(nrow(dummy_cols(no_dummies_needed)), nrow(no_dummies_needed))
  expect_equal(nrow(dummy_cols(crime)), nrow(crime))
  expect_equal(nrow(dummy_cols(fastDummies_example)),
               nrow(fastDummies_example))

  # With remove_first_dummy = TRUE
  expect_equal(nrow(dummy_cols(no_dummies_needed,
                               remove_first_dummy = TRUE)),
               nrow(no_dummies_needed))
  expect_equal(nrow(dummy_cols(crime,
                               remove_first_dummy = TRUE)), nrow(crime))
  expect_equal(nrow(dummy_cols(fastDummies_example,
                               remove_first_dummy = TRUE)),
               nrow(fastDummies_example))

  # With select_columns
  expect_equal(nrow(dummy_cols(no_dummies_needed,
                               select_columns = "animals")),
               nrow(no_dummies_needed))
  expect_equal(nrow(dummy_cols(crime,
                               select_columns = "city")), nrow(crime))
  expect_equal(nrow(dummy_cols(crime,
                               select_columns = "crime")), nrow(crime))
  expect_equal(nrow(dummy_cols(crime,
                               select_columns = c("crime", "city"))),
               nrow(crime))
  expect_equal(nrow(dummy_cols(fastDummies_example,
                               select_columns = c("numbers", "dates"))),
               nrow(fastDummies_example))
  expect_equal(nrow(dummy_cols(fastDummies_example,
                               select_columns = c("numbers", "gender"))),
               nrow(fastDummies_example))
  expect_equal(nrow(dummy_cols(fastDummies_example,
                               select_columns = "dates")),
               nrow(fastDummies_example))
})

test_that("dummy_cols returns same number of rows as inputted - vector", {
  expect_equal(nrow(dummy_cols(fastDummies_example$gender)),
               length(fastDummies_example$gender))
  expect_equal(nrow(dummy_cols(fastDummies_example$numbers)),
               length(fastDummies_example$numbers))
  expect_equal(nrow(dummy_cols(fastDummies_example$dates)),
               length(fastDummies_example$dates))
  expect_equal(nrow(dummy_cols(1:100)), 100)

  expect_equal(nrow(dummy_cols(fastDummies_example[, "gender", drop = FALSE])),
               nrow(fastDummies_example[, "gender", drop = FALSE]))
  expect_equal(nrow(dummy_cols(fastDummies_example[, "numbers", drop = FALSE])),
               nrow(fastDummies_example[, "numbers", drop = FALSE]))
  expect_equal(nrow(dummy_cols(fastDummies_example[, "dates", drop = FALSE])),
               nrow(fastDummies_example[, "dates", drop = FALSE]))

})

test_that("dummy_cols returns expected number of columns", {
  expect_equal(ncol(dummy_cols(no_dummies_needed)), 6)
  expect_equal(ncol(dummy_cols(no_dummies_needed,
                               remove_first_dummy = TRUE)), 4)
  expect_equal(ncol(dummy_cols(no_dummies_needed,
                               select_columns = "animals")), 4)
  expect_equal(ncol(dummy_cols(no_dummies_needed,
                               select_columns = "animals",
                               remove_first_dummy = TRUE)), 3)


  expect_equal(ncol(dummy_cols(crime)), 5)
  expect_equal(ncol(dummy_cols(crime,
                               remove_first_dummy = TRUE)), 4)
  expect_equal(ncol(dummy_cols(crime,
                               select_columns = "city")), 5)
  expect_equal(ncol(dummy_cols(crime,
                               select_columns = "city",
                               remove_first_dummy = TRUE)), 4)
  expect_equal(ncol(dummy_cols(crime,
                               select_columns = "year")), 5)
  expect_equal(ncol(dummy_cols(crime,
                               select_columns = "year",
                               remove_first_dummy = TRUE)), 4)
  expect_equal(ncol(dummy_cols(crime,
                               select_columns = c("city", "year"))), 7)
  expect_equal(ncol(dummy_cols(crime,
                               select_columns = c("city", "year"),
                               remove_first_dummy = TRUE)), 5)

  expect_equal(ncol(dummy_cols(fastDummies_example)), 8)
  expect_equal(ncol(dummy_cols(fastDummies_example,
                               remove_first_dummy = TRUE)), 6)
  expect_equal(ncol(dummy_cols(fastDummies_example,
                               select_columns = "gender")), 6)
  expect_equal(ncol(dummy_cols(fastDummies_example,
                               select_columns = "gender",
                               remove_first_dummy = TRUE)), 5)
  expect_equal(ncol(dummy_cols(fastDummies_example,
                               select_columns = "dates")), 6)
  expect_equal(ncol(dummy_cols(fastDummies_example,
                               select_columns = "dates",
                               remove_first_dummy = TRUE)), 5)
  expect_equal(ncol(dummy_cols(fastDummies_example,
                               select_columns =
                                 c("dates", "gender", "numbers"))), 11)
  expect_equal(ncol(dummy_cols(fastDummies_example,
                               select_columns =
                                 c("dates", "gender", "numbers"),
                               remove_first_dummy = TRUE)), 8)

})

test_that("returns expected number of columns - remove most common", {
  expect_equal(ncol(dummy_cols(no_dummies_needed,
                               remove_most_frequent_dummy = TRUE)), 4)
  expect_equal(ncol(dummy_cols(no_dummies_needed,
                               select_columns = "animals",
                               remove_most_frequent_dummy = TRUE)), 3)

  expect_equal(ncol(dummy_cols(crime,
                               remove_most_frequent_dummy = TRUE)), 4)
  expect_equal(ncol(dummy_cols(crime,
                               select_columns = "city",
                               remove_most_frequent_dummy = TRUE)), 4)
  expect_equal(ncol(dummy_cols(crime,
                               select_columns = "year",
                               remove_most_frequent_dummy = TRUE)), 4)
  expect_equal(ncol(dummy_cols(crime,
                               select_columns = c("city", "year"),
                               remove_most_frequent_dummy = TRUE)), 5)

  expect_equal(ncol(dummy_cols(fastDummies_example,
                               remove_most_frequent_dummy = TRUE)), 6)
  expect_equal(ncol(dummy_cols(fastDummies_example,
                               select_columns = "gender",
                               remove_most_frequent_dummy = TRUE)), 5)
  expect_equal(ncol(dummy_cols(fastDummies_example,
                               select_columns = "dates",
                               remove_most_frequent_dummy = TRUE)), 5)
  expect_equal(ncol(dummy_cols(fastDummies_example,
                               select_columns =
                                 c("dates", "gender", "numbers"),
                               remove_most_frequent_dummy = TRUE)), 8)

})


test_that("returns expected number of columns - remove selected columns", {
  expect_equal(ncol(dummy_cols(no_dummies_needed,
                               remove_selected_columns = TRUE)), 4)
  expect_equal(ncol(dummy_cols(no_dummies_needed,
                               select_columns = "animals",
                               remove_selected_columns = TRUE)), 3)

  expect_equal(ncol(dummy_cols(crime,
                               remove_selected_columns = TRUE)), 4)
  expect_equal(ncol(dummy_cols(crime,
                               select_columns = "city",
                               remove_selected_columns = TRUE)), 4)
  expect_equal(ncol(dummy_cols(crime,
                               select_columns = "year",
                               remove_selected_columns = TRUE)), 4)
  expect_equal(ncol(dummy_cols(crime,
                               select_columns = c("city", "year"),
                               remove_selected_columns = TRUE)), 5)

  expect_equal(ncol(dummy_cols(fastDummies_example,
                               remove_selected_columns = TRUE)), 6)
  expect_equal(ncol(dummy_cols(fastDummies_example,
                               select_columns = "gender",
                               remove_selected_columns = TRUE)), 5)
  expect_equal(ncol(dummy_cols(fastDummies_example,
                               select_columns = "dates",
                               remove_selected_columns = TRUE)), 5)
  expect_equal(ncol(dummy_cols(fastDummies_example,
                               select_columns =
                                 c("dates", "gender", "numbers"),
                               remove_selected_columns = TRUE)), 8)

})

test_that("dummy_cols returns expected number of columns - vector ", {
  expect_equal(ncol(dummy_cols(fastDummies_example$numbers)), 4)
  expect_equal(ncol(dummy_cols(fastDummies_example$animals)), 3)
  expect_equal(ncol(dummy_cols(fastDummies_example$dates)), 3)


  expect_equal(ncol(dummy_cols(fastDummies_example[, "gender", drop = FALSE])),
               3)
  expect_equal(ncol(dummy_cols(fastDummies_example[, "numbers", drop = FALSE])),
               4)
  expect_equal(ncol(dummy_cols(fastDummies_example[, "dates", drop = FALSE])),
               3)
  expect_equal(ncol(dummy_cols(1:100)), 101)
})
