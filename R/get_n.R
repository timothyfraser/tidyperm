#' get_n() Extract number of nodes from graph
#'
#' This function extracts the number of nodes from any tidygraph object.
#'

get_n = function(graph){
  # Extract number of nodes from graph
  n <- graph %>% as_tibble() %>% nrow()
  return(n)
}
