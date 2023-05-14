#' Change Date Format
#'
#' Changes the format of dates in a vector.
#'
#' @param dates A vector of dates (cannot be of characters).
#' @param new_format The desired format of the dates. The default is
#'   "yyyy-mm-dd".
#'
#' @return A vector of dates in the desired format.
#'
#' @note This function aims to help improve the property
#'   \code{\link[=characteristics_properties]{Format Consistency}}.
#'
#' @examples
#' # Change the format of the date vector
#' today <- lubridate::today()
#' new_dates <- change_date_format(today, "%d/%m/%Y")
#' @export
change_date_format <- function(dates, new_format = "%Y-%m-%d") {
  new_dates <- format(dates, new_format)
  return(new_dates)
}

#' Add delimiter to date
#'
#' Adds the '/' delimiter to a vector of dates with no delimiter. This function
#' exists to facilitate the use of \code{\link{standardize_dates}()}, since, if in this
#' type of dates the leading zero is missing in the day and/or in the month when
#' they are values less than 10 (e.g. 1732023), it cannot perform the
#' transformation. By adding any kind of delimiter it can be transformed without
#' problems.
#'
#' @param dates A character vector of dates with no delimiter.
#'
#' @return A character vector with the dates having the '/' delimiter.
#'
#' @details When a date containing the year at the end is entered, it will be
#'   limited from 1900 to 2099. Also, this function validates if the date format
#'   is correct, but not if the date is valid (number of days for each month,
#'   number of months in the year, etc.).
#'
#' @note This function aims to help improve the property
#'   \code{\link[=characteristics_properties]{Format Consistency}}.
#'
#' @seealso \code{\link{replace}}
#'
#' @examples
#' # Basic example
#' add_delimiter(c("01012020", "22032023", "220323", "20200101"))
#'
#' # Common application
#' # This vector cannot be standardized completely using standardize_dates()
#' dates <- c("27/03/2023", "15-07-2021", "1692012", "5/13/2017", "5122010")
#'
#' # First we transform the problem dates
#' dates[c(3,5)] <- add_delimiter(dates[c(3,5)])
#'
#' # Now we can use standardize_dates() without any problems
#' standardize_dates(dates)
#' @export
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

#' Simplified date parsing function
#'
#' Both of this functions convert dates from one or more formats to another.
#' \code{standardize_dates()} takes a vector of dates, and
#' \code{standardize_dates_table()} takes a dataframe and you specify the
#' columns that contain dates.
#'
#' @param dates A vector of dates or a dataframe with multiple columns with
#'   dates to be standardized.
#' @param columns The columns containing dates to standardize in the dataframe
#'   (must be greater than 1).
#' @param input_format The input format of the dates. If not specified, the
#'   function will try to parse the dates in the following formats: dmy, mdy,
#'   ymd.
#' @param output_format The output format of the dates. The default is
#'   "yyyy-mm-dd".
#'
#' @return In the case of \code{standardize_dates()}, a vector of standardized
#'   dates; and in the case of \code{standardize_dates_table()}, the same
#'   dataframe with the specified columns standardized.
#'
#' @note These functions aim to help improve the property
#'   \code{\link[=characteristics_properties]{Format Consistency}}.
#'
#' @seealso \code{\link{na_positions}, \link{replace}}
#'
#' @examples
#' # Using a vector
#' # Example of different dates with different formats
#' dates <- c("27/03/2023", "15-07-2021", "16092012", "5/13/2017",
#'            "18-03-23", "1998-03-18", "Jun 14, 1997", "22 Jan 2015")
#'
#' standardize_dates(dates, output_format = "%d/%m/%Y")
#'
#' # Using a dataframe
#' # Create dataframe with dates
#' dates <- data.frame(id = 1:2,
#'                     date1 = c("Feb 2, 2021", "02032021"),
#'                     date2 = c("12/31/2019", "27-03-20"))
#'
#' dates <- standardize_dates_table(dates, c(2, 3))
#' @import lubridate
#' @export
standardize_dates <- function(dates, input_format = c("dmy", "mdy", "ymd"),
                               output_format = "%Y-%m-%d") {
  # Parse the dates to the default format of the parse_data_time function
  new_dates <- lubridate::parse_date_time(dates, input_format)
  # Change the format to the one specified in the output_format parameter
  new_dates <- change_date_format(new_dates, output_format)

  return(new_dates)
}

#' @rdname standardize_dates
#' @export
standardize_dates_table <- function(dates, columns,
                                     input_format = c("ymd", "mdy", "dmy"),
                                     output_format = "%Y-%m-%d") {
  dates[, columns] <- apply(dates[, columns], 2, standardize_dates)

  return(dates)
}
