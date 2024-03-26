#' get_names() Extract node names from graph
#'
#' This function extracts a designated vector of nodes from a tidygraph object,
#'  or generates a set from 1 to n nodes if not provided.
#'

get_names = function(graph, names = NULL){
  # If there is no name,
  # make a name based on rownumber
  if(is.null(names)){
    names <- graph %>%
      mutate(name = 1:n()) %>%
      as_tibble() %>%
      .$name
  }else if(!is.null(names) ){
    names <- graph %>%
      as_tibble() %>%
      select(!!sym(names)) %>%
      unlist() %>% unname()
  }
  return(names)
}
