#' Detect duplicates in a data frame
#'
#' This function detects duplicated rows in a data frame based on selected
#' columns. It returns either the duplicated rows or the unique rows depending
#' on the \code{distinct} argument. It can also return only the distinct values
#' instead of the complete rows depending on the \code{value} argument.
#'
#' @param df The data frame where you want to detect duplicates.
#' @param columns A vector specifying the names or the indices of the columns
#'   where you want to detect duplicates.
#' @param value Logical indicating whether to return only the distinct values
#'   (TRUE) or the complete rows (FALSE). Default is FALSE.
#' @param distinct Logical indicating whether to return the unique rows (TRUE)
#'   instead of the duplicated rows (FALSE). Default is FALSE.
#' @param fromLast Logical indicating if duplication should be considered from
#'   the reverse side, i.e., the last (or rightmost) of identical elements would
#'   correspond to duplicated = FALSE.
#' @param nmax the maximum number of unique items expected (greater than one).
#'
#' @return A data frame containing either the duplicated or unique rows
#'   (depending on the \code{distinct} argument), or the duplicated or unique
#'   values (depending on the \code{value} argument).
#'
#' @note These functions aim to help improve the property
#'   \code{\link[=properties]{Risk of Inconsistency}}.
#'
#' @seealso This function uses the \code{\link{duplicated}} function for its
#'   implementation. For more information about the parameters
#'   \code{incomparables}, \code{fromLast} and \code{nmax} see its
#'   documentation.
#'
#' @examples
#' # Example data frame
#' cars <- data.frame(id = 1:10,
#'                    brand = c("Chevrolet", "Nissan", "Jeep", "Chevrolet",
#'                              "Jeep", "Audi", "Jeep", "Chevrolet", "Mazda",
#'                              "Audi"),
#'                    model = c("Cheyenne", "X-Trail", "Wrangler", "Tahoe",
#'                              "Wrangler", "A1", "Wrangler", "Camaro", "3", "A1"),
#'                    price = c(619000, 379000, 549000, 249000, 549000, 219000,
#'                              549000, 479000, 394000, 219000),
#'                    licence_plate = c("9927 FAC", "4852 QYU", "5026 TCI",
#'                                      "0969 VAO", "4928 NFD", "2749 OMM",
#'                                      "5395 MDL", "8259 RNT", "6610 XBQ",
#'                                      "5822 TOI"))
#' cars
#'
#' ### Bearing in mind that a record is a duplicate if they coincide in brand,
#' ### model and price
#' # We obtain the rows containing duplicates (distinct = FALSE)
#' duplicated_rows <- detect_duplicates(cars, c(2,3,4)) # same as c("brand", "model", "price")
#' duplicated_rows
#'
#' # We obtain only the values of brand and model (value = TRUE)
#' duplicated_values <- detect_duplicates(cars, c(2,3,4), value = TRUE)
#' duplicated_values
#'
#' # We obtain the rows containing the distinct values (distinct = TRUE)
#' distinct_rows <- detect_duplicates(cars, c(2,3,4), distinct = TRUE)
#' distinct_rows
#'
#' # We obtain only the values of brand and model (value = TRUE)
#' distinct_values <- detect_duplicates(cars, c(2,3,4), value = TRUE, distinct = TRUE)
#' distinct_values
#'
#' ### Bearing in mind that a record is a duplicate if they coincide in brand,
#' ### model and licence plate
#' # We obtain the rows containing duplicates (distinct = FALSE)
#' duplicated_rows <- detect_duplicates(cars, c(2,3,5))
#' duplicated_rows
#'
#' # We obtain the rows containing the distinct values (distinct = TRUE)
#' distinct_rows <- detect_duplicates(cars, c(2,3,5), distinct = TRUE)
#' distinct_rows
#' @export
detect_duplicates <- function(df, columns, value = FALSE, distinct = FALSE,
                              fromLast = FALSE, nmax = NA) {
  isDuplicated <- duplicated(df[, columns], fromLast = fromLast, nmax = nmax)

  if (distinct) {
    data <- df[!isDuplicated,]

    if (value) {
      data <- data[, columns]
    }
  } else {
    data <- df[isDuplicated,]

    if (value) {
      data <- data[!duplicated(data[, columns]), columns]
    }
  }

  return(data)
}
