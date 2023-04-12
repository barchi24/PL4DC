
<!-- README.md is generated from README.Rmd. Please edit that file -->

# PL4DC

<!-- badges: start -->
<!-- badges: end -->

The goal of PL4DC is to to assist in data cleansing tasks. The functions
contained are focused on improving one or more of the quality properties
defined in ISO/IEC 25024.

## Installation

You can install the development version of PL4DC from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("barchi24/PL4DC")
```

## Usage

It is quite common to have to handle dates in any data set. The problem
is that these dates can be in more than one format, which makes them
difficult to handle and use, so it is convenient to transform them to
the same format. The standardize_dates function helps with just that.

``` r
library(PL4DC)

# Example of different dates with different formats
dates <- c("27/03/2023", "15-07-2021", "16092012", "5/13/2017",
           "18-03-23", "1998-03-18", "Jun 14, 1997", "22 Jan 2015")

standardize_dates(dates, output_format = "%d/%m/%Y")
#> [1] "27/03/2023" "15/07/2021" "16/09/2012" "13/05/2017" "18/03/2023"
#> [6] "18/03/1998" "14/06/1997" "22/01/2015"
```
