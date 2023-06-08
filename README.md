
<!-- README.md is generated from README.Rmd. Please edit that file -->

# PL4DC

<!-- badges: start -->
<!-- badges: end -->

The goal of PL4DC is to to assist in data cleaning tasks. The functions
contained are focused on improving one or more of the data quality
properties defined in ISO/IEC 25024. The library is composed of two main
types of functions: primitives and cleaning methods. Both are focused on
helping to improve (mainly) a data quality property (in the case of
primitives it is indicated in their name); each primitive is named after
the property related to it, and contains one or more cleaning methods.

## Installation

You can install the development version of PL4DC from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("barchi24/PL4DC")
```

## Workflow

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

## Application case

``` r
library(PL4DC)
```

This section shows a PL4DC application case to demonstrate its use. To
do so, we are going to use a two data sets called *idealista* and
*owners*. The first one is based on the [idealista18
package](https://github.com/paezha/idealista18 "Dataset source") data
sets, which contain information about real estate ads from idealista for
the cities of Madrid, Barcelona and Valencia during 2018. The second one
was expressly made to include referential integrity. These data sets are
included in PL4DC, and in order to load them, simply execute the
following line:

``` r
data(idealista, owners)
```

In addition, the following business rules were created for both data
sets:

- **Business Rule 1**: The *ASSETID* attribute must be represented by 21
  characters, of which the first character must be the alphabetic
  character “A”, and the remaining twenty must be digits in the range
  \[0-9\].
- **Business Rule 2**: The *PERIOD* attribute must be represented
  following the format: yyyy-mm; as in 2018-03.
- **Business Rule 3**: The *PRICE* attribute value cannot be negative.
- **Business Rule 4**: The *CONSTRUCTIONYEAR* attribute cannot have NA
  values.
- **Business Rule 5**: The values of the *OWNER* attribute must be
  contained in the *OWNER_ID* attribute of the owners table.
- **Business Rule 6**: The *ASSETID* and *OWNER* tuples must be unique,
  except for those where OWNER is 0.

All of these business rules are being violated, and the goal is to
enforce them.

### Application of PL4DC

#### First business rule

To enforce the first business rule, we first use the
*Syntactic_Accuracy_Cleanup* primitive with the *check_regexl* cleaning
method to obtain the rows that did not comply with the rule.

``` r
validation <- Syntactic_Accuracy_Cleanup(idealista$ASSETID,
                                         "check_regexl",
                                         "^A\\d{20}$")
```

After analyzing them, we discovered that the problem with those records
is that they have less than twenty digits. To solve it, first we obtain
the indexes of the invalid rows by using the
*Syntactic_Accuracy_Cleanup* primitive with the *check_regex* cleaning
method.

``` r
invalid_ids <- Syntactic_Accuracy_Cleanup(idealista$ASSETID,
                                          "check_regex",
                                          "^A\\d{20}$", value = TRUE)
```

Once obtained, these are passed to a function that adds as many zeros as
necessary after the letter “A” to these identifiers. Finally, the
invalid identifiers were replaced by the modified ones.

``` r
modified_ids <- add_zeros(invalid_ids)
idealista_modified[!validation, 1] <- modified_ids
```

#### Second business rule

To enforce the second business rule, the *Consistency_Format_Cleanup*
primitive with the *standardize_dates* cleaning method is used to modify
the values of the *PERIOD* attribute (all values were in the format
yyyymm, i.e., the year and month were not hyphen-delimited).

``` r
idealista_modified$PERIOD <- Consistency_Format_Cleanup(idealista$PERIOD,
                                                        "standardize_dates",
                                                        "ym", "%Y-%m")
```

#### Third business rule

To enforce the third business rule, the *Accuracy_Range_Cleanup*
primitive is used with the *outside_range* cleaning method to obtain the
values that are negative.

``` r
invalid_prices <- Accuracy_Range_Cleanup(idealista$PRICE,
                                         "outside_range",
                                         0, Inf)
```

After analyzing them, it is concluded that the prices seem correct if
positive. So, to solve this problem, we apply absolute value to all
values.

``` r
idealista_modified$PRICE[invalid_prices] <- abs(idealista$PRICE[invalid_prices])
```

#### Fourth business rule

To enforce the fourth business rule, the *Record_Completeness_Cleanup*
primitive with the *na_detection* cleaning method is used to obtain the
indexes of the rows with NA values.

``` r
na_rows <- Record_Completeness_Cleanup(idealista,
                                       "na_detection",
                                       "CONSTRUCTIONYEAR")
```

Once the indexes are obtained, these values are replaced by their
corresponding values of the *CADCONSTRUCTIONYEAR* attribute, thus
solving the problem.

``` r
idealista_modified$CONSTRUCTIONYEAR[na_rows] <- idealista$CADCONSTRUCTIONYEAR[na_rows]
```

#### Fifth business rule

To enforce the fifth business rule, the *Referential_Integrity_Cleanup*
primitive with the *verify_integrity* cleaning method is used to obtain
the subset of data that violated referential integrity.

``` r
invalid_owners <- Referential_Integrity_Cleanup(idealista,
                                                "verify_integrity",
                                                "OWNER", owners, "OWNER_ID")
```

With these data, we can now replace the indexes of the invalid rows
obtained by the value 0 (the record with id 0 in the *owners* table
refers to the fact that its owner is unknown), thus solving the problem.

``` r
idealista_modified$OWNER[as.integer(row.names(invalid_owners))] <- 0
```

#### Sixth business rule

As for the sixth business rule, only three rows out of a total of 189923
violate the rule. We can obtain this information by using the
*Risk_Inconsistency_Cleanup* primitive and the *detect_duplicates*
cleaning method.

``` r
duplicated_rows <- Risk_Inconsistency_Cleanup(idealista,
                                              "detect_duplicates",
                                              c("ASSETID", "OWNER"))
nrow(duplicated_rows)
#> [1] 3
```

To correct this violation, since a very small number of rows are
involved, we can simply delete these rows.

``` r
duplicated_row_indexes <- row.names(duplicated_rows)
idealista_modified <- idealista_modified[-as.integer(duplicated_row_indexes), ]
```

### Conclusion

With these modifications, all business rules have become compliant. We
can check this by re-executing the primitives in the data set where we
have been making the modifications (*idealista_modified*) and seeing
that, indeed, they do not find any non-conformity.

``` r
all(Syntactic_Accuracy_Cleanup(idealista_modified$ASSETID,
                               "check_regexl",
                               "^A\\d{20}$"))
#> [1] TRUE
Accuracy_Range_Cleanup(idealista_modified$PRICE,
                       "outside_range",
                       0, Inf)
#> integer(0)
Record_Completeness_Cleanup(idealista_modified,
                            "na_detection",
                            "CONSTRUCTIONYEAR")
#> integer(0)
nrow(Referential_Integrity_Cleanup(idealista_modified,
                                   "verify_integrity",
                                   "OWNER", owners, "OWNER_ID"))
#> [1] 0
all(Risk_Inconsistency_Cleanup(idealista_modified,
                               "detect_duplicates",
                               c("ASSETID", "OWNER"))[["OWNER"]] == 0)
#> [1] TRUE
```
