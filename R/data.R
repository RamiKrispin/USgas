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
#' data("us_residential")
#'
#' # Subsetting the total consumption in the US
#'
#' us_total <- us_residential[which(us_residential$state == "U.S."),]
#'
#' us_total <- us_total[order(us_total$date), ]
#'
#' head(us_total)
#'
#' at_x <- seq.Date(from = as.Date("1980-01-01"),
#'                  to = as.Date("2020-01-01"),
#'                  length.out = 5)
#'
#' at_y <- pretty(us_total$y)[c(2, 4, 6)]
#'
#' plot(us_total$date, us_total$y,
#'      col = "#1f77b4",
#'      type = "l",
#'      frame.plot = FALSE,
#'      axes = FALSE,
#'      panel.first = abline(h = at_y, col = "grey80"),
#'      main = "US Natural Gas Residential Consumption",
#'      xlab = "Source: https://www.eia.gov/",
#'      ylab = "Million Cubic Feet")
#'
#'
#'
#' mtext(side =1, text = format(at_x, format = "%Y %b"), at = at_x,
#'       col = "grey20", line = 1, cex = 0.8)
#'
#' mtext(side =2, text = format(at_y, scientific = FALSE), at = at_y,
#'       col = "grey20", line = 1, cex = 0.8)
#'
#' ### Plotting the west cost consumption
#' # Subsetting the west cost states
#' wc_gas <- us_residential[which(us_residential$state %in%
#'                              c("Alaska", "California",
#'                                "Oregon", "Washington")),]
#'
#' # Reshape to wide
#' wc_wide <- reshape(wc_gas, v.names = "y", idvar = "date",
#'                    timevar = "state", direction = "wide")
#'
#' names(wc_wide) <- c("date","Alaska", "California",
#'                     "Oregon", "Washington")
#' # Reorder the data
#' wc_wide <- wc_wide[order(wc_wide$date), ]
#'
#' # Set the plot y and x axis ticks
#' at_x <- seq.Date(from = as.Date("1990-01-01"),
#'                  to = as.Date("2020-01-01"),
#'                  length.out = 4)
#'
#' at_y <- pretty(wc_gas$y)[c(2, 4, 6)]
#'
#' # plot the first series
#' plot(wc_wide$date, wc_wide$Alaska,
#'      type = "l",
#'      frame.plot = FALSE,
#'      axes = FALSE,
#'      panel.first = abline(h = c(at_y), col = "grey80"),
#'      main = "West Cost Natural Gas Residential Consumption",
#'      cex.main = 1, font.main = 1, col.main = "black",
#'      xlab = "Source: https://www.eia.gov/",
#'      font.axis = 1, cex.lab= 0.7,
#'      ylab = "Million Cubic Feet",
#'      ylim = c(min(wc_gas$y, na.rm = TRUE), max(wc_gas$y, na.rm = TRUE)))
#'
#' # Add the 3 other series
#' lines(wc_wide$date, wc_wide$California, col = "#1f77b4")
#' lines(wc_wide$date, wc_wide$Oregon, col = "#457b9d")
#' lines(wc_wide$date, wc_wide$Washington, col = "#ef476f")
#'
#' # Add the y and x axis ticks
#' mtext(side =1, text = format(at_x, format = "%Y %b"), at = at_x,
#'       col = "grey20", line = 1, cex = 0.8)
#'
#' mtext(side =2, text = format(at_y, scientific = FALSE), at = at_y,
#'       col = "grey20", line = 1, cex = 0.8)
#'
#' text(tail(wc_wide$date, 10)[1],
#'      max(wc_gas$y, na.rm = TRUE),
#'      "California",
#'      col = "#1f77b4",
#'      cex = 0.6)
#'
#' text(tail(wc_wide$date, 10)[1],
#'      max(wc_gas$y, na.rm = TRUE) - 5000,
#'      "Washington",
#'      col = "#ef476f",
#'      cex = 0.6)
#'
#' text(tail(wc_wide$date, 10)[1],
#'      max(wc_gas$y, na.rm = TRUE) - 10000,
#'      "Oregon",
#'      col = "#457b9d",
#'      cex = 0.6)
#'
#' text(tail(wc_wide$date, 10)[1],
#'      max(wc_gas$y, na.rm = TRUE) - 15000,
#'      "Alaska",
#'      col = "black",
#'      cex = 0.6)


"us_residential"
