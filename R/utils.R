check_type <- function(.data) {
  if (data.table::is.data.table(.data)) {
    data_type <- "is_data_table"
  } else if (tibble::is_tibble(.data)) {
    data_type <- "is_tibble"
  } else {
    data_type <- "is_data_frame"
  }

  return(data_type)
}

fix_data_type <- function(.data, data_type) {
  if (data_type == "is_data_frame") {
    .data <- as.data.frame(.data, stringsAsFactors = FALSE)
  } else if (data_type == "is_tibble") {
    .data <- tibble::as_tibble(.data)
  }

  return(.data)
}

.startupMessage <- function() {
  package_citation <- "Kaplan, J. & Schlegel, B. (2023). fastDummies: Fast Creation of Dummy (Binary) Columns and Rows from Categorical Variables. Version 1.7.1. URL: https://github.com/jacobkap/fastDummies, https://jacobkap.github.io/fastDummies/."
  message("Thank you for using fastDummies!")
  message("To acknowledge our work, please cite the package:")
  message(package_citation)
}
packageStartupMessage(.startupMessage())
