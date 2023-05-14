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
#' @seealso To impute the NA values, check the function \code{\link{na_imputation}}.
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

#' Impute missing values
#'
#' This function imputes missing values in a data frame column using various
#' imputation methods. It uses the \code{\link{imputate_na}()} function from the
#' \code{\link{dlookr}} package to impute the missing values.
#'
#' @param df A data frame.
#' @param column Name or index of the column to impute missing values.
#' @param method String specifying the imputation method. Possible
#'   values are "mean", "median", "mode", "knn", "rf", and "mice".
#' @param target Target variable. Defaults to NULL.
#' @param seed An integer specifying the seed to use in mice (used only in
#'   "mice" method). Defaults to NULL.
#' @param print_flag Logical indicating if mice will print running log on
#'   console (used only when method is "mice"). Use \code{print_flag = FALSE}
#'   for silent computation. Defaults to TRUE.
#' @param no_attrs Logical indicating whether to return numerical variable or
#'   categorical variable (TRUE), or the imputation class (FALSE). Defaults to
#'   FALSE.
#'
#' @return If \code{no_attrs = FALSE}, then return imputation class. If
#'   \code{no_attrs = TRUE}, then return numerical vector or factor instead.
#'
#' @note This function aims to help improve the property
#'   \code{\link[=characteristics_properties]{Record Completeness}}.
#'
#' @seealso
#' For more information about the function, check the \code{\link{imputate_na}}
#' documentation.
#'
#' To get a visualization and/or an overview of the returned value, check the
#' \code{\link{plot_imputation}} and \code{\link{summary_imputation}} functions
#' respectively.
#'
#' To simply detect NA values, check the function \code{\link{na_detection}}.
#'
#' @examples
#' # Generate data for the example
#' heartfailure2 <- dlookr::heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 20), "platelets"] <- NA
#'
#' # Replace the missing value of the platelets variable with median
#' na_imputation(heartfailure2, "platelets", method = "median")
#' @import dlookr
#' @export
na_imputation <- function(df, column, method, target = NULL,
                          seed = NULL, print_flag = TRUE, no_attrs = FALSE) {
 return(dlookr::imputate_na(df, column, target, method, seed, print_flag, no_attrs))
}
