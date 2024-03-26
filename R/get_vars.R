#' get_vars() Extract variable names from formula
#'
#' This function extracts the outcome and predictor variables as a character string from any formula.
#'

get_vars = function(formula){
  ynames <- as.character(formula)[[2]]
  xnames <- as.character(formula)[[3]] %>% strsplit("[ ]+[+][ ]+") %>% unlist()
  c(ynames, xnames) %>%
    return()
}
