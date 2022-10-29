# Fixing the formatting of the pokemon data
library(tidyverse)

# import the scraped dataset
pokedex <- read_csv("pokedex/scraped_pokemon.csv")

### fixing the weight
# can we make "weight" a numeric variable?
pokedex$weight[1]

# fixing weight using the sub function
# ?sub
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
# ?strsplit

height_feet <- strsplit(pokedex$height, split = " ")
pokedex$feet <- pokedex$height
pokedex$inches <- pokedex$height
for (i in 1:150) {
    pokedex$feet[i] <- height_feet[[i]][1]
    pokedex$feet[i] <- sub(
        pattern = "'", replacement = "",
        x = pokedex$feet[i]
    )
    pokedex$inches[i] <- height_feet[[i]][2]
    pokedex$inches[i] <- sub(
        pattern = "\"", replacement = "",
        x = pokedex$inches[i]
    )
}
pokedex$feet <- as.numeric(pokedex$feet)
pokedex$inches <- as.numeric(pokedex$inches)
#convert feet to inches and add to inches and replace in height column
pokedex$height <- pokedex$feet * 12 + pokedex$inches

# remove feet and inches column
pokedex$feet <- NULL
pokedex$inches <- NULL
