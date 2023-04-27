#' Detect rows with missing values in a data set
#'
#' This function takes a data set and a vector with the indices of the columns
#' to be checked for missing values. It returns a vector with the indices of the
#' rows that have at least one missing value in any of the specified columns.
#'
#' @param data The data set on which to detect missing values.
#' @param columns A vector with the indices of the columns to be checked.
#'
#' @return A vector with the indices of the rows that have missing values in the
#'   specified columns.
#'
#' @note This function aims to help improve the property
#'   \code{\link[=characteristics_properties]{Record Completeness}}.
#'
#' @examples
#' # Example data frame
#' users <- data.frame(idUser = c(1, 2, NA, 4, 5),
#'                     name = c("Mario", "Ismael", "Fernando", "Gregorio", "John"),
#'                     tfno = c("602364787", NA, "603157489", "650879511", NA))
#' users
#'
#' # We obtain the indexes of the rows containing any nulls in the idUser or tfno columns
#' na_rows <- na_detection(users, c(1, 3))
#'
#' # We create a data frame with only the valid records
#' valid_rows <- users[-na_rows,]
#' valid_rows
#'
#' # We create a data frame with only the invalid records
#' invalid_rows <- users[na_rows,]
#' invalid_rows
#' @export
na_detection <- function(data, columns) {
  na_values <- is.na(data[, columns])

  if (is.vector(na_values)) {
    na_values <- matrix(na_values, ncol = 1)
  }

  na_rows <- apply(na_values, 1, any)

  return(which(na_rows))
}
