#' get_boot() Node Bootstrap for Networks
#'
#' This function implements the network (node) bootstrap algorithm from Snijders and Borgatti (1999),
#' adapting the snowboot package's Rccp code to work for any supplied set of bootstrapped nodes.
#'
#' [get_boot()] serves as a wrapper function for [netboot()], allowing you to run [netboot()] *i* many times while extracting quantities of interest.
#'
#' @param m observed model
#' @param matrix Adjacency matrix (usually as outcome variable)
#' @param i counter of replicates, returned as replicate id.
#' @export
#'
#' @source \url{https://github.com/cran/snowboot/blob/master/src/vertboot_matrix_rcpp.cpp}
#' @source Snijders, Tom A.B., and Borgatti, Stephen P. (1999). Non-Parametric Standard Errors and Tests for Network Statistics. Connections 22(2), 61-70.
#'
#' @examples
#'
#' # Load Packages
#' library(tidyperm)
#' library(igraph)
#' library(tidygraph)
#'
#' # Import pokemon network
#' data("pokemon")
#'
#' pokemon <- pokemon %>%
#'   # Get matrix of 151 first-gen nodes
#'   filter(generation == 1) %>%
#'   # Average damage inflicted on recipients by this Pokemon
#'   mutate(damage_mean = centrality_degree(
#'          weights = .E()$damage, loops = TRUE, mode = "in") / n())
#'
#' # Get adjacency matrix a
#' a <- pokemon %>%
#'   # To extract the matrix
#'   as.igraph() %>%
#'   # Extract directed matrix, with edges weight by damage.
#'   as_adjacency_matrix(type = "both", attr = "damage", edges = FALSE, names = TRUE, sparse = FALSE)
#'
#' # Estimate model m
#' m <- pokemon %>%
#'  # Extract nodes and convert to tibble
#'  activate("nodes") %>% as_tibble() %>%
#'  # Model dataframe!
#'  lm(formula = damage_mean ~ base_total + capture_rate + legendary + dragon)
#'
#' # For ten times (i),
#' 1:10 %>%
#'  # run node bootstrap on matrix a and model m
#'    map_dfr(~get_boot(m, a, i = .), .id = "replicate")
#'
#'

# Let's design the full process for the bootstrap resampler now
get_boot = function(m, matrix, i){

  print(i)

  # FIX ME
  # Extract model coefficients, then wipe them.
  out <- get_stat(m)
  out$estimate <- NA

  # Get number of coefficients
  # As long as this is still true, please repeat this loop
  while(sum(is.na(out$estimate)) > 0){

    # Randomly resample with replacment, using network bootstrap
    # Resample with replacement column names
    boot <- 1:nrow(matrix) %>% sample(replace = TRUE)

    # Get bootstrapped matrix
    ahat <- netboot(matrix, boot)

    ghat <- ahat %>%
      graph_from_adjacency_matrix(diag = TRUE, mode = "directed", weighted = "damage") %>%
      as_tbl_graph() %>%
      mutate(m$model[boot, ]) %>%
      # Now recalculate damage mean using the bootstrapped network
      mutate(damage_mean = centrality_degree(weights = .E()$damage, loops = TRUE, mode = "in") / n())

    # Get model coefficients
    modelhat <- ghat %>%
      activate("nodes") %>%
      as_tibble() %>%
      `rownames<-`(value = .$name) %>%
      lm(formula = damage_mean ~ base_total + capture_rate + legendary + dragon)

    out <- modelhat %>%
      get_stat()

  }

  out %>%
    return()

}
