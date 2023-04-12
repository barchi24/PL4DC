#' Check regular expressions in a character vector
#'
#' \code{check_regex} checks if a regular expression doesn't match any
#' element(s) of a given character vector. \code{check_regexl} returns a logical
#' vector indicating whether there is a match between the pattern and each
#' element of the vector.
#'
#' @param pattern a character string containing a regular expression to search for.
#' @param vector a character vector to search in.
#' @param value logical indicating whether to return the actual non-matching
#'   elements instead of their indices (default: FALSE).
#' @param ignore.case logical indicating whether to ignore case when matching
#'   the regular expression (default: FALSE).
#'
#' @return
#' \code{check_regex (value = FALSE)} returns a vector of the indices of the
#' elements of \code{vector} that did not yield a match.
#'
#' \code{check_regex (value = TRUE)} returns a character vector of the actual
#' non-matching elements of \code{vector}.
#'
#' \code{check_regexl} returns a logical vector (match or not for each element
#' of \code{vector}).
#'
#' @seealso \code{\link{regular expression}} (aka \code{\link{regexp}}) for
#'   details of the pattern specification.
#'
#' @examples
#' check_regex("[A-Za-z]+", c("Hello World", "123456", "foo", "bar 42"))
#' check_regex("[0-9]+", c("Hello World", "123456", "foo", "bar 42"), value = TRUE)
#'
#' check_regexl("[A-Za-z]+", c("Hello World", "123456", "foo", "bar 42"))
#' @export
check_regex <- function(pattern, vector, value = FALSE, ignore.case = FALSE) {
  matches <- grep(pattern, vector, ignore.case, value = value, invert = TRUE)

  return(matches)
}

#' @rdname check_regex
#' @export
check_regexl <- function(pattern, vector, ignore.case = FALSE) {
  matches <- grepl(pattern, vector, ignore.case)

  return(matches)
}

#' Examples of Common Patterns
#'
#' Examples of regular expressions of common elements to use with the functions
#' \code{\link{check_regex}} or \code{\link{check_regexl}}
#'
#' @usage data(patterns)
#'
#' patterns
#'
#' @format A data frame with 4 rows and 3 columns:
#' \describe{
#'   \item{Name}{Name of the pattern}
#'   \item{Pattern}{Regular expression used to validate the element}
#'   \item{Example}{An example of a valid value of the element}
#' }
#'
#' @examples
#' dni <- c("71684024L", "5684544A", "05331975M", "52498742", "603489758")
#' data(patterns)
#' dni_pattern <- patterns[patterns$Name == "DNI", 2]
#' check_regexl(dni_pattern, dni)
"patterns"
