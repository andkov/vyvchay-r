rm(list = ls(all.names = TRUE)) # environment 
cat("\014") # clear the console
library(tidyverse)

v1 <- c("turtle", "snail", "butterfly")

v3 <- c(TRUE, FALSE, T, F)

v4 <- c(3.1, .89, .07) %>% as.double()

v5 <- c(4, 0, 6, 8, 32) %>% as.integer()

d6 <- 
  tibble(
    "animal"   = v1
    ,"weight"  = v4
    ,
  )
d6

l7 <- 
  list(
    "animal"   = v1
    ,"feet"    = v5
  )


length(v5)
class(v5)
