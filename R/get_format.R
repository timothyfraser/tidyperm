#' get_format() Transform Adjancey Matrices into Modelable Data
#'
#' This function transforms an array of adjacency matrices into modelable data using a preset or custom function.
#'
#'
#' @param data an array of adjacency matrices, produced by [get_adj()].
#' @param type (Optional) string describing what preset format to convert matrices to. Options: ```"edgewise"```, or NULL.
#' @param myfun (Optional) name of custom-made function. Used when type is not specified.

get_format = function(data, type = NULL, myfun = NULL){
  # If no function specified, just return the data as is (as an adjacency matrix)
  if(is.null(myfun)){

    # If you specify edgewise, we'll automatically convert the set of matrices into a matrix
    if(type == "edgewise"){
      # Get names of variables
      vars <- attr(data, "dimnames")[[3]]
      # Get dimensions of array
      mydim <- dim(data)
      # Get rectangular edgewise-dataset
      data %>%
        matrix(., nrow = mydim[1] * mydim[2], ncol = mydim[3]) %>%
        `colnames<-`(vars) %>% return()
    }else{
      # Otherwise, just return the data
      return(data)
    }
    # Other-Otherwise,
  }else{
    # Do whatever transformations on array of adjacency matrices necessary
    myfun(data) %>% return()
  }
}
