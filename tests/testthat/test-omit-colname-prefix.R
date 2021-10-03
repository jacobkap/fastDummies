sample_data <-
  structure(
    list(
      colA = c("a", "a", "a", "b", "b", "c", "c", "c",
               "c", "c"),
      colB = c(1, 1, 1, 2, 2, 3, 3, 3, 3, 3),
      colC = c(
        "val1",
        "val2",
        "val3",
        "val1",
        "val2",
        "val7",
        "val2",
        "val4",
        "val6",
        "val8"
      )
    ),
    row.names = c(NA, -10L),
    class = c("tbl_df", "tbl",
              "data.frame")
  )

test_that("omit_colname_prefix works", {
  expect_named(
    dummy_cols(
      sample_data,
      c("colC"),
      remove_selected_columns = TRUE,
      omit_colname_prefix = TRUE
    ),
    c(
      "colA",
      "colB",
      "val1",
      "val2",
      "val3",
      "val4",
      "val6",
      "val7",
      "val8"
    )
  )
})

test_that("omit_colname_prefix does not remove prefix when >1 select_columns",
          {
            expect_named(
              dummy_cols(
                sample_data,
                c("colB", "colC"),
                remove_selected_columns = TRUE,
                omit_colname_prefix = TRUE
              ),
              c(
                "colA",
                "colB_1",
                "colB_2",
                "colB_3",
                "colC_val1",
                "colC_val2",
                "colC_val3",
                "colC_val4",
                "colC_val6",
                "colC_val7",
                "colC_val8"
              )
            )
          })
