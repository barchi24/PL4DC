test_that("Test standardize_dates function with valid input", {
  dates <- c("12/31/2020", "01/01/2021")
  expect_equal(standardize_dates(dates, input_format = c("mdy"), output_format = "%Y-%m-%d"), c("2020-12-31", "2021-01-01"))
})

test_that("Test standardize_dates function with invalid input format", {
  dates <- c("12/31/2020", "01/01/2021")
  expect_warning(standardize_dates(dates, input_format = c("myd"), output_format = "%Y-%m-%d"), "No formats found")
})
