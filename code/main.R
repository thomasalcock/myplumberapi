library(plumber)
library(dplyr)
library(janitor)
df <- readRDS("data/real_estate_data.RDS")
df <- janitor::clean_names(df)

#' @title Gets data for shiny app
#' @param min_sq_ft
#' @param max_price
#' @get /getdata

function(min_sq_ft, max_price){
  
  min_sq_ft <- as.numeric(min_sq_ft)
  max_price <- as.numeric(max_price)
  
  df %>% 
    dplyr::filter(
      lot_area >= min_sq_ft &
      sale_price <= max_price
    ) %>% 
    dplyr::select(
      lot_area,
      dplyr::starts_with("sale")
    )
}
