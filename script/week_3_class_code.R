#starting with a good data format for R
#does not recognize additional spreadsheets - can you make it a column instead?
#date/time - have separate column for year, month, day, etc.

read.csv("data/tidy.csv")

#vectors
weight_g <- c(50, 60, 31, 89)
weight_g

#characters
animals <- c("mouse", "rat", "dog", "cat")
animals

#vector exploration tools
length(weight_g)

length(animals)

class(weight_g)
class(animals)

x <- 4

#str lets you see the structure - go to for seeing summary of data
str(x)
str(weight_g)

#adding numbers to sets
weight_g <- c(weight_g, 105)
weight_g

weight_g <- c(25, weight_g)
weight_g
#be careful about throwing that code multiple times - could add the value more than once

#an atomic vector is the simplest thing that R can understand
#6 types: "double" ("numeric"), "character", "logical", "integer", "complex", "raw"
#first four are the most common for our purposes
#type is automatically assigned when you set the vector - when numbers, default is "double"

typeof(weight_g)

weight_integer <- c(20L, 21L, 85L)
class(weight_integer)
typeof(weight_integer)

#class exercise in vectors
num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

combined_logical <- c(num_logical, char_logical)
combined_logical

#subsetting vectors
animals
animals[3]
animals[2,3]  #incorrect
animals[c(2,3)]  #correct

#conditional subsetting
weight_g
weight_g[c(T, F, T, T, F, T, T)]  #keeps the true ones, removes the false ones
weight_g > 50
weight_g[weight_g > 50]

#combining multiple conditions
weight_g[weight_g<30|weight_g>50]

#searching for characters
animals[animals == "cat" | animals == "rat"]
animals[animals %in% c("rat", "antelope", "jackalope", "hippogriff")]



#challenge
"four">"five"
"six">"five"
"eight">"five"
#sorts alphabetically

#missing values
heights<-c(2,4,4,NA,6)
str(heights)
mean(weight_g)
mean(heights)
