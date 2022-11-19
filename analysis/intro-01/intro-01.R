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
prints_folder <- paste0("./analysis/intro-01/prints/")
if (!fs::dir_exists(prints_folder)) { fs::dir_create(prints_folder) }
# ---- load-data ---------------------------------------------------------------
googlesheets4::gs4_deauth() # to indicate there is no need for a access token
# https://googlesheets4.tidyverse.org/ 
sheet_name <- "1U7iRYmFPTtgQTbvmu1AR5fHraaF2IUGMZr8j41h6L5Y"
tab_name <- "cities-top-20"
uatop20 <- read_sheet(sheet_name,tab_name,skip = 0)
# ---- inspect-data ------------------------------------------------------------
uatop20
# area_km2 - total city area in square kilometers
# ua_pop_2001 - percent Ukrainians according to the 2001 census
# pop_2001 - urban population according to 2001 census 
# ---- tweak-data --------------------------------------------------------------
ds0 <- 
  uatop20 %>% 
  mutate_at(
      .vars  = c("year_founded","pop_2001","pop_2014","pop_2020")
      ,.funs = as.integer
  ) #%>% 
  # select(-c("oblast"))#, "area_km2", "pop_2014", "pop_2020")) 

# ---- graph-1 -----------------------------------------------------------------
ds0

library(ggrepel)
g1 <- 
  ds0 %>% 
  mutate(
    founded_before_1500 = year_founded > 1500
  ) %>% 
  ggplot(aes(x=year_founded, y = ua_pop_2001, color = founded_before_1500))+
  ggrepel::geom_text_repel(aes(label = misto),size=5)+
  ggrepel::geom_text_repel(aes(label = year_founded), alpha = .8, color="black")+
  geom_point(aes(size =pop_2001), alpha = .5)+
  theme(
    legend.position = "bottom"
  )

g1
g1 %>% 
  ggsave(
    filename = "./analysis/intro-01/1-age-pct_ua.png"
    ,width = 29.7
    ,height = 21.0
    ,units = "mm"
  )

# ---- graph-2 -----------------------------------------------------------------
ds0 %>% arrange(area_km2)

ds0 %>% 
  pivot_longer(
    cols = paste0("pop_",c("2001","2014","2020"))
    ,names_to = "year"
    ,values_to = "population_count"
  ) %>% 
  mutate(
    year = year %>% str_remove("pop_") %>% as.integer()
  ) %>%
  {ggplot(., aes(x=year, y = population_count, group=misto))+
      geom_point()+
      geom_line()+
      geom_text(aes(label = misto), data = . %>% filter(year==2020), x=2022)+
      scale_x_continuous(expand=expansion(add=4))
    
  }
  

# ---- graph-4 ----------------------------------------------------------------
    # cols = c(paste0("pop_20",c("01","14","20")))
ds0 
ds0 %>% 
  mutate(
    density = pop_2001/area_km2
  ) %>% 
  ggplot(aes(x=density, y = ua_pop_2001))+
  geom_point()+
  geom_text(aes(label=misto))

# ----- g5 ----------------------------
library(ggrepel)
g1 <- 
  ds0 %>% 
  mutate(
    founded_before_1500 = year_founded > 1500
  ) %>% 
  ggplot(aes(x=year_founded, y = ua_pop_2001, color = founded_before_1500))+
  ggrepel::geom_text_repel(aes(label = misto),size=5,force = .6)+
  ggrepel::geom_text_repel(aes(label = year_founded), alpha = .8, color="black")+
  geom_point(aes(size =pop_2001), alpha = .5)+
  theme(
    legend.position = "bottom"
  )

g1
g1 %>% 
  ggsave(
    filename = "./analysis/intro-01/5-age-pct_ua.png"
    ,width = 297
    ,height = 210
    ,units = "mm"
  )

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
