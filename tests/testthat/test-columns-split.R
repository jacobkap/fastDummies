ID <- seq(1:4)
pets <- c("dog", "cat;dog;mouse", "dog;mouse", "cat")
df <- data.frame("ID" = ID, "pets" = pets, stringsAsFactors = FALSE)


split_test <- data.frame(
  Theory = c("Behaviourism",
             "Behaviourism, Cognitive",
             "Behaviourism, Gestalt",
             "Behaviourism, Psychodynamic",
             "Behaviourism, Psychodynamic, Cognitive"),
  Format = c("16mm",
             "16mm, 35mm",
             "16mm, 35mm, VHS",
             "16mm, 35mm, VHS",
             "35mm, VHS"))


test_that("split parameter works", {
  expect_named(dummy_cols(df, split = ";"),
               c("ID", "pets", "pets_dog", "pets_cat", "pets_mouse"))

  expect_equal(dummy_cols(df, split = ";")$pets_dog,
               c(1, 1, 1, 0))
  expect_equal(dummy_cols(df, split = ";")$pets_cat,
               c(0, 1, 0, 1))
  expect_equal(dummy_cols(df, split = ";")$pets_mouse,
               c(0, 1, 1, 0))


  expect_named(dummy_cols(split_test, split = ","),
               c("Theory",
                 "Format",
                 "Theory_Behaviourism",
                 "Theory_Cognitive",
                 "Theory_Gestalt",
                 "Theory_Psychodynamic",
                 "Format_16mm",
                 "Format_35mm",
                 "Format_VHS"))
  expect_named(dummy_cols(split_test, split = ", "),
               c("Theory",
                 "Format",
                 "Theory_Behaviourism",
                 "Theory_Cognitive",
                 "Theory_Gestalt",
                 "Theory_Psychodynamic",
                 "Format_16mm",
                 "Format_35mm",
                 "Format_VHS"))

  expect_equal(dummy_cols(split_test, split = ",")$Theory_Behaviourism,
               c(1, 1, 1, 1, 1))
  expect_equal(dummy_cols(split_test, split = ",")$Theory_Cognitive,
               c(0, 1, 0, 0, 1))
  expect_equal(dummy_cols(split_test, split = ",")$Theory_Gestalt,
               c(0, 0, 1, 0, 0))
  expect_equal(dummy_cols(split_test, split = ",")$Theory_Psychodynamic,
               c(0, 0, 0, 1, 1))
  expect_equal(dummy_cols(split_test, split = ",")$Format_16mm,
               c(1, 1, 1, 1, 0))
  expect_equal(dummy_cols(split_test, split = ",")$Format_35mm,
               c(0, 1, 1, 1, 1))
  expect_equal(dummy_cols(split_test, split = ",")$Format_VHS,
               c(0, 0, 1, 1, 1))

  expect_equal(dummy_cols(split_test, split = ", ")$Theory_Behaviourism,
               c(1, 1, 1, 1, 1))
  expect_equal(dummy_cols(split_test, split = ", ")$Theory_Cognitive,
               c(0, 1, 0, 0, 1))
  expect_equal(dummy_cols(split_test, split = ", ")$Theory_Gestalt,
               c(0, 0, 1, 0, 0))
  expect_equal(dummy_cols(split_test, split = ", ")$Theory_Psychodynamic,
               c(0, 0, 0, 1, 1))
  expect_equal(dummy_cols(split_test, split = ", ")$Format_16mm,
               c(1, 1, 1, 1, 0))
  expect_equal(dummy_cols(split_test, split = ", ")$Format_35mm,
               c(0, 1, 1, 1, 1))
  expect_equal(dummy_cols(split_test, split = ", ")$Format_VHS,
               c(0, 0, 1, 1, 1))

})
