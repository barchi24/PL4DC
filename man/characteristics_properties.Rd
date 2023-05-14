\name{characteristics_properties}
\alias{characteristics}
\alias{properties}

\title{Characteristics and properties covered}

\description{
The data quality characteristics and properties covered are shown below, along with the functions that help to improve them.
}

\section{Accuracy}{
  \itemize{
    \item Syntactic Accuracy
      \itemize{
        \item \code{\link{check_regex}()}
        \item \code{\link{check_regexl}()}
      }
    \item Accuracy Range
      \itemize{
        \item \code{\link{outside_range}()}
        \item \code{\link{check_categories}()}
      }
  }
}

\section{Completeness}{
  \itemize{
    \item Record Completeness
      \itemize{
        \item \code{\link{na_detection}()}
        \item \code{\link{na_imputation}()}
      }
  }
}

\section{Consistency}{
  \itemize{
    \item Referential Integrity
      \itemize{
        \item \code{\link{verify_integrity}()}
        \item \code{\link{derived_column}()}
        \item \code{\link{isDerivedColumnValid}()}
        \item \code{\link{validate_derived_column}()}
      }
    \item Risk of Inconsistency
      \itemize{
        \item \code{\link{detect_duplicates}()}
      }
    \item Format Consistency
      \itemize{
        \item \code{\link{standardize_dates}()}
        \item \code{\link{standardize_dates_table}()}
        \item \code{\link{add_delimiter}()}
        \item \code{\link{change_date_format}()}
      }
  }
}
