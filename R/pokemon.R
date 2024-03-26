#' Pokemon Network (Tidygraph Object)
#'
#' A tidygraph network dataset, containing Pokemon (generations 1-7) as nodes
#' and damage dealt by Pokemon *i* to Pokemon *j* as edges.
#'
#' @format A tidygraph dataset with 801 nodes and 623,979 edges, containing:
#'
#' **Nodes**: A node dataset with 801 nodes and 14 variables:
#'
#' \describe{
#'
#'  \item{**id**: Unique Pokedex ID number for each Pokemon.}
#'
#'  \item{**name**: Unique name of each Pokemon.}
#'
#'  \item{**generation**: Generation in which Pokemon was first introduced.}
#'
#'  \item{**capture_rate**: a number from 0 to 255 used to evaluate likelihood of capturing that Pokemon with a Pokeball.
#'  Higher numbers produce higher likelihoods.}
#'
#'  \item{**type1** & **type2**: respective types of each Pokemon.}
#'
#'  \item{**hp**, **attack**, **defense**, **sp_attack**, **sp_defense**, **speed**: raw base stats at level 1 for each Pokemon.}
#'
#'  \item{**legendary**: binary value indicating whether Pokemon is a legendary Pokemon or not (1 = Yes, 0 = No).}
#'
#'  \item{**image**: the image src link for locating each Pokemon's image in our directory.}
#'
#'  \item{**image_mini**: the download link for each of these images originally.}
#'
#'  \item{**page**: the link to each Pokemon's page on Bulbapedia.}
#'}
#'
#' **Edges**: An edgelist data frame with 623,979 rows and 7 variables:
#'
#' \describe{
#'   \item{**from**: recipient Pokemon, being attacked.}
#'
#'   \item{**to**: opponent Pokemon, attacking the recipient.}
#'
#'   \item{**weakness**: relative weakness of **from** Pokemon to **to** Pokemon,
#'   due to their type(s). Reflects ratio of actual damage received to damage given;
#'   eg. ```weakness = 2.0``` means per unit of damage given, 2 times as much damage is received.
#'   Since, Pokemon only attack with one 'type' at a time, the weakness of Pokemon A to Pokemon B
#'   is calculated using the worst possible pairing of these two types.)}
#'
#'   \item{**damage**: points of damage levied from **to** Pokemon on **from** Pokemon,
#'   from a physical attack (```power = 40```), already incorporating stats and weakness.}
#'
#'   \item{**turns**: minimum number of turns it takes for **to** Pokemon
#'   to defeat the **from** Pokemon with a physical attack (```power = 40```).}
#'
#'   \item{**damage_sp**: points of damage levied from **to** Pokemon on **from** Pokemon,
#'   from a special attack (```power = 40```), already incorporating stats and weakness.}
#'
#'   \item{**turns_sp**: minimum number of turns it takes for **to** Pokemon
#'   to defeat the **from** Pokemon with a special attack (```power = 40```).}
#' }
#'
#' @source Network dataset produced by Tim Fraser: \url{https://rpubs.com/timothyfraser/pokemon_matrix/}
#' @source Original data by Rounak Banik on Kaggle: \url{https://www.kaggle.com/datasets/rounakbanik/pokemon?resource=download}
#' @source Images and damage formula by Bulbapedia contributors: \url{https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_National_Pok%C3%A9dex_number}
#'
#' @examples
#' # Load in the tidygraph object...
#' data("pokemon")
#'
#' # And view the object!
#' pokemon
#'
#' @docType pokemon
#' @name pokemon
NULL
