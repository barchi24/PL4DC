library(idealista18)

### Fusion datos

data(Madrid_Sale)

madrid <- rep("Madrid", nrow(Madrid_Sale))
Madrid_Sale_cities <- cbind(Madrid_Sale, CITY = madrid)
Madrid_Sale_cities <- Madrid_Sale_cities[,-c(39,42)]

data(Barcelona_Sale)

barcelona <- rep("Barcelona", nrow(Barcelona_Sale))
Barcelona_Sale_cities <- cbind(Barcelona_Sale, CITY = barcelona)
Barcelona_Sale_cities <- Barcelona_Sale_cities[,-c(39,42)]

data(Valencia_Sale)

valencia <- rep("Valencia", nrow(Valencia_Sale))
Valencia_Sale_cities <- cbind(Valencia_Sale, CITY = valencia)
Valencia_Sale_cities <- Valencia_Sale_cities[,-c(39,42)]

idealista <- rbind(Madrid_Sale_cities, Barcelona_Sale_cities, Valencia_Sale_cities)

rm(Madrid_Sale, Madrid_Sale_cities, madrid,
   Barcelona_Sale, Barcelona_Sale_cities, barcelona,
   Valencia_Sale, Valencia_Sale_cities, valencia)

### Modificaciones

# Para Rango de Exactitud
indices_muestra <- sample(1:nrow(idealista), 92840)
idealista$PRICE[indices_muestra] <- -1 * idealista$PRICE[indices_muestra]

rm(indices_muestra)

# Para Integridad Referencial
n <- 50000

propietario_id <- 1:n

nombres <- c("Juan", "María", "Pedro", "Ana", "Luisa", "Miguel", "Carmen", "Pablo", "Sofía", "Javier", "José", "Isabel", "Marta", "Lucía", "Diego", "Carlos", "Andrea", "David", "Elena", "Adrián", "Laura", "Jorge", "Cristina", "Víctor", "Paula", "Roberto", "Nerea", "Fernando", "Alicia", "Oscar")
apellido1 <- c("García", "Pérez", "Martínez", "Fernández", "González", "López", "Sánchez", "Romero", "Navarro", "Ruiz", "Sanz", "Álvarez", "González", "Ferrer", "Serrano", "Santos", "Ruíz", "Pereira", "Gómez", "Gonzalo", "Soria", "Camacho", "Soto", "Alonso", "Núñez", "Blanco", "Hernández", "Carrasco", "Márquez", "Calvo")
apellido2 <- c("Gómez", "Rodríguez", "Fernández", "González", "Sánchez", "Romero", "Navarro", "Ruiz", "Martínez", "Pérez", "Castro", "García", "López", "Castillo", "Fernández", "López", "Gómez", "García", "García", "Carrasco", "Navarro", "Pérez", "Molina", "Rivas", "Fernández", "Carrasco", "Molina", "Romero", "García")
nombres_completos <- paste(sample(nombres, n, replace = TRUE),
                           sample(apellido1, n, replace = TRUE),
                           sample(apellido2, n, replace = TRUE), sep = " ")

telefonos <- paste0("6", sample(c(0:3, 5:9), n, replace = TRUE),
                    sample(1000000:9999999, n, replace = TRUE))

dominios <- c("gmail.com", "hotmail.com", "yahoo.com", "outlook.com", "protonmail.com", "aol.com", "icloud.com")
usuario <- gsub(" ", ".", tolower(nombres_completos))
correo <- paste0(usuario, "@", sample(dominios, n, replace = TRUE))

owners <- data.frame(
  OWNER_ID = propietario_id,
  NAME = nombres_completos,
  TEL = telefonos,
  EMAIL = correo,
  stringsAsFactors = FALSE
)

owners <- rbind(c(0, "Unknown owner", "000000000", "unknown.owner@unknown.com"),
                owners)

id_inexistentes <- sample(100000:200000, nrow(owners) * 0.2)
id_combinados <- c(owners$OWNER_ID, id_inexistentes)
ids <- sample(id_combinados, nrow(idealista), replace = TRUE)

idealista <- cbind(idealista, OWNER = ids)

rm(apellido1, apellido2, correo, dominios, id_combinados, id_inexistentes, ids, n, nombres, nombres_completos, propietario_id, telefonos, usuario)

usethis::use_data(idealista, overwrite = TRUE)
usethis::use_data(owners, overwrite = TRUE)
