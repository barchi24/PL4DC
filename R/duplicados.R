#' Detect duplicates in a data frame
#'
#' This function detects duplicated rows in a data frame based on selected
#' columns. It returns either the duplicated rows or the unique rows depending
#' on the \code{distinct} argument. It can also return only the distinct values
#' instead of the complete rows depending on the \code{value} argument.
#'
#' @param df The data frame where you want to detect duplicates.
#' @param columns A vector specifying the names or the indices of the columns
#'   where you want to detect duplicates.
#' @param value Logical indicating whether to return only the distinct values
#'   (TRUE) or the complete rows (FALSE). Default is FALSE.
#' @param distinct Logical indicating whether to return the unique rows (TRUE)
#'   instead of the duplicated rows (FALSE). Default is FALSE.
#' @param incomparables A vector of values that cannot be compared. FALSE is a
#'   special value, meaning that all values can be compared, and may be the only
#'   value accepted for methods other than the default. It will be coerced
#'   internally to the same type as df.
#' @param fromLast Logical indicating if duplication should be considered from
#'   the reverse side, i.e., the last (or rightmost) of identical elements would
#'   correspond to duplicated = FALSE.
#' @param nmax the maximum number of unique items expected (greater than one).
#'
#' @return A data frame containing either the duplicated or unique rows
#'   (depending on the \code{distinct} argument), or the duplicated or unique
#'   values (depending on the \code{value} argument).
#'
#' @note These functions aim to help improve the property
#'   \code{\link[=characteristics_properties]{Risk of Inconsistency}}.
#'
#' @seealso This function uses the \code{\link{duplicated}} function for its
#'   implementation. For more information about the parameters
#'   \code{incomparables}, \code{fromLast} and \code{nmax} see its
#'   documentation.
#'
#' @examples
#' detect_duplicates(mtcars, c("cyl", "am"), value = TRUE)
#' detect_duplicates(mtcars, c("cyl", "am"), distinct = TRUE)
#' @export
detect_duplicates <- function(df, columns, value = FALSE, distinct = FALSE,
                              incomparables = FALSE, fromLast = FALSE, nmax = NA) {
  isDuplicated <- duplicated(df[, columns], incomparables = incomparables,
                             fromLast = fromLast, nmax = nmax)

  if (distinct) {
    data <- df[!isDuplicated,]

    if (value) {
      data <- data[, columns]
    }
  } else {
    data <- df[isDuplicated,]

    if (value) {
      data <- data[!duplicated(data[, columns]), columns]
    }
  }

  return(data)
}
