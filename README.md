
<!-- README.md is generated from README.Rmd. Please edit that file -->

# PL4DC

<!-- badges: start -->
<!-- badges: end -->

The goal of PL4DC is to to assist in data cleaning tasks. The functions
contained are focused on improving one or more of the data quality
properties defined in ISO/IEC 25024. The library is composed of two main
types of functions: primitives and cleaning methods. Both are focused on
helping to improve (mainly) a data quality property (in the case of
primitives it is indicated in their name); each primitive contains one
or more cleaning methods, and it’s named after the property related to
it. (using the command *?cleaning_methods* you can access the list of
cleaning methods available for each primitive).

## Installation

You can install the development version of PL4DC from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("barchi24/PL4DC")
```

## Usage

There are two ways to work with PL4DC: using the primitives, or using
the cleaning methods directly. At the beginning it is advisable to work
with primitives, as they provide an additional layer of abstraction that
makes it easier to understand and use the cleaning methods. Once you’ve
had some practice, it will probably be quicker to work directly with the
cleaning methods, but that’s up to each individual.

To access the list of available primitives, use the following command
(which will take you to the documentation of these primitives):

``` r
?primitives
```

And to access the list of cleaning methods, use one of the following
commands:

``` r
?cleaning_methods
?properties
?characteristics
```
