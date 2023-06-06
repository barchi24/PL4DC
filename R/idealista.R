#' Data sets used for validation
#'
#' These data sets have been used in the application case for the validation of
#' primitives and cleaning methods. The \code{idealista} data set is a
#' modification of the data sets of the \code{idealista18} package, and
#' \code{owners} data set is totally original.
#'
#' @usage data(idealista)
#' @format \code{idealista} contains 189923 rows and 42 columns.
#' @details In the application case, these data sets had to comply with the
#'   following business rules:
#' \describe{
#'   \item{\code{Business Rule 1}}{The \code{ASSETID} attribute must be represented by 21
#'   characters, of which the first character must be the alphabetic character
#'   "A", and the remaining twenty must be digits in the range [0-9]}
#'   \item{\code{Business Rule 2}}{The \code{PERIOD} attribute  must be represented following
#'   the format: yyyy-mm; as in 2018-03}
#'   \item{\code{Business Rule 3}}{The \code{PRICE} attribute value cannot be negative}
#'   \item{\code{Business Rule 4}}{The \code{CONSTRUCTIONYEAR} attribute cannot have NA
#'   values}
#'   \item{\code{Business Rule 5}}{The values of the \code{OWNER} attribute must be contained
#'   in the \code{OWNER_ID} attribute of the \code{owners} table}
#'   \item{\code{Business Rule 6}}{The \code{ASSETID} and \code{OWNER} tuples must be unique, except
#'   for those where \code{OWNER} is 0.}
#' }
#' @source <https://github.com/paezha/idealista18>
"idealista"

#' @rdname idealista
#' @usage data(owners)
#' @format \code{owners} contains 50001 rows and 4 columns.
"owners"
