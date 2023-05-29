#' Primitives to improve data quality
#'
#' These primitives add a higher abstraction layer for the use of data
#' cleaning methods, and relate them directly to the data quality properties
#' that they affect.
#'
#' @param ds The data set whose quality is to be improved.
#' @param cleaningMethod The cleaning method to be applied.
#' @param ... Additional arguments to be passed to the chosen cleaning method.
#'
#' @return The return value of the cleaning method used or an error message if
#'   an invalid cleaning method is chosen.
#'
#' @seealso For more information about the cleaning methods available for each
#'   property (and therefore for each primitive), see the
#'   \code{\link[=properties]{following list}}.
#'
#' @examples
#' ds <- data.frame(dates = c("2021-01-01", "02-01-2021", "03/27/2023"))
#' Consistency_Format_Cleanup(ds, "standardize_dates")
#' @export
#' @aliases primitives
Consistency_Format_Cleanup <- function(ds, cleaningMethod, ...) {
  switch (cleaningMethod,
          standardize_dates = standardize_dates(dates = ds, ...),
          standardize_dates_table = standardize_dates_table(dates = ds, ...),
          change_date_format = change_date_format(dates = ds, ...),
          add_delimiter = add_delimiter(dates = ds),
          stop("Invalid cleaning method")
  )
}

#' @rdname Consistency_Format_Cleanup
#' @export
Syntactic_Accuracy_Cleanup <- function(ds, cleaningMethod, ...) {
  switch (cleaningMethod,
    check_regex = check_regex(vector = ds, ...),
    check_regexl = check_regexl(vector = ds, ...),
    stop("Invalid cleaning method")
  )
}

#' @rdname Consistency_Format_Cleanup
#' @export
Accuracy_Range_Cleanup <- function(ds, cleaningMethod, ...) {
  switch (cleaningMethod,
          outside_range = outside_range(vector = ds, ...),
          check_categories = check_categories(vector = ds, ...),
          stop("Invalid cleaning method")
  )
}

#' @rdname Consistency_Format_Cleanup
#' @export
Record_Completeness_Cleanup <- function(ds, cleaningMethod, ...) {
  switch (cleaningMethod,
          na_detection = na_detection(data = ds, ...),
          na_imputation = na_imputation(df = ds, ...),
          stop("Invalid cleaning method")
  )
}

#' @rdname Consistency_Format_Cleanup
#' @export
Referential_Integrity_Cleanup <- function(ds, cleaningMethod, ...) {
  switch (cleaningMethod,
          verify_integrity = verify_integrity(foreign_df = ds, ...),
          derived_column = derived_column(df = ds, ...),
          isDerivedColumnValid = isDerivedColumnValid(df = ds, ...),
          validate_derived_column = validate_derived_column(df = ds, ...),
          stop("Invalid cleaning method")
  )
}

#' @rdname Consistency_Format_Cleanup
#' @export
Risk_Inconsistency_Cleanup <- function(ds, cleaningMethod, ...) {
  switch (cleaningMethod,
          detect_duplicates = detect_duplicates(df = ds, ...),
          stop("Invalid cleaning method")
  )
}
