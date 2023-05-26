#' Primitives to improve data quality
#'
#' These primitives add a higher abstraction layer for the use of data
#' cleaning methods, and relate them directly to the data quality properties
#' that they affect.
#'
#' @param ds The data set whose quality is to be improved.
#' @param funcionLimpieza The cleaning method to be applied.
#' @param ... Additional arguments to be passed to the chosen cleaning method.
#'
#' @return The return value of the cleaning method used or an error message if
#'   an invalid cleaning method is chosen.
#'
#' @note For non-Spanish speakers, the name of the primitives contains the name
#'   of the data quality property they deal with in Spanish. To find out which
#'   one to use, you can refer to the link included in the "see also" section.
#'   There you can find the properties in both English and Spanish.
#'
#' @seealso For more information about the cleaning methods available for each
#'   property (and therefore for each primitive), see the
#'   \code{\link[=properties]{following list}}.
#'
#' @examples
#' ds <- data.frame(dates = c("2021-01-01", "02-01-2021", "03/27/2023"))
#' Limpieza_Consistencia_Formato(ds, "standardize_dates")
#' @export
#' @aliases primitives
Limpieza_Consistencia_Formato <- function(ds, funcionLimpieza, ...) {
  switch (funcionLimpieza,
          standardize_dates = standardize_dates(dates = ds, ...),
          standardize_dates_table = standardize_dates_table(dates = ds, ...),
          change_date_format = change_date_format(dates = ds, ...),
          add_delimiter = add_delimiter(dates = ds),
          stop("Metodo de limpieza no valido")
  )
}

#' @rdname Limpieza_Consistencia_Formato
#' @export
Limpieza_Exactitud_Sintactica <- function(ds, funcionLimpieza, ...) {
  switch (funcionLimpieza,
    check_regex = check_regex(vector = ds, ...),
    check_regexl = check_regexl(vector = ds, ...),
    stop("Metodo de limpieza no valido")
  )
}

#' @rdname Limpieza_Consistencia_Formato
#' @export
Limpieza_Rango_Exactitud <- function(ds, funcionLimpieza, ...) {
  switch (funcionLimpieza,
          outside_range = outside_range(vector = ds, ...),
          check_categories = check_categories(vector = ds, ...),
          stop("Metodo de limpieza no valido")
  )
}

Limpieza_Completitud_Registro <- function(ds, funcionLimpieza, ...) {
  switch (funcionLimpieza,
          na_detection = na_detection(data = ds, ...),
          na_imputation = na_imputation(df = ds, ...),
          stop("Metodo de limpieza no valido")
  )
}

#' @rdname Limpieza_Consistencia_Formato
#' @export
Limpieza_Integridad_Referencial <- function(ds, funcionLimpieza, ...) {
  switch (funcionLimpieza,
          verify_integrity = verify_integrity(foreign_df = ds, ...),
          derived_column = derived_column(df = ds, ...),
          isDerivedColumnValid = isDerivedColumnValid(df = ds, ...),
          validate_derived_column = validate_derived_column(df = ds, ...),
          stop("Metodo de limpieza no valido")
  )
}

#' @rdname Limpieza_Consistencia_Formato
#' @export
Limpieza_Riesgo_Inconsistencia <- function(ds, funcionLimpieza, ...) {
  switch (funcionLimpieza,
          detect_duplicates = detect_duplicates(df = ds, ...),
          stop("Metodo de limpieza no valido")
  )
}
