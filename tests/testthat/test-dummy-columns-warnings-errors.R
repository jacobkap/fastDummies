context("Checks dummy_cols for warnings and errors")

load(system.file("testdata", "fastDummies_data.rda",
                 package = "fastDummies"))

test_that("Data input without any character or factors returns error", {
  expect_error(dummy_cols(fastDummies_example[, "numbers", drop = FALSE]))
  expect_error(dummy_cols(fastDummies_example[, "dates", drop = FALSE]))
  expect_error(dummy_cols(fastDummies_example[, c("numbers", "dates")]))
  expect_error(dummy_cols(fastDummies_example, select_columns = "numbers"))

})

test_that("Including non-existing or non-character/factor column in
          select_columns leads to message", {

            expect_warning(dummy_cols(fastDummies_example, select_columns = c("numbers", "gender")))
            expect_warning(dummy_cols(fastDummies_example, select_columns = c("numbers", "animals")))
            expect_warning(dummy_cols(fastDummies_example, select_columns = c("gender", "numbers", "animals")))
            expect_warning(dummy_cols(fastDummies_example[, "gender", drop = FALSE], select_columns = c("gender", "fake")))
            expect_warning(dummy_cols(fastDummies_example[, "gender", drop = FALSE], select_columns = c("fake", "gender")))
            expect_warning(dummy_cols(fastDummies_example[, "gender", drop = FALSE], select_columns = c("fake", "gender", "fake")))
          })

test_that("Only having non-existing column in select_columns returns error", {

  expect_error(dummy_cols(fastDummies_example, select_columns = "number"))
  expect_error(dummy_cols(fastDummies_example[, "numbers", drop = FALSE], select_columns = "number"))
  expect_error(dummy_cols(fastDummies_example[, "gender", drop = FALSE], select_columns = "gen"))
  expect_error(dummy_cols(fastDummies_example, select_columns = ""))
  expect_error(dummy_cols(no_dummies_needed, select_columns = ""))
  expect_error(dummy_cols(crime, select_columns = ""))
  expect_error(dummy_cols(fastDummies_example[, "gender", drop = FALSE], select_columns = ""))
})

test_that("no errors or warnings", {
  expect_silent(dummy_cols(fastDummies_example))
  expect_silent(dummy_cols(no_dummies_needed))
  expect_silent(dummy_cols(crime))
})
