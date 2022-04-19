rm(list = ls(all.names = TRUE)) # clear the environment
cat("\014") # clear the console
library(tidyverse)

# ----- 1 ----------------------------------------------------------------------
v1 <- c("turtle", "snail", "butterfly")
v2 <- c("unhappy", "ok", "awesome")
v3 <- c(TRUE, FALSE, T, F)
v4 <- c(3.1, .89, .07)
v5 <- c(4, 0, 6, 8)

d6 <- 
  tibble(
    "animal"   = v1
    ,"feeling" = v2
    ,
)
d6

l7 <- 
  list(
    "animal"   = v1
    ,"weight"  = v4
  )

l7 %>% as_tibble()
l7 %>% bind_cols()

