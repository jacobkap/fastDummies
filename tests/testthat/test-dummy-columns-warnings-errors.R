context("Checks dummy_cols for warnings and errors")

load(system.file("testdata", "dummy_cols_test.rda",
                 package = "fastDummies"))

test_that("Data input without any character or factors returns error", {
  expect_error(dummy_cols(all_nums))
  expect_error(dummy_cols(all_dates))
  expect_error(dummy_cols(all_nums_or_dates))
  expect_error(dummy_cols(multi, select_columns = "numbers"))

})

test_that("Including non-existing or non-character/factor column in
          select_columns leads to message", {
            expect_warning(dummy_cols(multi, select_columns = c("numbers", "gender")))
            expect_warning(dummy_cols(multi, select_columns = c("numbers", "animals")))
            expect_warning(dummy_cols(multi, select_columns = c("gender", "numbers", "animals")))
            expect_warning(dummy_cols(gender, select_columns = c("gender", "fake")))
            expect_warning(dummy_cols(gender, select_columns = c("fake", "gender")))
            expect_warning(dummy_cols(gender, select_columns = c("fake", "gender", "fake")))
            expect_warning(dummy_cols(animals, select_columns = c("animals", "fake")))
            expect_warning(dummy_cols(animals, select_columns = c("fake", "animals")))
            expect_warning(dummy_cols(animals, select_columns = c("fake", "animals", "fake")))
          })

test_that("Only having non-existing column in select_columns returns error", {
  expect_error(dummy_cols(multi, select_columns = "number"))
  expect_error(dummy_cols(all_nums, select_columns = "number"))
  expect_error(dummy_cols(gender, select_columns = "gen"))
  expect_error(dummy_cols(animals, select_columns = "animal"))
  expect_error(dummy_cols(animals, select_columns = "bear"))
  expect_error(dummy_cols(animals, select_columns = "dog"))

  expect_error(dummy_cols(multi, select_columns = ""))
  expect_error(dummy_cols(all_nums, select_columns = ""))
  expect_error(dummy_cols(gender, select_columns = ""))
  expect_error(dummy_cols(animals, select_columns = ""))
})

test_that("no errors or warnings", {
  expect_silent(dummy_cols(multi))
  expect_silent(dummy_cols(gender))
  expect_silent(dummy_cols(animals))
})
