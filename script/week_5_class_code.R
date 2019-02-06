#Week 5 Class Code

install.packages("tidyverse")
#don't need to install package every time you want to use it, but you do have to "call" it:
library(tidyverse)

surveys<-read_csv("data/portal_data_joined.csv")
surveys

str(surveys)

#selecting specific columns
select(surveys,plot_id,species_id,weight)   #select(dataframe,columnnames,...)
#produces a "tibble" - a cleaned up dataframe - prints nicely, looks cleaner, etc

#selecting specific rows
filter(surveys,year==1995)

surveys2<-filter(surveys,weight<5)
surveys_sml<-select(surveys2,species_id,sex,weight)

#the above is great, but a little clunky

#alternative: Pipes %>%
  #shortcut on a PC is ctrl-shift-M simultaneously
surveys %>%    #specifies which dataframe you will be working on for whole pipe
  filter(weight<5) %>%    #can subsequently specify the rows/columns of interest in an orderly way
  select(species_id,sex,weight)


#challenge
surveys %>% filter(year<1995) %>% select(year,sex,weight)


#converting data in tables
#mutate creats new columns, can manipulate other columns to create the new one
surveys<-surveys %>% mutate(weight_kg = weight/1000) %>% 
  mutate(weight_kg2=weight_kg*2)

#can use filter to remove "NA" values
surveys %>% 
  filter(!is.na(weight)) %>%    #Exclamation point is basically negative operator - tells R to take everything that IS NOT whatever follows
  mutate(weight_kg=weight/1000)


#CHALLENGE
surveys_challenge<-surveys %>% filter(!is.na(hindfoot_length)) %>% mutate(hindfoot_half=hindfoot_length/2) %>% select(species_id,hindfoot_half)



#Other ways to manipulate data frames - group_by
#want to compute mean weight for males and females
surveys %>% 
  group_by(sex) %>%    #just running this would not make surveys look any different to our eyes, but R would recognize it
  summarize(mean_weight=mean(weight,na.rm = TRUE))   #calculate the mean, removing NA in the process

#can be used with multiple columns
surveys %>% 
  group_by(sex,species_id) %>% 
  summarize(mean_weight=mean(weight,na.rm=TRUE))

#tally - generates tibble off the groups that you specify
  #same as if you did group_by(variable) %>% summarize(new_column-n())
surveys %>% 
  group_by(sex,species_id) %>% 
  tally()

#gathering and spreading
#spreading takes a long format data frame and spreads it to a wide format
surveys_gw<-surveys %>% filter(!is.na(weight)) %>% group_by(genus,plot_id) %>% summarize(mean_weight=mean(weight))
#want to convert each genus into its own column
surveys_spread<-surveys_gw %>%
  spread(key=genus,value=mean_weight)   #first variable is going to be your columns ("key"), second is the values that will populate the table

#gathering requires data, key, value, names of columns used to fill key columns
surveys_gather<-surveys_spread %>% gather(key=genus,value=mean_weight,-plot_id)   #use all the variables EXCEPT plot_id to fill up this new table
