# web scraping example 2

# set working directory
#setwd("/Users/nickdietrich/Dropbox/Data Analytics SP 2021/Methods/Week 9 - Web Scraping")

# load our web access package
library(rvest)

# choose the webpage
url <- "https://www.pokemon.com/us/pokedex/1"

# load the html of the webpage into R
webpage <- read_html(url)
html_text(webpage)

# view the elements on the webpage
?html_elements
attributes <- html_elements(webpage,".attribute-value") # search elements by title

attribute_text <- html_text(attributes)
attribute_text

height <- attribute_text[1]
weight <- attribute_text[2]
height
weight

?grepl

grep(pattern="lbs",x=attribute_text)
weight <- attribute_text[grep(pattern="lbs",x=attribute_text)]
weight

grepl(pattern="lbs",x=attribute_text)
weight <- attribute_text[grepl(pattern="lbs",x=attribute_text)]
weight

as.numeric(strsplit(weight, split=" ")[[1]][1])

as.numeric(sub(pattern=" lbs",replacement="",x=weight))

?gregexpr

elements <- webpage %>% html_elements(".attribute-value") %>%
  html_text()
elements

weight

rank <- nodes %>% 
  xml2::xml_find_all("Weight")


# example for loop
urls <- paste0("https://pokemon.com/us/pokedex/",1:150)
urls

# a simple loop that prints numbers in order
for(i in 1:150){
  print(i)
}

# a modified loop that prints our URLs
for(i in 1:150){
  print(urls[i])
  Sys.sleep(3) # pause for a few seconds
}

### Loop through all pokemon

urls <- paste0("https://pokemon.com/us/pokedex/",1:150)
urls

height <- numeric(length=length(urls))
weight <- numeric(length=length(urls))
for(url in urls){
  # load the html of the webpage into R
  webpage <- read_html(url)
  
  # extract elements
  attributes <- html_elements(webpage,".attribute-value")
  
  # pull out the text
  attribute_text <- html_text(attributes)
  
  # pull out the height and the weight
  height[which(urls==url)] <- attribute_text[1]
  weight[which(urls==url)] <- attribute_text[2]
}
height
weight


# example text manipulation dataset for class
pokemon_scrape <- data.frame(url=urls,height=height,weight=weight)
library(tidyverse)
write_csv(pokemon_scrape,"scraped_pokemon.csv")




###
### formatting the dataset
###

feet <- as.numeric(sapply(strsplit(height,split="'"), "[[", 1))
inches <- sapply(strsplit(height,split=" "), "[[", 2)
inches <- as.numeric(strsplit(inches,split="\""))
height_inches <- feet*12+inches
weight <- as.numeric(sub(pattern=" lbs",replacement="",x=weight))

pokedex <- data.frame(height_inches=height_inches,weight=weight)


library(ggplot2)
ggplot(pokedex,aes(x=height_inches)) + 
  geom_histogram(binwidth=3)
