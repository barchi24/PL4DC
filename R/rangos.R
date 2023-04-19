#' Detect values outside range
#'
#' Given a vector of numeric values, returns the indices or values that are
#' outside of the specified range.
#'
#' @param vector A numeric vector to be evaluated.
#' @param min The lower bound of the range.
#' @param max The upper bound of the range.
#' @param value Logical indicating whether to return the values outside of the
#'   range instead of their indices (default: FALSE).
#'
#' @return A numeric vector of either the values or indices that are outside of
#'   the specified range.
#'
#' @examples
#' # Example data frame
#' employees <- data.frame(idUser = c(1, 2, 3, 4, 5),
#'                         name = c("Mario", "Ismael", "Fernando", "Gregorio", "John"),
#'                         salaries = c(10000, 3600, 4000, 500, 800))
#' employees
#'
#' # Minimum wage
#' min <- 900
#'
#' # Maximum wage
#' max <- 5000
#'
#' ### Using value = FALSE
#' # We obtain the indexes of the invalid salaries from the salaries column
#' invalid_indexes <- outside_range(employees$salaries, min, max)
#'
#' # We load the wrong values
#' invalid_salaries <- employees$salaries[invalid_indexes]
#' invalid_salaries
#'
#' ### Using value = TRUE
#' # We obtain the invalid salaries
#' invalid_salaries <- outside_range(employees$salaries, min, max, value = TRUE)
#' invalid_salaries
#'
#' # We create a data frame with only the valid records
#' valid_employees <- employees[!employees$salaries %in% invalid_salaries,]
#' valid_employees # or employees[employees$salaries >= min & employees$salaries <= max,]
#'
#' # We create a data frame with only the invalid records
#' invalid_employees <- employees[employees$salaries %in% invalid_salaries,]
#' invalid_employees # or employees[employees$salaries < min | employees$salaries > max,]
#' @export
outside_range <- function(vector, min, max, value = FALSE) {
  in_range <- vector >= min & vector <= max

  if (value) {
    invalid <- vector[!in_range]
  } else {
    invalid <- which(!in_range)
  }

  return(invalid)
}

#' Detect specified categories
#'
#' This function takes a character vector and a vector of categories and returns a
#' vector with the indices or values that are not in the specified categories.
#'
#' @param vector A character vector to check.
#' @param categories A vector of allowed categories.
#' @param value Logical indicating whether to return the values that are not in
#'   the specified categories instead of their indices (default: FALSE).
#'
#' @return A vector with the indices or values that are not in the specified
#'   categories
#'
#' @examples
#' # Example data frame
#' papers <- data.frame(idPaper = c(1, 2, 3, 4, 5),
#'                      author = c("Mario", "Ismael", "Fernando", "Gregorio", "John"),
#'                      state = c("Accepted", "Admitted", "Declined", "Reviewing", "Rejected"))
#' papers
#'
#' categories <- c("Rejected", "Reviewing", "Accepted")
#'
#' ### Using value = FALSE
#' # We obtain the indexes of the invalid states from the state column
#' invalid_indexes <- check_categories(papers$state, categories)
#'
#' # We load the wrong values
#' invalid_states <- papers$state[invalid_indexes]
#' invalid_states
#'
#' ### Using value = TRUE
#' # We obtain the invalid states
#' invalid_states <- check_categories(papers$state, categories, value = TRUE)
#' invalid_states
#'
#' # We create a data frame with only the valid records
#' valid_papers <- papers[!papers$state %in% invalid_states,]
#' valid_papers
#'
#' # We create a data frame with only the invalid records
#' invalid_papers <- papers[papers$state %in% invalid_states,]
#' invalid_papers
#' @export
check_categories <- function(vector, categories, value = FALSE) {
  non_categories <- is.na(factor(vector, levels = categories))

  if (value) {
    invalid <- vector[non_categories]
  } else {
    invalid <- which(non_categories)
  }

  return(invalid)
}
