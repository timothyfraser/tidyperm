# Timothy Fraser
# June 28, 2022
# tidyperm package

# a new simple package for making
# your own easily adjustable network permutation models.

# https://tinyheero.github.io/jekyll/update/2015/07/26/making-your-first-R-package.html

# We're going to try and build as small an R package as possible!

# Install devtools and roxygen for building the package
# install.packages(c("devtools", "roxygen"))

library(devtools)
library(roxygen2)

#devtools::create("tidyperm")
# Move contents of tidyperm to main directory
# Delete project.Rproj, keeping tidyperm.Rproj

# Specify imports in DESCRIPTION file
# eg. Imports:
#       data.table (>= 1.9.4),
#       dplyr



##############################################
# Tell R to ignore these files when building
##############################################
use_build_ignore(
  files = c(
    "extra/package_builder.R",
    "extra/edgelist.csv",
    "extra/nodes.csv",
    "extra/pokemon.rds"))



# To document your functions
document()
# Try it out
# Temporary Install
load_all()
# Permanent Install
install()
# Remove Package
remove.packages("tidyperm")

?get_stat
?netboot
?get_boot
?pokemon









######################
# Test run
######################
?get_stat()
library(dplyr)
m1 <- mtcars %>%
  lm(formula = hp ~ cyl + disp)
m1 %>% get_stat()
######################



##########################################
# Build a vignette
##########################################
use_vignette("pokemon_dataset")

use_vignette("qap")


#######################
# Add data
#######################
library(readr)
library(dplyr)
library(tidygraph)
# Add Pokemon tidygraph network as a cute example dataset

# Import edges from .csv file
edges <- read_csv("extra/edgelist.csv")
# Import nodes from .csv file
nodes <- read_csv("extra/nodes.csv")
# Import network as a directed network, with the name column being the unique ID
tbl_graph(nodes = nodes, edges = edges, directed = TRUE, node_key = "name") %>%
  # Add a simple classifier
  mutate(dragon = if_else(type1 == "dragon" | type2 == "dragon", 1, 0, missing = 0),
  # calculate total base stats
  base_total = hp + attack + defense + sp_attack + sp_defense + speed) %>%
  saveRDS("extra/pokemon.rds")

pokemon <- read_rds("extra/pokemon.rds")


#data("pokemon")


# Save each individually to data folder
use_data(pokemon, edges, nodes, internal = FALSE)
use_data(pokemon, internal = FALSE, overwrite = TRUE)
rm(list = ls())
#######################


