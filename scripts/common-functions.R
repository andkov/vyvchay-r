# Functions loaded by EVERY script in the project
library(ggplot2)

baseSize <- 10 # common font size

print_all <- function(d){ print(d,n=nrow(d)) }

# set a theme applied to each graph by default
ggplot2::theme_set(
  ggplot2::theme_bw(
  )+
    ggplot2::theme(strip.background = element_rect(fill="grey95", color = NA))+
    ggplot2::theme(title             = ggplot2::element_text(color="gray20")) +
    ggplot2::theme(axis.text         = ggplot2::element_text(color="gray40")) +
    ggplot2::theme(axis.title        = ggplot2::element_text(color="gray40")) +
    ggplot2::theme(panel.border      = ggplot2::element_rect(color="gray80")) +
    ggplot2::theme(axis.ticks        = ggplot2::element_blank()) +
    # ggplot2::theme(legend.position   = "none")+
    ggplot2::theme(strip.background  = element_rect(fill="grey95", color = NA))
)
# alternative custom theme that can be applied to a given plot
repo_theme <- function( base_size = 8 ) {
  ggplot2::theme_light(base_size=base_size) +
    ggplot2::theme(title             = ggplot2::element_text(color="gray20")) +
    ggplot2::theme(axis.text         = ggplot2::element_text(color="gray40")) +
    ggplot2::theme(axis.title        = ggplot2::element_text(color="gray40")) +
    ggplot2::theme(panel.border      = ggplot2::element_rect(color="gray80")) +
    ggplot2::theme(axis.ticks        = ggplot2::element_blank()) +
    ggplot2::theme(legend.position   = "none")
  ggplot2::theme(strip.background  = element_rect(fill="grey95", color = NA))
}

quick_save <- function(g,name,...){
  ggplot2::ggsave(
    filename = paste0(name,".png"),
    plot     = g,
    # device   = "jpg",
    path     = prints_folder,
    # width    = width,
    # height   = height,
    # units = "cm",
    # dpi      = 'retina',
    limitsize = FALSE,
    ...
  )
}

# adds neat styling to your knitr table
neat <- function(x, output_format = "html"){
  # knitr.table.format = output_format
  if(output_format == "pandoc"){
    x_t <- knitr::kable(x, format = "pandoc")
  }else{
    x_t <- x %>%
      # x %>%
      # knitr::kable() %>%
      knitr::kable(format=output_format) %>%
      kableExtra::kable_styling(
        bootstrap_options = c("striped", "hover", "condensed","responsive"),
        # bootstrap_options = c( "condensed"),
        full_width = F,
        position = "left"
      )
  }
  return(x_t)
}
# ds %>% distinct(id) %>% count() %>% neat(10)

# adds a formated datatable
neat_DT <- function(x, filter_="top",...){
  
  xt <- x %>%
    as.data.frame() %>%
    DT::datatable(
      class   = 'cell-border stripe'
      ,filter  = filter_
      ,options = list(
        pageLength = 6,
        autoWidth  = FALSE
      )
      , ...
    )
  return(xt)
}