#' Verifies referential integrity between two data frames
#'
#' This function verifies whether the values in one column of a data frame
#' (primary_df) are present in another column of a different data frame
#' (foreign_df), to ensure referential integrity between both data frames.
#'
#' @param foreign_df The data frame containing the foreign key.
#' @param foreign_col The name of the column in the data frame (foreign_df) that
#'   contains the foreign values.
#' @param primary_df The data frame containing the primary key.
#' @param primary_col The name of the column in the  data frame (primary_df)
#'   that contains the primary values.
#' @param value Logical indicating whether to return the violated values of
#'   \code{foreign_col} (TRUE) or the complete rows of \code{foreign_df}
#'   containing the violated values (FALSE). Default is FALSE.
#'
#' @return
#' \code{verify_integrity (value = FALSE)} returns a dataframe with the
#' rows containing the violated values in \code{foreign_col}.
#'
#' \code{verify_integrity (value = TRUE)} returns a vector with the
#' violated values in \code{foreign_col}.
#'
#' @note This function aims to help improve the property
#'   \code{\link[=characteristics_properties]{Referential Integrity}}.
#'
#' @examples
#' # Example data frame
#' employees <- data.frame(id = 1:5, name = c("Mario", "Ismael", "Fernando", "Gregorio", "John"))
#' sales <- data.frame(id = 1:5, price = c(500, 1000, 250, 300, 500),
#'                     date = c("08/01/2022", "16/03/2022", "03/04/2022", "04/04/2022", "10/05/2022"),
#'                     seller = c(1, 2, 3, 3, 6))
#'
#' ### Using value = FALSE
#' # We obtain a data frame with only the invalid records
#' invalid_sales <- verify_integrity(sales, "seller", employees, "id")
#' invalid_sales
#'
#' # We create a data frame with only the valid records
#' valid_sales <- sales[!sales$seller %in% invalid_sales$seller,]
#'
#' ### Using value = TRUE
#' # We obtain the violated_values
#' violated_values <- verify_integrity(sales, "seller", employees, "id", value = TRUE)
#' violated_values
#'
#' # We create a data frame with only the valid records
#' valid_sales <- sales[!sales$seller %in% violated_values,]
#' valid_sales
#'
#' # We create a data frame with only the invalid records
#' invalid_sales <- sales[sales$seller %in% violated_values,]
#' invalid_sales
#' @export
verify_integrity <- function(foreign_df, foreign_col, primary_df, primary_col, value = FALSE) {
  foreign_values <- unique(foreign_df[[foreign_col]])
  primary_values <- unique(primary_df[[primary_col]])
  violated_values <- foreign_values[!foreign_values %in% primary_values]

  if (!value) {
    violated_values <- foreign_df[foreign_df[[foreign_col]] %in% violated_values, ]
  }

  return(violated_values)
}

#' Creates a new column in a data frame using a formula
#'
#' This function creates a new column in a data frame by evaluating a formula
#' that references other columns in this (df) or other data frame. The new
#' column is added to the data frame in-place.
#'
#' @param df The data frame where the new column will be added.
#' @param new_col A character string with the name of the new column to be
#'   created.
#' @param formula A formula that specifies how to calculate the new column based
#'   on other columns in the data frame. The formula can include arithmetic
#'   operations and function calls, and can reference other columns in this data
#'   frame (df) or another data frame using their names or indices.
#'
#' @return The same data frame with the new column added.
#'
#' @note This function aims to help improve the property
#'   \code{\link[=characteristics_properties]{Referential Integrity}}.
#'
#' @examples
#' data <- data.frame(x = 1:5, y = 6:10)
#' derived_column(data, "z", quote(x + y))
#' @export
derived_column <- function(df, new_col, formula) {
  df[[new_col]] <- eval(formula, df)

  return(df)
}

#' Check if a derived column is valid based on a formula
#'
#' Both functions validate whether a column (created based on data from other
#' columns) is valid by evaluating a formula that references other columns in
#' this or another data frame. \code{isDerivedColumnValid} returns a logical
#' value indicating whether all values comply with the formula entered or not,
#' and \code{validate_derived_column} returns the invalid values of the column
#' or complete rows containing invalid values, depending on the \code{value}
#' parameter.
#'
#' @param df The data frame that contains the column to be validated.
#' @param col_name Name or index of the column to be validated.
#' @param formula A formula that specifies how to calculate the new column based
#'   on other columns in the data frame. The formula can include arithmetic
#'   operations and function calls, and can reference other columns in this (df)
#'   or another data frame using their names or indices.
#' @param value Logical indicating whether to return invalid values of the
#'   column (TRUE) or the complete rows containing invalid values (FALSE).
#'   Default is FALSE.
#'
#' @return
#' \code{isDerivedColumnValid} returns a logical value indicating whether all
#' values comply with the formula entered (TRUE) or not (FALSE).
#'
#' \code{validate_derived_column (value = FALSE)} returns a dataframe with the
#' rows containing invalid values in \code{col_name}.
#'
#' \code{validate_derived_column (value = TRUE)} returns a vector with the
#' invalid values of \code{col_name}.
#'
#' @details The \code{formula} parameter must be wrapped in the \code{quote()}
#'   function so that it is passed as an evaluable expression. For example:
#'   \code{isDerivedColumnValid(df, "col3", quote(col1 + col2))}
#'
#' @note These functions aim to help improve the property
#'   \code{\link[=characteristics_properties]{Referential Integrity}}.
#'
#' @seealso Use \code{\link{derived_column}} to create columns derived from the
#'   data in other columns.
#'
#' @examples
#' # Example data frame
#' data <- data.frame(x = c(1, 2, 3, 4), y = c(4, 5, 6, 7), z = c(5, 7, 18, 11))
#' data
#'
#' # Using isDerivedColumnValid we check if all the values are valid
#' isDerivedColumnValid(data, "z", quote(x + y))
#
#' # We load the wrong values using validate_derived_column (value = TRUE)
#' invalid_values <- validate_derived_column(data, "z", quote(x + y), value = TRUE)
#' invalid_values
#'
#' # We check the row to see what's wrong
#' invalid_rows <- data[data$z == 18,]
#'
#' # We could directly obtain the rows using validate_derived_column (value = FALSE)
#' invalid_rows <- validate_derived_column(data, "z", quote(x + y))
#' invalid_rows
#' @export
isDerivedColumnValid <- function(df, col_name, formula) {
  temp_col <- eval(formula, df)

  if (all(df[[col_name]] == temp_col)) {
    result <- TRUE
  } else {
    result <- FALSE
  }

  return(result)
}

#' @rdname isDerivedColumnValid
#' @export
validate_derived_column <- function(df, col_name, formula, value = FALSE) {
  temp_col <- eval(formula, df)
  invalid <- is.na(temp_col) | temp_col != df[[col_name]]

  if (value) {
    invalid_values <- df[[col_name]][invalid]
  } else {
    invalid_values <- df[which(invalid),]
  }

  return(invalid_values)
}
