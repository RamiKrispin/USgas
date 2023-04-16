# Pulling US Monthly Consumption of Natural Gas

# Source: https://www.eia.gov/opendata/browser/natural-gas/cons/sum?frequency=monthly&data=value;&facets=product;process;&product=EPG0;&process=VRS;&end=2022-12&sortColumn=period;&sortDirection=desc;

eia_key <- Sys.getenv("eia_key")

years <- 1973:2022

url <- "https://api.eia.gov/v2/natural-gas/cons/sum/data/"


# US consumption by sector type

usgas_raw <- lapply(years, function(i){
  print(i)
  gas_meta <- EIAapi::eia_get(api_key = eia_key ,
                              api_url = url,
                              format = "data.frame",
                              facets = list(process = c("VCS",
                                                        "VDV",
                                                        "VEU",
                                                        "VGL",
                                                        "VGP",
                                                        "VGT",
                                                        "VIN",
                                                        "VRS"),
                                            product = "EPG0"),
                              start = paste(i, "-01", sep = ""),
                              end = paste(i + 1, "-01", sep = ""),
                              frequency = "monthly",
                              length = 5000,
                              offset = 0)

  return(gas_meta)

}) |> dplyr::bind_rows()

unique(usgas_raw$units)

usgas_meta <- usgas_raw |>
  dplyr::select(state_raw = `area-name`) |>
  dplyr::distinct() |>
  dplyr::mutate(state_abb = gsub(pattern = "USA-", replacement = "", x = state_raw),
                state_abb = ifelse(state_abb == "CALIFORNIA", "CA", state_abb),
                state_abb = ifelse(state_abb == "COLORADO", "CO", state_abb),
                state_abb = ifelse(state_abb == "OHIO", "OH", state_abb),
                state_abb = ifelse(state_abb == "NEW YORK", "NY", state_abb),
                state_abb = ifelse(state_abb == "FLORIDA", "FL", state_abb),
                state_abb = ifelse(state_abb == "MASSACHUSETTS", "MA", state_abb),
                state_abb = ifelse(state_abb == "WASHINGTON", "WA", state_abb),
                state_abb = ifelse(state_abb == "MINNESOTA", "MN", state_abb),
                state_abb = ifelse(state_abb == "TEXAS", "TX", state_abb),
                state_abb = ifelse(state_abb == "TEXAS", "TX", state_abb),
                state_name = state.name[match(state_abb,state.abb)],
                state_name = ifelse(state_abb == "DC", "District of Columbia", state_name),
                state_name = ifelse(state_abb == "U.S.", "U.S.", state_name))



usgas <- usgas_raw |>
  dplyr::mutate(date = as.Date(paste(period, "-01", sep = ""))) |>
  dplyr::select(date, state_raw = `area-name`,
                # process,
                process = `process-name`,
                y = value) |>
  dplyr::left_join(usgas_meta |>
                     dplyr::select(state_raw, state = state_name, state_abb),
                   by = "state_raw") |>
  dplyr::select(-state_raw) |>
  dplyr::select(date, process, state, state_abb, y) |>
  dplyr::arrange(date, process)

head(usgas)

attr(usgas, "units") <- "MMCF"
attr(usgas, "product_name") <- "Natural Gas"
attr(usgas, "source") <- "EIA API: https://www.eia.gov/opendata/browser/natural-gas"

max(usgas$date)

usethis::use_data(usgas, overwrite = TRUE)
write.csv(usgas, "./csv/usgas.csv", row.names = FALSE)
