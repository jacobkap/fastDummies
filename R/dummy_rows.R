#' Fast creation of dummy rows
#'
#' @param dataset
#' data.table or data.frame
#' @param select_columns
#' If NULL, uses character, factor, and Date columns to produce categories
#' to make the dummy rows by. If not NULL, you manually enter a string or vector
#' of columns name(s).
#' @param add_columns
#' String or vector of column name(s) to add to the selected coumns. This is only
#' if you want to use all character, factor, and Date columns (selected by
#' default) and are adding additional columns of different data types.
#' @param ignore_columns
#' String or vector of column name(s) to exclude from the selected columns.
#' These excluded columns will get the same dummy value of all non-selected
#' columns
#' @param dummy_value
#' Value of the row for columns that are not selected. Default is a value of 0.
#' @param dummy_indicator
#' Adds binary column to say if row is dummy or not (i.e. included in
#' original data or not)
#'
#' @return
#' data.frame
#' @export
#'
dummy_rows <- function(dataset,
                       select_columns = NULL,
                       add_columns = NULL,
                       ignore_columns = NULL,
                       dummy_value = NA) {

  # if (!is.null(select_columns) & !all(select_columns %in% names(dataset))) {
  #   stop("Columns inputted in 'select_columns' are wrong. Please check spelling.")
  # }
  #
  #
  # if (!is.null(add_columns) & !add_columns %in% names(dataset)) {
  #   stop("Columns inputted in 'add_columns' are wrong. Please check spelling.")
  # }
  #
  # if (!is.null(select_columns) & !is.null(add_columns)) {
  #     stop(paste("select_columns and add_columns cannot both have inputs.",
  #                " Please select one."))
  # }

  dataset <- as.data.table(dataset)


  # Find the class of every column. Character columns are default used
  # to make dummy categories. If not otherwise specified, ither
  # columns are given a value of 0.
  column_classes <- sapply(dataset, class)
  char_cols <- names(dataset)[column_classes %in%
                                c("character", "factor", "Date")]


  if (!is.null(select_columns)) {
    char_cols <- select_columns
  }

  other_cols <- names(dataset)[!column_classes %in%
                                 c("character", "factor", "Date")]


  # Function to find how many unique variables are in each column
  length_unique <- function(column) { return(length(unique(column))) }

  # Finds how many possible combinations of the variables there are.
  # This will be the number of rows in the new dataset
  total_length <- prod(sapply(dataset[, char_cols, with = FALSE],
                              length_unique))
  # Makes that new dataset
  temp_table <- data.table(var1 = sort(rep(
    as.data.frame(unique(dataset[,
                                 char_cols[1], with = FALSE]))[,1],
    total_length/length(as.data.frame(unique(dataset[,
                                                     char_cols[1], with = FALSE]))[,1]))))
  names(temp_table) <- char_cols[1]
  for (i in 2:length(char_cols)) {
    temp_table[,char_cols[i] := rep(as.data.frame(unique(dataset[,
                                                                 char_cols[i], with = FALSE]))[,1],
                                    total_length/length(
                                      as.data.frame(unique(dataset[,
                                                                   char_cols[i], with = FALSE]))[,1]))]
    temp_table <- setorderv(temp_table, char_cols[i])[]
  }

  # Make the dummy column values (all non- character, factor or Date variables)
  for (i in 1:length(other_cols)) {
    temp_table[,other_cols[i] := dummy_value]
  }

  # Pasted together all columns to determine which are in original
  # dataset and removed these ones.
  dataset[, "temporary_pasting" := do.call(paste, .SD),
          .SDcols = char_cols]
  temp_table[, "temporary_pasting" := do.call(paste, .SD),
             .SDcols = char_cols]

  # Removes rows that were in original dataset
  temp_table <- temp_table[!temp_table$temporary_pasting %in%
                             dataset$temporary_pasting,]


  # Stacks new dataset on old dataset
  dataset <- rbind(dataset, temp_table)
  dataset[, "temporary_pasting" := NULL]

    return(as.data.frame(dataset))

}
