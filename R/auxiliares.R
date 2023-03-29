# Serviría para localizar los posibles valores NA del vector que devuelve
# la función standardize_dates(). Serían los valores que no se han podido parsear.
# Gracias a esto puede accederse a los valores del vector original de fechas y
# arreglarlos manualmente. Una vez arreglados se puede usar la función replace_values()
# para reemplazar los valores arreglados en el vector de fechas
find_na <- function(vector) {
  na_positions <- which(is.na(vector))
  return(na_positions)
}

# Serviría para sustituir los valores NA devueltos por la función standardize_dates()
# por los valores arreglados manualmente
replace_values <- function(vector, positions, replacement) {
  vector[positions] <- replacement
  return(vector)
}
