#' get_adj() Extract adjacency matrices for given variables from tidygraph objects
#'
#' This function extracts an array of adjacency matrices, of dimension n x n x k,
#' where k is the number of variables supplied in ```myvars```.

get_adj = function(graph, vars, names = NULL){
  require(dplyr)
  require(tidygraph)
  require(igraph)

  # Set to nodes
  graph <- graph %>% activate("nodes")

  n <- get_n(graph)
  names <- get_names(graph, names = names)

  # Make an array to hold the results
  a <- array(NA, dim = c(n,n, length(vars)), dimnames = list(names, names, vars))

  # Extract directed matrix, with edges weighted by variable
  i <- NULL
  for(i in vars){
    a[,,i] <- graph %>%
      # Super speedy to extract sparse matrix
      as_adj(type = "both", attr = i) %>%
      # Then convert to normal matrix
      as.matrix()
  }
  remove(i)
  return(a)
}
