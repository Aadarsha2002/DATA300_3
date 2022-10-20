# Fixing the formatting of the pokemon data
library(tidyverse)

# import the scraped dataset
pokedex <- read_csv("pokedex/scraped_pokemon.csv")

# fixing the weight
# can we make "weight" a numeric variable?
pokedex$weight[1]

# fixing weight using the sub function
?sub
sub(pattern = " lbs", replacement = "", x = pokedex$weight[1])
sub(pattern = " lbs", replacement = "", x = pokedex$weight)
as.numeric(sub(
    pattern = " lbs", replacement = "",
    x = pokedex$weight
))

# replace the original variable with the numeric version
pokedex$weight <- as.numeric(sub(
    pattern = " lbs", replacement = "",
    x = pokedex$weight
))

# plot the distribution of pokemon weights
ggplot(data = pokedex, aes(x = weight)) +
    geom_histogram()

### Fixing the height
# a single numeric variable measured in consistent units
pokedex$height[1]

# split our heights into feet and inches
?strsplit
strsplit(pokedex$height[1], split = " ")[[1]][1] # double square brackets for manipulating lists

height_feet <- strsplit(pokedex$height, split = " ")

head(height_feet)


