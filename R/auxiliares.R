#' Find NA values
#'
#' This function was made for the purpose of locating the possible NA values of
#' the vector returned by \code{\link{standardize_dates}()}. These would be
#' values that could not be parsed. Thanks to this you can access the original
#' values of the date vector and fix them manually. Once fixed,
#' \code{\link{replace_values}()} can be used to replace these values in the
#' resulting vector.
#'
#' @param x A vector.
#'
#' @return A vector with the positions of the NA elements of x.
#'
#' @seealso \code{\link{standardize_dates}, \link{replace_values}}
#'
#' @examples
#' find_na(c(1, NA, 2, NA))
#'
#' @export
find_na <- function(x) {
  na_positions <- which(is.na(x))
  return(na_positions)
}

#' Replace values in a vector
#'
#' This function was made to replace the NA values returned by
#' standardize_dates() with the manually fixed values.
#'
#' @param x A vector.
#' @param positions The positions to replace.
#' @param replacement The values to replace with.
#'
#' @return Returns the introduced vector with the specified values replaced.
#'
#' @details The number of items to replace has to be a multiple of positions length.
#'
#' @examples
#' replace_values(1:5, c(2,4), c(0, 7))
#'
#' @export
replace_values <- function(x, positions, replacement) {
  x[positions] <- replacement
  return(x)
}
