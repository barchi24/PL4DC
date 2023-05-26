\name{characteristics_properties}
\alias{characteristics}
\alias{properties}
\alias{cleaning_methods}

\title{Characteristics and properties covered}

\description{
The data quality characteristics and properties covered are shown below, along with the primitives and functions that help to improve them.
}

\section{Accuracy (Exactitud)}{
  \itemize{
    \item Syntactic Accuracy (Exactitud Sintactica)
      \itemize{
        \item \code{\link{check_regex}()}
        \item \code{\link{check_regexl}()}
      }
    \item Accuracy Range (Rango de Exactitud)
      \itemize{
        \item \code{\link{outside_range}()}
        \item \code{\link{check_categories}()}
      }
  }
}

\section{Completeness (Completitud)}{
  \itemize{
    \item Record Completeness (Completitud de Registro)
      \itemize{
        \item \code{\link{na_detection}()}
        \item \code{\link{na_imputation}()}
      }
  }
}

\section{Consistency (Consistencia)}{
  \itemize{
    \item Referential Integrity (Integridad Referencial)
      \itemize{
        \item \code{\link{verify_integrity}()}
        \item \code{\link{derived_column}()}
        \item \code{\link{isDerivedColumnValid}()}
        \item \code{\link{validate_derived_column}()}
      }
    \item Risk of Inconsistency (Riesgo de Inconsistencia)
      \itemize{
        \item \code{\link{detect_duplicates}()}
      }
    \item Format Consistency (Consistencia de Formato)
      \itemize{
        \item \code{\link{standardize_dates}()}
        \item \code{\link{standardize_dates_table}()}
        \item \code{\link{add_delimiter}()}
        \item \code{\link{change_date_format}()}
      }
  }
}
