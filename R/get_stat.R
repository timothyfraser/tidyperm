#' get_stat()
#'
#' This function takes a model object and returns a tidy data.frame
#' containing model coefficients and goodness of fit statistics, using the broom package.
#'
#' @param model Named model object
#' @return A tibble of coefficients and goodness of fit statistics
#' @export
#' @examples
#'
#' # Load dplyr for pipe
#' library(dplyr)
#'
#' # Use mtcars dataset
#' m1 <- mtcars %>%
#'   # predict horsepower using other covariates
#'   lm(formula = hp ~ cyl + disp)
#'
#' # Extract statistics from model m1
#' m1 %>% get_stat()


get_stat = function(model){
  # Requires dplyr for native pipe
  require(dplyr)

  # Return coefficient stats
  coef <- broom::tidy(model) %>%
    select(term, estimate) %>%
    mutate(type = "coef")

  # Return goodness of fit stats
  gof <- broom::glance(model) %>%
    tidyr::pivot_longer(cols = -c(), names_to = "term", values_to = "estimate") %>%
    mutate(type = "gof")

  # Stack results together in data.frame
  bind_rows(coef, gof) %>%
    as_tibble() %>%
    return()
}


