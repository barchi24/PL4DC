#' Check regular expressions in a character vector
#'
#' \code{check_regex} checks if a regular expression doesn't match any
#' element(s) of a given character vector. \code{check_regexl} returns a logical
#' vector indicating whether there is a match between the pattern and each
#' element of the vector.
#'
#' @param pattern A character string containing a regular expression to search for.
#' @param vector A character vector to search in.
#' @param value Logical indicating whether to return the actual non-matching
#'   elements instead of their indices (default: FALSE).
#' @param ignore.case Logical indicating whether to ignore case when matching
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
#' @note These functions aim to help improve the property
#'   \code{\link[=characteristics_properties]{Syntactic Accuracy}}.
#'
#' @seealso
#' \code{\link{regular expression}} (aka \code{\link{regexp}}) for details of
#' the pattern specification.
#'
#' Examples of patterns for common elements in the data frame
#' \code{\link{patterns}}.
#'
#' @examples
#' # Example data frame
#' users <- data.frame(idUser = c(1, 2, 3, 4, 5),
#'                     name = c("Mario", "Ismael", "Fernando", "Gregorio", "John"),
#'                     dni = c("71684024L", "5684544A", "05331975M", "52498742", "603489758"))
#' users
#'
#' # Regular expression of the DNI
#' dni_pattern <- "^[0-9]{8}[TRWAGMYFPDXBNJZSQVHLCKE]$"
#'
#' ### Using check_regex (value = FALSE)
#' # We obtain the indexes of the invalid dni from the dni column
#' invalid_index <- check_regex(dni_pattern, users$dni)
#'
#' # We load the wrong values
#' invalid_dnis <- users$dni[invalid_index]
#' invalid_dnis
#'
#' ### Using check_regex (value = TRUE)
#' # We obtain the invalid values of the dni's
#' invalid_dnis <- check_regex(dni_pattern, users$dni, value = TRUE)
#' invalid_dnis
#'
#' # We create a data frame with only the valid records
#' valid_users <- users[!users$dni %in% invalid_dnis,]
#' valid_users
#'
#' # We create a data frame with only the invalid records
#' invalid_users <- users[users$dni %in% invalid_dnis,]
#' invalid_users
#'
#' ### Using check_regexl
#' # We obtain a logical vector of the matching
#' validation <- check_regexl(dni_pattern, users$dni)
#' validation
#'
#' # We create a data frame with only the valid records
#' valid_users <- users[validation,]
#' valid_users
#'
#' # We create a data frame with only the invalid records
#' invalid_users <- users[!validation,]
#' invalid_users
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
