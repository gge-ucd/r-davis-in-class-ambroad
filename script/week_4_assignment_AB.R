#Week 4 Assignment

#Initial data read and dataframe creation
read.csv("data/portal_data_joined.csv")
surveys<-read.csv("data/portal_data_joined.csv")
surveys

#First subset
ncol(surveys)
surveys_subset<-surveys[1:400,-c(2:4,9:13)]
ncol(surveys_subset)
nrow(surveys_subset)

#Challenge
surveys_subset
surveys_long_feet<-surveys_subset[surveys_subset$hindfoot_length>32,]
surveys_long_feet
hist(surveys_long_feet$hindfoot_length)

#time to intentionally mess up some data...(I think)
hindfoot_lengths<-as.character(surveys_long_feet$hindfoot_length)
hindfoot_lengths
typeof(hindfoot_lengths)
hist(hindfoot_lengths)
