#' netboot() Network Node Bootstrap (underlying function)
#'
#' This function implements the network (node) bootstrap algorithm from Snijders and Borgatti (1999),
#' adapting the snowboot package's Rccp code to work for any supplied set of bootstrapped nodes.
#'
#' @param matrix Adjacency matrix (usually as outcome variable)
#' @param boot vector of node names/numbers. These should be bootstrapped (resampled with replacement) before use.
#' @return A bootstrapped adjacency matrix
#' @export
#' @source \url{https://github.com/cran/snowboot/blob/master/src/vertboot_matrix_rcpp.cpp}
#' @source Snijders, Tom A.B., and Borgatti, Stephen P. (1999). Non-Parametric Standard Errors and Tests for Network Statistics. Connections 22(2), 61-70.
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
#' a <- pokemon %>%
#'  # Get matrix of 151 first-gen nodes
#'  filter(generation == 1) %>%
#'  # To extract the matrix
#'  as.igraph() %>%
#'  # Extract directed matrix, with edges weight by damage.
#'  as_adjacency_matrix(type = "both", attr = "damage", edges = FALSE, names = TRUE, sparse = FALSE)
#'
#' # Get bootstrapped sample of names
#' myboot <- colnames(a) %>% sample(replace = TRUE)
#'
#' # Extract bootstrapped matrix
#' netboot(matrix = a, boot = myboot)


# Let's write the network bootstrap function,
# developed by Snijders and Borgatti 1999,
# and implemented in Rccp in the snowboot package
#
# I've directly rewritten in for R here. (Slower, but easily adaptable now)
netboot = function(matrix, boot){

  # Set blank integers
  a <- integer()
  b <- integer()
  # Get number of vertices
  num <- nrow(matrix)

  # Make a blank matrix, filled with zeros
  x1 <- matrix(data = 0, nrow = num, ncol = num)

  # this skips the k by q stuff, which just sets the zeros.
  for(j in 1:num){
    # get the j-th bootstrapped entry
    a = boot[j]

    for(k in 1:num){
      # Get the k-th bootstrapped entry
      b = boot[k]

      # As long as bootstrapped vertex a is not b,
      if(a != b){
        # Grab the value of the original matrix at spot a,b
        # and fill in the corresponding spot in new matrix x1
        x1[j, k] <- matrix[a,b]
      }else{
        # But if a DOES equal b,
        # then...
        # reset a to a new vertex
        a = num %>% sample(1)
        # reset b to a new vertex
        b = num %>% sample(1)

        # As long as a still equals b,
        while(a == b){
          # grab a new vertex for b
          b = num %>% sample(1)
        }

        # Once it obtains a non-match,
        # fill in both dyads in the original loop
        # with the new dyad value.
        x1[j,k] <- matrix[a,b]
        x1[k,j] <- matrix[a,b]

      }

    }

  }

  return(x1)
}
