# Cambia el formato de las fechas de dates al indicado en new_format
change_date_format <- function(dates, new_format = "%d/%m/%Y") {
  new_dates <- format(dates, new_format)
  return(new_dates)
}

# Función que añade delimitador a las fechas del estilo ddmmaaaa y similares (así se pueden estandarizar)
add_delimiter <- function(dates) {
  # Formato: ddmmaaaa, ddmmaa, mmddaaaa, mmddaa
  pattern1 <- "(^|\\D)(0?[1-9]|[12][0-9]|3[01])(0?[1-9]|[12][0-9]|3[01]])(\\d{2}|(19|20)\\d{2})(\\D|$)"
  # Formato: aaaammdd, aaaaddmm
  pattern2 <- "(^|\\D)(\\d{4})(0?[1-9]|[12][0-9]|3[01])(0?[1-9]|[12][0-9]|3[01])(\\D|$)"

  dates_with_delimiter <- ifelse(
    grepl(pattern1, dates),
    sub(pattern1, "\\2/\\3/\\4", dates),
    sub(pattern2, "\\2/\\3/\\4", dates)
  )

  return(dates_with_delimiter)
}

# Notas de la función:
# - Los años están limitados desde 1900 a 2099 para el primer patrón
# - Los patrones Validan si el formato de la fecha es correcto,
#   no si la fecha es valida (cantidad de días por cada mes, cantidad de meses del año, etc.)


# Función que estandarice fechas de un vector
standardize_dates <-  function(dates, input_format = "None", output_format = "%Y-%m-%d") {
  if (input_format == "None")
    input_format <- c("ymd", "mdy", "dmy")

  new_dates <- parse_date_time(dates, input_format)
  new_dates <- change_date_format(new_dates, output_format)

  return(new_dates)
}

# Función que estandarice fechas en toda la tabla (data.frame)
standardize_dates_table <-  function(dates, columns, input_format = "None", output_format = "%Y-%m-%d") {
  dates[, columns] <- apply(dates[, columns], 2, standardize_dates)

  return(dates)
}
