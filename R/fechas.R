#' Change Date Format
#'
#' Changes the format of dates in a vector
#'
#' @param dates A vector of dates
#' @param new_format The desired format of the dates. The default is "%Y-%m-%d".
#'
#' @return A vector of dates in the desired format
#'
#' @examples
#' # Change the format of the date vector
#' new_dates <- change_date_format("30/03/2023")
#'
#' @export
#'
change_date_format <- function(dates, new_format = "%Y-%m-%d") {
  new_dates <- format(dates, new_format)
  return(new_dates)
}

#' Add delimiter to date
#'
#' Adds the '/' delimiter to a vector of dates with no delimiter. This will make it
#' easier to standardize these types of dates using the standardize_dates function.
#'
#' @param dates A character vector of dates with no delimiter.
#' @return A character vector with the dates having the '/' delimiter.
#'
#' @examples
#' add_delimiter(c("01012020", "22032023", "220323", "20200101"))
#'
#' @export
#'
add_delimiter <- function(dates) {
  # Format: ddmmyyyy, ddmmyy, mmddyyyy, mmddyy
  pattern1 <- "(^|\\D)(0?[1-9]|[12][0-9]|3[01])(0?[1-9]|[12][0-9]|3[01]])(\\d{2}|(19|20)\\d{2})(\\D|$)"
  # Format: yyyymmdd, yyyyddmm
  pattern2 <- "(^|\\D)(\\d{4})(0?[1-9]|[12][0-9]|3[01])(0?[1-9]|[12][0-9]|3[01])(\\D|$)"

  # Check if the dates follow pattern 1. Based on that,
  # introduce the delimiters following one pattern or the other
  dates_with_delimiter <- ifelse(
    grepl(pattern1, dates),
    sub(pattern1, "\\2/\\3/\\4", dates),
    sub(pattern2, "\\2/\\3/\\4", dates)
  )

  return(dates_with_delimiter)
}

#' Standardize dates
#'
#' Converts a vector of dates from one or more formats to another.
#'
#' @param dates A vector of dates to be standardized
#' @param input_format The input format of the dates. If not specified, the function will try to parse the dates in the following formats: ymd, mdy, dmy.
#' @param output_format The output format of the dates. The default is "%Y-%m-%d".
#'
#' @return A vector of standardized dates.
#'
#' @examples
#' standardize_dates(c("12/31/2019", "27-03-20"))
#'
#' @export
#'
standardize_dates <-  function(dates, input_format = c("ymd", "mdy", "dmy"), output_format = "%Y-%m-%d") {
  # Parse the dates to the default format of the parse_data_time function
  new_dates <- parse_date_time(dates, input_format)
  # Change the format to the one specified in the output_format parameter
  new_dates <- change_date_format(new_dates, output_format)

  return(new_dates)
}

#' Standardize Dates Table
#'
#' Takes a dataframe and converts the values in the specified columns from one format to another.
#'
#' @param dates A dataframe containing dates to be standardized.
#' @param columns The columns to standardize in the dataframe.
#' @param input_format The format of the dates in the dataframe. Defaults to: ymd, mdy, dmy.
#' @param output_format The output format of the dates. Defaults to "%Y-%m-%d".
#' @return The same dataframe with the specified columns standardized.
#' @export
#'
#' @examples
#' # Create dataframe with dates
#' dates <- data.frame(id = 1:2,
#'                     date1 = c("Feb 2, 2021", "02032021"),
#'                     date2 = c("12/31/2019", "27-03-20"))
#'
#' # Standardize dates
#' dates <- standardize_dates_table(dates, c(2, 3))
#'
#' @export standardize_dates_table
#'
standardize_dates_table <-  function(dates, columns, input_format = c("ymd", "mdy", "dmy"), output_format = "%Y-%m-%d") {
  dates[, columns] <- apply(dates[, columns], 2, standardize_dates)

  return(dates)
}
