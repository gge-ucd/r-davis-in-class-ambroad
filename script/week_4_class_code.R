#Week 4 Class Code

#Intro to Data Frames

download.file(url="https://ndownloader.figshare.com/files/2292169", destfile = "data/portal_data_joined.csv")
#must include file extension - doesn't read that automatically

read.csv(file="data/portal_data_joined.csv")
#can use tab after typing in a command to see what information is needed next
#when looking for file, can press tab inside quotation marks to move through files
surveys<-read.csv(file="data/portal_data_joined.csv")
surveys

#when working with large datasets, a couple commands can help make it easier and more organized to view

#to see the first few rows of every column ("top chunk")
head(surveys)

#every single column in a table is a vector
  #must be same type of data

#to look at the structure of your data - good overview
str(surveys)
#obs=rows, variables=columns
#shows type of vector in each column and a sample of what is in there

dim(surveys)   #dimensions
nrow(surveys)  #number of rows
ncol(surveys)  #number of columns
tail(surveys)  #last chunk of data (opposite of head)
names(surveys) #character vector of the names of the different vectors (columns) in there
rownames(surveys)  #character vector of the names of the rows (in this case, just the datapoints)

#simple summary statistics for the dataframe
summary(surveys)
#good way to check ahead of time for errors in data entry, get a sense of min/max for rows, etc.


#Subsetting data frames - pulling out portion (like we did last week with vectors)
#vector review - subsetting via giving them a location in the list
animal_vec<-c("mouse","rat","cat")
animal_vec[2]

#tables are two dimensional - must have [row,column]
#to find a specific cell
surveys[1,1]
head(surveys)
surveys[2,1]
surveys[3300,1]
#to find a whole row/column, leave the other blank
surveys[,1]
###THE OUTPUTS ABOVE HAVE ALL BEEN VECTORS###


#using a single number with no column - output is dataframe with one column
surveys[1]
head(surveys[1])


#getting more specific slices...
surveys[1:3,7]   #1:3 = "1 through 3" = the first 3 rows AS A VECTOR
surveys[5,]  #one row (so a single observation in this particular dataframe)
#excluding information with "-"
surveys[1:5,-1]
surveys[-10:34786,]   #throws error because R doesn't like going "past" 0
#work around error by wrapping the section we want to exclude as its own vector
surveys[-c(10:34786),]
#embedding vectors in subsets
surveys[c(10,15,20),]
surveys[c(10,15,20,20),]
surveys[c(1,1,1,1,1),]

#more ways to subset...
surveys["sex"]  #ask by name - single column as dataframe
surveys[,"plot_id"]  #single column as a vector
#double brackets!!!
#single bracket pull single column as a dataframe and asks R to give it to us as a dataframe
  #train car analogy - single bracket is asking for a subset of cars
  #double brackets ask for the information within that subset of cars
surveys[["plot_id"]]   #single column as vector
surveys$year   #single column as vector



#CHALLENGE
surveys_200<-surveys[200,]
surveys_200
nrow(surveys)
surveys[nrow(surveys),]
surveys_last<-surveys[nrow(surveys),]
surveys_last
surveys_middle<-surveys[nrow(surveys)/2,]   #evaluates "nrow(surveys)/2" as a number, then plugs in that number
surveys_middle
surveys[-c(7:nrow(surveys)),]



#Factors
#factors represent categorical data
#stored as integers with labels assigned to them, thus have to be careful with how you treat them
surveys$sex
#once you create a factor, it has predesigned levels associated with it
  #these are the ONLY values that can be contained in that factor

#creating a factor
sex<-factor(c("male","female","female","male"))
sex
#R automatically lists levels alphabetically, assigns integers (starting with 1) in that order
  #in this case, female becomes 1 and male becomes 2
  #the factor is really "2, 1, 1, 2" - but those integers are labeled with the values male/female
class(sex)
typeof(sex)
levels(sex)   #character vector
levels(surveys$genus)   #character vector
nlevels(sex)
#the above is fine and dandy for groups that have no inherent order, but some factors should have predetermined order
concentration<-factor(c("high","medium","medium","low"))
concentration
#logically, order should not be alphabetical, but in order of quantity
concentration<-factor(concentration,levels = c("low","medium","high"))
concentration


#factors have idiosyncracies that can make them difficult to work with
#for example, adding to a factor
concentration<-c(concentration,"very high")   #makes the integers assigned underneath the levels into character values
concentration
#make them into characters
as.character(sex)

#factors with numeric levels
year_factor<-factor(c(1990,1923,1965,2018))
as.numeric(year_factor)
as.character(year_factor)
as.numeric(as.character(year_factor))   #convert the character vector above into numeric vector


#why do we need to bother with all these factors?
?read.csv
surveys_no_factors<-read.csv(file="data/portal_data_joined.csv",stringsAsFactors = FALSE)
str(surveys_no_factors)


#the way for getting numbers out above is clunky - here is the recommended way
as.numeric(levels(year_factor))[year_factor]


#renaming factors
sex<-surveys$sex
levels(sex)
levels(sex)[1]
levels(sex)[1]<-"undetermined"
levels(sex)
head(sex)



#working with dates
library(lubridate)
#install.packages("lubridate")  better to do installations in the console directly - don't want it to accidentally rerun all the time

library(lubridate)
my_date<-ymd("2015-01-01")
my_date
str(my_date)
my_date<-ymd(paste("2015","05","17",sep="-"))   #paste basically combines values into single collective
                                              #sep divorces those values from other values they may have been associated with (in this case, the "-" from above formatting)
my_date
paste(surveys$year,surveys$month,surveys$day, sep="-")
#all of this has been to put the dates in the table into the format we want
#now create a new column with these dates in these formats
surveys$date<-ymd(paste(surveys$year,surveys$month,surveys$day, sep="-"))
surveys$date
surveys$date[is.na(surveys$date)]
