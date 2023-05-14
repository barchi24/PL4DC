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
#' na_positions(c(1, NA, 2, NA))
#' @export
na_positions <- function(x) {
  na_index <- which(is.na(x))
  return(na_index)
}

#' Summarizing imputation information
#'
#' This function was made to print and summarize the "imputation" class objects
#' result of a call to \code{\link{na_imputation}}.
#'
#' @param object An object of class "imputation", result of a call to
#'   na_imputation().
#'
#' @return Information about \code{object}.
#'
#' @seealso
#' For more information about the function, check the
#' \code{\link{summary.imputation}} documentation.
#'
#' Related functions: \code{\link{na_imputation}, \link{plot_imputation}}
#'
#' @examples
#' # Generate data for the example
#' heartfailure2 <- dlookr::heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 20), "platelets"] <- NA
#'
#' # Replace the missing value of the platelets variable with median
#' imputation <- na_imputation(heartfailure2, "platelets", method = "median")
#'
#' summary_imputation(imputation)
#' @import dlookr
#' @export
summary_imputation <- function(object) {
  return(summary(object))
}

#' Visualize Information for an "imputation" Object
#'
#' This function was made to plot the "imputation" class objects result of a
#' call to \code{\link{na_imputation}}. It can visualize two kinds of plot: the
#' imputation of a numerical variable is a density plot, and the imputation of a
#' categorical variable is a bar plot.
#'
#' @param x An object of class "imputation", result of a call to
#'   na_imputation().
#' @param typographic Logical indicating whether to apply focuses on typographic
#'   elements to ggplot2 visualization. The default is TRUE. If TRUE provides a
#'   base theme that focuses on typographic elements using hrbrthemes package.
#' @param base_family String indicating the name of the base font family to use
#'   for the visualization. If not specified, the font defined in dlookr is
#'   applied.
#'
#' @return Graph to visualize \code{x}.
#'
#' @seealso
#' For more information about the function, check the
#' \code{\link{plot.imputation}} documentation.
#'
#' Related functions: \code{\link{na_imputation}, \link{summary_imputation}}
#'
#' @examples
#' # Generate data for the example
#' heartfailure2 <- dlookr::heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 20), "platelets"] <- NA
#'
#' # Replace the missing value of the platelets variable with median
#' imputation <- na_imputation(heartfailure2, "platelets", method = "median")
#'
#' plot_imputation(imputation, typographic = FALSE)
#' @import dlookr
#' @export
plot_imputation <- function(x, typographic = TRUE, base_family = NULL) {
  return(plot(x, typographic, base_family))
}
