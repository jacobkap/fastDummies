#' Fast creation of dummy variables
#'
#' @param dataset
#' data.table or data.frame
#'
#' @param select_columns
#' Vector of column names that you want to create dummy variables from.
#' Default uses all character or factor columns.
#' @param ignore_columns
#' Vector of column names to ignore_ Default ignores all numeric columns.
#' @param remove_original
#' Removes the columns used to make dummy variables.
#' Columns that are not used to make dummy variables are not affected.
#' @param dummy_columns_only
#' Removes all columns that didn't create dummy columns (i_e_ numeric columns).
#' @param remove_first_dummy
#' Removes the first dummy of every variable that only n-1 Dummies remain
#' @param return_type
#' Type of data you want back_ Default is data.table (better for use
#' with large data)_ Other options are data.frame or matrix.
#' @param conditional_columns
#' Select column(s) to multiple other dummy columns created by. Useful to get
#' subcategories of data. e.g. conditional column is gender and other columns
#' are crimes. This will create columns showing the number of each crime for
#' each gender.
#'
#' @return
#' data.table, data.frame, or matrix depending on input for return_type.
#' data.table is default.
#' @export
#'
#' @examples
#' data(dummies_example)
#' example <- dummy_cols(dummies_example)
#'
#' # Return data.frame
#' example <- dummy_cols(dummies_example, return_type = "data.frame")
#'
#' # Only keep created dummy columns
#' example <- dummy_cols(dummies_example, dummy_columns_only = TRUE)
#'
#' # Only keep SEX and RACE columns
#' example <- dummy_cols(dummies_example, select_columns = c("Sex", "RACE"))
#'
#' # Keep all except SEX column
#' example <- dummy_cols(dummies_example, ignore_columns = "SEX")
#'
#' # Removes the first dummy from every category. Avoids perfect
#' # multicollinearity issues in models.
#' example <- dummy_cols(dummies_example, remove_first_dummy = TRUE)
dummy_cols <- function(dataset,
                    select_columns = NULL,
                    ignore_columns = NULL,
                    remove_original = TRUE,
                    dummy_columns_only = FALSE,
                    remove_first_dummy = FALSE,
                    conditional_columns = NULL,
                    return_type = "data.table") {

  if (!return_type %in% c("data.table", "data.frame", "matrix")) {
    stop("Return type must be 'data.table', 'data.frame', or 'matrix'")
  }

  if (!is.data.table(dataset)) {
    dataset <- as.data.table(dataset)
  }

  if (!is.null(select_columns) && !is.character(select_columns)) {
    stop("select_columns input must be characters")
  }

  if (!is.null(ignore_columns) && !is.character(ignore_columns)) {
    stop("ignore_columns input must be characters")
  }


  char_cols <- names(dataset)[sapply(dataset, class) %in%
                                c("character", "factor")]

  if (!is.null(select_columns)) {
    char_cols <- select_columns
    char_cols <- char_cols[char_cols %in% names(dataset)]
    if (length(char_cols) == 0) {
      stop("No remaining columns. Please use correct column names.")
    }
  }

  if (!is.null(ignore_columns)) {
    char_cols <- char_cols[!char_cols %in% ignore_columns]
    if (length(char_cols) == 0) {
      stop("No remaining columns. Please use correct column names.")
    }
  }

  if (dummy_columns_only) {
    to_remove <- names(dataset)[!names(dataset) %in% char_cols]
    dataset[, (to_remove) := NULL]
  }

  conditional_names <- ''
  nonconditional_names <- ''
  for (col_name in char_cols) {
    unique_vals <- unique(dataset[, get(col_name)])

    if (remove_first_dummy) {
      unique_vals = unique_vals[-1]
    }

    if (col_name %in% conditional_columns) {
      conditional_names <- c(conditional_names,
                              paste0(col_name, "_", unique_vals))
    } else {
      nonconditional_names <- c(nonconditional_names,
                             paste0(col_name, "_", unique_vals))
    }
    dataset[, (paste0(col_name, "_", unique_vals)) := 0]
    for (unique_values in unique_vals) {
      dataset[get(col_name) == unique_values,
              (paste0(col_name, "_", unique_values)) := 1]
    }
  }
  nonconditional_names <- nonconditional_names[-1]
  conditional_names <- conditional_names[-1]

  if (remove_original) {
    dataset[, (char_cols) := NULL]
  }

  if (!is.null(conditional_columns)) {
    for (conditional_cols in conditional_names) {
      for (nonconditional_columns in nonconditional_names) {
        dataset[, paste0(conditional_cols, "X", nonconditional_columns) :=
                  (get(conditional_cols) * get(nonconditional_columns))]
      }
    }
  }

  if (return_type == "data.table") {
    return(dataset)
  } else if (return_type == "data.frame") {
    return(as.data.frame(dataset))
  } else if (return_type == "matrix") {
    return(as.matrix(dataset))
  }
}

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
#' @param year
#' TRUE to include a column called year (capitalization is ignored)
#' as one of the selected columns.
#' @param return_type
#' Type of data you want back_ Default is data.table (better for use
#' with large data)_ Other option is data.frame.
#' @param dummy_indicator
#' Adds binary column to say if row is dummy or not (i.e. included in
#' original data or not)
#'
#' @return
#' data.table or data.frame depending on input for return_type.
#' data.table is default.
#' @export
#'
#' @examples
#' data(dummy_rows_example)
#'
#'# Makes dummy rows using default column selection and year
#'# to make categories
#' example <- dummy_rows(dummy_rows_example, year = TRUE)
#'
#' # Same as above but adds binary column indicating if the row
#' # is dummy or not
#' example <- dummy_rows(dummy_rows_example, year = TRUE, dummy_indicator = TRUE)
dummy_rows <- function(dataset,
                       select_columns = NULL,
                       add_columns = NULL,
                       ignore_columns = NULL,
                       dummy_value = 0,
                       year = FALSE,
                       return_type = "data.table",
                       dummy_indicator = FALSE) {

if (!return_type %in% c("data.table", "data.frame")) {
    stop("Return type must be 'data.table' or 'data.frame'")
}

if (!is.null(select_columns) && !all(select_columns) %in% names(dataset)) {
  stop("Columns inputted in 'select_columns' are wrong. Please check spelling.")
}


if (!is.null(add_columns) && !add_columns %in% names(dataset)) {
  stop("Columns inputted in 'add_columns' are wrong. Please check spelling.")
}

if (!is.null(select_columns) && !is.null(add_columns)) {
    stop(paste("select_columns and add_columns cannot both have inputs.",
               " Please select one."))
}

if (year == TRUE && !"year" %in% tolower(names(dataset))) {
  stop("year input cannot be TRUE. Column called year (ignoring casing) not found")
}


dataset <- as.data.table(dataset)

if (dummy_indicator) {dataset[, "dummy_indicator" := 0] }

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


if (year) {
  char_cols <- c(char_cols, grep("^year$", names(dataset),
                                 ignore.case = TRUE, value = TRUE))
  other_cols <- other_cols[!tolower(other_cols) %in% "year"]
}

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

if (dummy_indicator) { temp_table[, "dummy_indicator" := 1] }

# Stacks new dataset on old dataset
dataset <- rbind(dataset, temp_table)
dataset[, "temporary_pasting" := NULL]

if (return_type == "data.table") {
  return(dataset)
} else if (return_type == "data.frame") {
  return(as.data.frame(dataset))
}

}

