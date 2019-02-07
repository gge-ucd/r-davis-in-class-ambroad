#Week 5 Assignment AMB

library(tidyverse)
surveys<-read_csv("data/portal_data_joined.csv")

surveys_weight<-surveys %>% 
  filter(weight<60) %>%
  filter(weight>30) %>% 
  head()

biggest_critters<-surveys %>% 
  group_by(species_id,sex) %>% 
  mutate(max_weight=max(weight,na.rm=TRUE))

biggest_critters<-biggest_critters %>% 
  arrange(weight,.by_group = FALSE) %>% 
  filter(!is.na(weight))

extreme_critters<-biggest_critters[-c(11:32273),]

#this is the part where I just play around a bit...
playing_with_NA<-surveys %>% 
  filter(is.na(weight))

playing_with_NA %>% 
  group_by(plot_id) %>% 
  tally()

playing_with_NA %>% 
  group_by(year) %>% 
  tally()

playing_with_NA %>% 
  group_by(species_id) %>% 
  tally()

#back to business
surveys_avg_weight<-biggest_critters %>% 
  group_by(sex,species_id) %>% 
  arrange(.by_group=TRUE) %>% 
  mutate(avg_weight=mean(weight)) %>% 
  select(species_id,sex,weight,avg_weight)

#CHALLENGE
surveys_avg_weight<-mutate(surveys_avg_weight,above_average=weight>avg_weight)

#EXTRA CHALLENGE
?scale
surveys<-surveys %>% 
  group_by(species_id) %>% 
  mutate(wt_scaled=scale(weight,scale=TRUE))

#Highest relative weight is 15x the average (Chaetodipus penicillatus, obs 34450) for their species. That's insane.
