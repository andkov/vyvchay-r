rm(list=ls(all=TRUE))
# ---- load-packages -----------------------------------------------------------
library(magrittr) #Pipes
library(dplyr) #

# ---- load-sources ------------------------------------------------------------
config <- config::get()
path_input_geo <- "./data-public/raw/country-and-continent-codes-list.csv"
path_input_oecd <- "./data-public/raw/country-oecd.csv"
# path_input_geo <- "https://gist.githubusercontent.com/DrSterling/92555a008e9c61c30d536269752396c1/raw/13716ceb2f22b5643ce5e7039643c86a0e0c6da6/country-and-continent-codes-list-csv.csv"
# path_input_oecd <- "https://raw.githubusercontent.com/andkov/vada-2020-summer-school/master/data-public/metadata/country_oecd.csv"
# ---- load-data --------------
#  from OECD database
ds_oecd <- readr::read_csv(path_input_oecd)

# https://datahub.io/JohnSnowLabs/country-and-continent-codes-list
ds_geo <- readr::read_csv(path_input_geo)

ds_geo %>% readr::write_csv("./data-public/raw/country-and-continent-codes-list.csv")
ds_oecd %>% readr::write_csv("./data-public/raw/country-oecd.csv")

# ----- tweak-data --------------------
names(ds_geo) <- names(ds_geo) %>% snakecase::to_snake_case()
ds_geo %>% glimpse()

# manual corrections to optimize the dispaly utility
ds_geo <- 
  ds_geo %>%
  # distinct(three_letter_country_code, country_name) %>%
  dplyr::mutate(
    # correct due to encoding
    country_name = ifelse(three_letter_country_code  == "ALA", "Aland Islands", country_name)
    ,country_name = ifelse(three_letter_country_code == "CUW", "Curasao", country_name)
  ) %>%
  mutate(
    # remove lenthy titles
    country_label = gsub("(.+),(.+)","\\1" , country_name),
    country_label = gsub("(.+)( \\()(.+)", "\\1", country_label)
  ) %>%
  dplyr::mutate(
    # correct for display utility
    country_label  = ifelse(three_letter_country_code == "LAO", "Laos", country_label)
    ,country_label = ifelse(three_letter_country_code == "GBR", "United Kingdom", country_label)
    ,country_label = ifelse(three_letter_country_code == "USA", "United States", country_label)
    ,country_label = ifelse(three_letter_country_code == "VIR", "US Virgin Islands", country_label)
    ,country_label = ifelse(three_letter_country_code == "UMI", "US Minor Outlying Islands", country_label)
    ,country_label = ifelse(three_letter_country_code == "KOR", "Korea S", country_label)
    ,country_label = ifelse(three_letter_country_code == "PRK", "Korea N", country_label)
    ,country_label = ifelse(three_letter_country_code == "RUS", "Russia", country_label)
  )

# inspect new, corrected labels (country_label)
d <- 
  ds_geo %>%
  distinct(country_name, three_letter_country_code, country_label)

ds_geo <- 
  ds_geo %>%
  rename(
    "country_code"   = "three_letter_country_code"
    ,"country_code2" = "two_letter_country_code"
  ) %>%
  dplyr::mutate(
    # add marker for an OECD country (refer to input from config$path_country )
    oecd = country_code %in% (ds_oecd %>% filter(desired) %>% pull(country_code) )
    # custom label tweaks
    ,continent_code = ifelse(continent_name == "North America","NAM", continent_code) # misreads as an "NA"
  )

# some countries will be grouped to two continents:
d_2continents <- 
  ds_geo %>%
  distinct(country_code, country_label, continent_name) %>%
  group_by(country_code,country_label) %>%
  count() %>%
  filter(n>1) %>%
  dplyr::left_join(
    ds_geo %>% distinct(country_label, continent_name)
  )
d_2continents
# Remove duplicate continent
ds_geo <- 
  ds_geo %>%
  dplyr::filter(
    !(country_code == "ARM" & continent_name == "Asia"),
    !(country_code == "AZE" & continent_name == "Asia"),
    !(country_code == "CYP" & continent_name == "Asia"),
    !(country_code == "GEO" & continent_name == "Asia"),
    !(country_code == "KAZ" & continent_name == "Europe"),
    !(country_code == "RUS" & continent_name == "Asia"),
    !(country_code == "TUR" & continent_name == "Asia"),
    !(country_code == "UMI" & continent_name == "Oceania"),
  )

ds_geo %>% readr::write_csv("./data-public/metadata/world-geography.csv")
