#' Find NA
#'
#' Finds the positions of NA values in a vector.
#'
#' @param vector A vector.
#'
#' @return A vector of the positions of NA values in vector.
#'
#' @examples
#' find_na(c(1, NA, 2, NA))
#'
#' @export
#'
find_na <- function(vector) {
  na_positions <- which(is.na(vector))
  return(na_positions)
}

#' Replace values
#'
#' Replace values in a vector
#'
#' @param vector A vector
#' @param positions The positions to replace
#' @param replacement The values to replace with
#' @return Returns a vector with the specified values replaced
#'
#' @examples
#' replace_values(1:5, c(2,4), 0)
#' [1] 1 0 3 0 5
#'
#' @export
#'
replace_values <- function(vector, positions, replacement) {
  vector[positions] <- replacement
  return(vector)
}