#' United States Census data for 2015
#'
#' A dataset containing Census results from the American
#' Community Survey 2015
#'
#' @format A data frame with 100,000 rows and 17 variables:
#' \describe{
#'   \item{YEAR}{Year of the survey}
#'   \item{STATEFIP}{FIPS ID for the state}
#'   \item{COUNTYFIPS}{FIPS ID for the county}
#'   \item{OWNERSHP}{Respondent's ownership status for their home}
#'   \item{PERWT}{Survey weight for the respondent}
#'   \item{NCHILD}{Number of children in the home}
#'   \item{SEX}{Sex of the respondent}
#'   \item{AGE}{Age of the respondent}
#'   \item{MARST}{Marital status of the respondent}
#'   \item{RACE}{Race of the respondent}
#'   \item{HISPAN}{If the respondent is hispanic}
#'   \item{BPL}{Birthplace of the respondent}
#'   \item{EDUC}{Education of the respondent}
#'   \item{EMPSTAT}{Employment status of the respondent}
#'   \item{FTOTINC}{Family yearly income}
#'   \item{POVERTY}{If they are below the poverty line}
#'   \item{MOVEDIN}{When the respondent moved into their home}
#' }
#' @source \url{https://usa.ipums.org/usa-action/variables/group}
"dummies_example"


#' National Incident-Based Reporting System crime data
#'
#' A dataset crime information from the 2005-2015 NIBRS
#'
#' @format A data frame with 10,000 rows and 9 variables:
#' \describe{
#'   \item{state}{State}
#'   \item{year}{Year}
#'   \item{simple_location}{Whether the crime happened at home or not}
#'   \item{offender_used}{Drugs or alcohol offender suspected of using}
#'   \item{victim_injury}{Severity of victim's injury}
#'   \item{sexofoffender}{Sex of the offender}
#'   \item{offender_age}{Age of the offender}
#'   \item{raceofoffender}{Race of the offender}
#'   \item{spouse_assault}{Number of spousal assault crimes}
#' }
#' @source \url{http://www.icpsr.umich.edu/icpsrweb/NACJD/studies/3449}
"dummy_rows_example"
