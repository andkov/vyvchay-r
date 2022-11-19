rm(list = ls(all.names = TRUE)) # clear the environment
cat("\014") # clear the console
# ---- load-sources ------------------------------------------------------------
source("./scripts/common-functions.R") 

# ---- load-packages -----------------------------------------------------------
library(magrittr)  # pipes
library(dplyr)     # data wrangling
library(ggplot2)   # graphs
library(janitor)   # tidy data
library(tidyr)     # data wrangling
library(forcats)   # factors
library(stringr)   # strings
library(lubridate) # dates
library(gapminder)

# ---- declare-globals ---------------------------------------------------------

# ---- declare-functions -------------------------------------------------------
prints_folder <- paste0("./analysis/gapminder/prints-1/")
if (!fs::dir_exists(prints_folder)) {
  fs::dir_create(prints_folder)
}

# ---- load-data ---------------------------------------------------------------
ds_geo <- readr::read_csv("./data-public/metadata/world-geography.csv")
ds <- gapminder::gapminder
ds %>% glimpse()

# ---- inspect-data ------------------------------------------------------------

ds %>% 
  group_by(country) %>% count() %>% print_all()

ds %>% neat_DT()


# ---- tweak-data --------------------------------------------------------------


# ---- table-1 -----------------------------------------------------------------


# ---- graph-1 -----------------------------------------------------------------


# ---- graph-2 -----------------------------------------------------------------

# ---- save-to-disk ------------------------------------------------------------
path <- "./analysis/gamminder/gapminder-1.Rmd"
rmarkdown::render(
  input = path ,
  output_format=c(
    "html_document"
    # "word_document"
    # "pdf_document"
  ),
  clean=TRUE
)
