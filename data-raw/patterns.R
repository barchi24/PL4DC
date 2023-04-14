name <- c("Email",
          "Phone number",
          "DNI",
          "IP address")

pattern <- c("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$",
             "^[+][0-9]{2}[0-9]{9}$",
             "^[0-9]{8}[TRWAGMYFPDXBNJZSQVHLCKE]$",
             "^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$")

example <- c("john.doe@example.com",
             "+34650845687",
             "71068578A",
             "192.168.0.1")

patterns <- data.frame(Name = name,
                       Pattern = pattern,
                       Example = example)

usethis::use_data(patterns, overwrite = TRUE)

# Teléfonos válidos (no solo +34610587480):
# "^(\\+\\d{1,3}\\s?)?(\\d{9}|\\d{3}((\\s\\d{2}){3}|(\\s\\d{3}){2}))$"
