context("dummy_rows_returns right data set")

load(system.file("testdata", "fastDummies_data.rda",
                 package = "fastDummies"))

test_that("dummy_rows return expected data.frame", {
  expect_equal(dummy_rows(no_dummies_needed),
               no_dummies_needed)
  expect_equal(dummy_rows(no_dummies_needed,
                          select_columns = "animals"),
               no_dummies_needed)
  expect_equal(dummy_rows(no_dummies_needed,
                          select_columns = "food"),
               no_dummies_needed)
  expect_equal(dummy_rows(no_dummies_needed,
                          select_columns = c("animals", "food")),
               no_dummies_needed)

  expect_equal(dummy_rows(no_dummies_needed, dummy_indicator = TRUE),
               cbind(no_dummies_needed, dummy_indicator = rep(0, 4)))
  expect_equal(dummy_rows(no_dummies_needed, dummy_indicator = TRUE,
                          select_columns = "animals"),
               cbind(no_dummies_needed, dummy_indicator = rep(0, 4)))
  expect_equal(dummy_rows(no_dummies_needed, dummy_indicator = TRUE,
                          select_columns = "food"),
               cbind(no_dummies_needed, dummy_indicator = rep(0, 4)))
  expect_equal(dummy_rows(no_dummies_needed, dummy_indicator = TRUE,
                          select_columns = c("animals", "food")),
               cbind(no_dummies_needed, dummy_indicator = rep(0, 4)))


  # fastDummies_example data - FULL
  expect_equal(dummy_rows(fastDummies_example),
               fastDummies_full)
  expect_equal(dummy_rows(fastDummies_example,
                          select_columns = c("gender", "animals", "dates")),
               fastDummies_full)
  expect_equal(dummy_rows(fastDummies_example, dummy_indicator = TRUE),
               cbind(fastDummies_full, dummy_indicator = c(0,0,0,1,1,1,1,1)))
  expect_equal(dummy_rows(fastDummies_example, dummy_indicator = TRUE,
                          select_columns = c("gender", "animals", "dates")),
               cbind(fastDummies_full, dummy_indicator = c(0,0,0,1,1,1,1,1)))

  # fastDummies_example data - not full
  expect_equal(dummy_rows(fastDummies_example, select_columns = "animals"),
               fastDummies_example)
  expect_equal(dummy_rows(fastDummies_example, select_columns = "gender"),
               fastDummies_example)
  expect_equal(dummy_rows(fastDummies_example, select_columns = "dates"),
               fastDummies_example)
  expect_equal(dummy_rows(fastDummies_example, select_columns = "animals",
                          dummy_indicator = TRUE),
               cbind(fastDummies_example, dummy_indicator = rep(0, 3)))
  expect_equal(dummy_rows(fastDummies_example, select_columns = "gender",
                          dummy_indicator = TRUE),
               cbind(fastDummies_example, dummy_indicator = rep(0, 3)))
  expect_equal(dummy_rows(fastDummies_example, select_columns = "dates",
                          dummy_indicator = TRUE),
               cbind(fastDummies_example, dummy_indicator = rep(0, 3)))

  # Crime dataset
  expect_equal(dummy_rows(crime, select_columns = c("city", "year")),
                          crime_full)
  expect_equal(dummy_rows(crime),
               crime)
  expect_equal(dummy_rows(crime, select_columns = c("year", "city")),
               crime_full)
  expect_equal(dummy_rows(crime, select_columns = "city"),
               crime)
  expect_equal(dummy_rows(crime, select_columns = "year"),
               crime)




})
