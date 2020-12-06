#' US Monthly Natural Gas Residential Consumption
#' @description The dataset provides monthly information on the US monthly natural gas residential consumption by state and aggregate level between 1989 and 2020
#'
#' Units: Million Cubic Feet
#'
#'
#' @format A data.frame with 3 variables.
#' \describe{
#'   \item{date}{A Date, the month and year of the observation (the day set by default to 1st of the month) }
#'   \item{state}{A character, the US state indicator}
#'   \item{y}{A numeric, the monthly natural gas residential consumption in a million cubic feet}
#'   }
#' @source US Energy Information Administration (EIA) \href{https://www.eia.gov/}{website}.
#' @keywords datasets timeseries natural gas us state
#' @details The dataset contains monthly summary of the demand for natural gas by residential consumers in the US by state and total aggregate level. The data is available for the state level between January 1989 and September 2020, and for the US level between January 1973 and September 2020.
#'
#' @examples
#' data("us_res_gas")
#'
#' # Subsetting the total consumption in the US
#'
#' us_total <- us_res_gas[which(us_res_gas$state == "U.S."),]
#'
#' us_total <- us_total[order(us_total$date), ]
#'
#' head(us_total)
#'
#' plot(us_total$date, us_total$y,
#'      col = "#1f77b4",
#'      type = "l",
#'      main = "US Natural Gas Residential Consumption",
#'      xlab = "Source: https://www.eia.gov/",
#'      ylab = "Million Cubic Feet")

"us_res_gas"
