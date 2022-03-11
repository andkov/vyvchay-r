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
library(TeachingDemos)

# ---- declare-globals ---------------------------------------------------------

# ---- declare-functions -------------------------------------------------------
prints_folder <- paste0("./lessons/lesson-01/prints/")
if(!file.exists(prints_folder)){
  dir.create(file.path(prints_folder))
}

# ---- load-data ---------------------------------------------------------------


# ---- inspect-data ------------------------------------------------------------


# ---- tweak-data --------------------------------------------------------------


# ---- table-1 -----------------------------------------------------------------


# ---- graph-1 -----------------------------------------------------------------


# ---- graph-2 -----------------------------------------------------------------

# ---- save-to-disk ------------------------------------------------------------
path <- "./lesson-01/lesson-01.Rmd"
rmarkdown::render(
  input = path ,
  output_format=c(
    "html_document"
    # "word_document"
    # "pdf_document"
  ),
  clean=TRUE
)
