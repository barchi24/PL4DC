% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fechas.R
\name{change_date_format}
\alias{change_date_format}
\title{Change Date Format}
\usage{
change_date_format(dates, new_format = "\%Y-\%m-\%d")
}
\arguments{
\item{dates}{A vector of dates (cannot be of characters).}

\item{new_format}{The desired format of the dates. The default is
"yyyy-mm-dd".}
}
\value{
A vector of dates in the desired format.
}
\description{
Changes the format of dates in a vector.
}
\note{
This function aims to help improve the property
  \code{\link[=properties]{Format Consistency}}.
}
\examples{
# Change the format of the date vector
today <- lubridate::today()
new_dates <- change_date_format(today, "\%d/\%m/\%Y")
}
