rm(list = ls(all.names = TRUE)) # Clears environment
cat("\014")                     # Clears console
# ---- load-sources ------------------------------------------------------------
source("./scripts/common-functions.R") # helpers (functions + settings)

# ---- load-packages -----------------------------------------------------------
library(tidyverse)
library(googlesheets4) # data import

# ---- declare-globals ---------------------------------------------------------

# ---- declare-functions -------------------------------------------------------
# figures will be printed into the following folder:
prints_folder <- paste0("./analysis/type-racer/prints/")
if (!fs::dir_exists(prints_folder)) { fs::dir_create(prints_folder) }
# ---- load-data ---------------------------------------------------------------
googlesheets4::gs4_deauth() # to indicate there is no need for a access token
# https://googlesheets4.tidyverse.org/ 
sheet_name <- "1q9OeCZ6Hk_6VOXOuTLegP9C1tmAVydGuH0_z3bV-3TA"
tab_name <- "sasha"
ds0 <- read_sheet(sheet_name,tab_name,skip = 0)
# ---- inspect-data ------------------------------------------------------------
ds0
# ---- tweak-data --------------------------------------------------------------
# ---- graph-1 -----------------------------------------------------------------
# ---- save-to-disk ------------------------------------------------------------
path <- "./analysis/.../report-isolated.Rmd"
rmarkdown::render(
  input = path ,
  output_format=c(
    "html_document"
    # "word_document"
    # "pdf_document"
  ),
  clean=TRUE
)
