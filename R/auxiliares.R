#' Find NA values
#'
#' This function was made for the purpose of locating the possible NA values of
#' the vector returned by \code{\link{standardize_dates}()}. These would be
#' values that could not be parsed. Thanks to this you can access the original
#' values of the date vector and fix them manually. Once fixed,
#' \code{\link{replace}()} can be used to replace these values in the
#' resulting vector.
#'
#' @param x A vector.
#'
#' @return A vector with the positions of the NA elements of x.
#'
#' @seealso \code{\link{standardize_dates}, \link{replace}}
#'
#' @examples
#' find_na(c(1, NA, 2, NA))
#' @export
find_na <- function(x) {
  na_positions <- which(is.na(x))
  return(na_positions)
}
