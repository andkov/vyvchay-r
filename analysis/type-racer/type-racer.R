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
g <- 
  ds0 %>% 
  ggplot(aes(x = Race, y = Points)) + 
  geom_point() +
  geom_line() +
  geom_smooth(method = "lm") +
  scale_x_continuous(breaks = c(1:10),minor_breaks = seq(1,10,1)) +
  labs(
    title = 'Кількість балів за вправу по сліпому друку'
    ,x = 'Номер вправи'
    ,y = 'кількість балів'
    
  )
g
g %>% quick_save('1-typing-2022-11-19', h = 4, w = 6)
# ---- graph-2 -----------------------------------------------------------------
ds1 <- 
  ds0 %>% 
  # janitor::clean_names() %>% 
  filter(Duel == F)  %>% 
  mutate(
     Duel = as.logical(Duel)
     ,Date = as.factor(Date)
  )

ds0 %>% glimpse()
ds1 %>% glimpse()
# ---- graph-3 -----------------------------------------------------------------
ds2 <- 
  ds1 %>% 
  ggplot(aes(x = Date, y = Speed)) +
  geom_boxplot()
ds2
# ---- graph-4 P -----------------------------------------------------------------
ds5 <- 
  ds0 %>% 
  mutate(
    Duel == as.logical(Duel)
  ) %>% 
  filter(Duel == F, Points > 20)

d1 <- 
 ds5 %>% 
  ggplot(aes(y = Speed, x = Points, color = Speed ))  +
  geom_point(size = 1.5)
d1
# ---- graph-5 P -----------------------------------------------------------------
ds6 <- 
  ds0 %>% 
  mutate(
    Duel == as.logical(Duel)
  ) %>% 
  filter(Duel == F, Points < 20)


d2 <- 
  ds6 %>%
  ggplot(aes(x = Points, y = Speed, color = Speed)) +
  geom_point(size = 1.5)
d2  
# ---- graph-6 -----------------------------------------------------------------
ds7 <- 
  ds0 %>% 
  filter(Accuracy > 0.9)

d3 <- 
  ds7 %>% 
  ggplot(aes(x = Accuracy, y = Speed)) +
  geom_point()
  # geom_smooth()
d3
# ---- save-to-disk ------------------------------------------------------------
path <- "./analysis/type-racer/type-racer.Rmd"
rmarkdown::render(
  input = path ,
  output_format=c(
    "html_document"
    # "word_document"
    # "pdf_document"
  ),
  clean=TRUE
)
