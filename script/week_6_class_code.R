#Week 6 Class Code

library(tidyverse)

surveys<-read_csv("data/portal_data_joined.csv")

#goal: take NAs out of weight, hindfoot_length, and sex

surveys_complete<-surveys %>% filter(!is.na(weight),!is.na(hindfoot_length),!is.na(sex))
#is.na() can only take one argument at a time

#plot change in common species abundance through time
#first, remove species with <50 observation

#have to figure out how many observations there are per species and then filter out ones <50
species_counts<-surveys_complete %>% group_by(species_id) %>% tally() %>% filter(n>=50)

#new data frame has the species we're interested in keeping, so tell R to only keep those species in full table
surveys_complete<-surveys_complete %>% filter(species_id %in% species_counts$species_id)
  #tells R to take species_id in this column from dataframe species_counts, column species_id

#writing your dataframe to .csv
write_csv(surveys_complete,path="dataoutput/surveys_complete.csv")



#ggplot time!!!

#core function to make a graph
ggplot(data=surveys_complete,mapping=aes(x=weight,y=hindfoot_length)) +
  geom_point()
#first, give it the data, 
#then, how you want to translate that data to the plot - within function aes()
#Above sets up the canvas, then you want to add elements to it using geom_function


#saving a plot object
surveys_plot<-ggplot(data=surveys_complete,mapping=aes(x=weight,y=hindfoot_length))
#now you can manipulate the bare bones without having to constantly rewrite opening code
surveys_plot +
  geom_point()


#CHALLENGE
surveys_plot+
  geom_hex()
install.packages("hexbin")
library(hexbin)
surveys_plot+
  geom_hex()

#manipulating geom
surveys_complete %>% 
  ggplot(aes(x=weight,y=hindfoot_length))+
  geom_point(alpha=0.1,color="tomato")   #anything in () will be applied directly to plot

#using data in a geom
surveys_complete %>% 
  ggplot(aes(x=weight,y=hindfoot_length)) +
  geom_point(alpha=0.1,aes(color=species_id))

#putting color as a global aesthetic
surveys_complete %>% 
  ggplot(aes(x=weight,y=hindfoot_length,color=species_id)) +
  geom_point(alpha=0.1)

#dealing with overplotting...using jitter
surveys_complete %>% 
  ggplot(aes(x=weight,y=hindfoot_length,color=species_id)) +
  geom_jitter(alpha=0.1)


#boxplots!
surveys_complete %>% 
  ggplot(aes(x=species_id,y=weight))+
  geom_boxplot()

#adding points to boxplots
surveys_complete %>% 
  ggplot(aes(x = species_id, y = weight)) +
  geom_boxplot() +
  geom_point(alpha = 0.3, color = "tomato")
#ehhh, that's not really what we wanted
surveys_complete %>% 
  ggplot(aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.3, color = "tomato") +
  geom_boxplot(alpha=0)

#plotting time series
yearly_counts<-surveys_complete %>% 
  count(year,species_id)  #basically combines group_by and tally into one step- produces tibble

yearly_counts %>% 
  ggplot(aes(x=year,y=n))+
  geom_line()
#well now that looks funky...because we didn't differentiate between the different species
#make it pretty, while you're at it (with color)
yearly_counts %>% 
  ggplot(aes(x=year,y=n,group=species_id,color=species_id))+
  geom_line()

#facetting
yearly_counts %>% 
  ggplot(aes(x=year,y=n))+
  geom_line()+
  facet_wrap(~species_id)  #creates subplot for every variable in group provided

#let's see how to sexes change
yearly_sex_counts<-surveys_complete %>% count(year,species_id,sex)

yearly_sex_counts %>% 
  ggplot(aes(x=year,y=n,color=sex))+
  geom_line()+
  facet_wrap(~species_id)

#People will judge you if you leave all of the defaults...so make it pretty! (changing theme, legends, etc)
yearly_sex_counts %>% 
  ggplot(aes(x=year,y=n,color=sex))+
  geom_line()+
  facet_wrap(~species_id)+
  theme_bw()+
  theme(panel.grid=element_blank())

yearly_sex_weight<-surveys_complete %>% 
  group_by(year,sex,species_id) %>% 
  summarize(avg_weight=mean(weight))

yearly_sex_weight %>% 
  ggplot(aes(x=year,y=avg_weight,color=species_id))+
  geom_line()+
  facet_grid(sex~.)  #format is rows~columns
#lets you organize the subplots however you want

#adding labels, etc
yearly_sex_counts %>% 
  ggplot(aes(x=year,y=n,color=sex))+
  geom_line()+
  facet_wrap(~species_id)+
  theme_bw()+
  theme(panel.grid=element_blank())+
  labs(title="Observed Species through Time",x="Year of Observation",y="Number of Species")+
  theme(text=element_text(size=16))+
  theme(axis.text.x=element_text(color="grey20",size=12,angle=90,hjust=0.5,vjust=0.5))

#saving plots
ggsave("figures/my_test_facet_plot.jpg",height = 8,width = 8)
