#Week 6 Assignment

library(tidyverse)
gapminder<-read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

#Part 1A: Change in life expectancy over time
#Worldwide
yearly_lifeExp<-gapminder %>% group_by(year) %>% mutate(avglifeexp=mean(lifeExp))
ggplot(yearly_lifeExp,aes(x=year,y=avglifeexp,group=year))+geom_point()

#By continent
continent_lifeExp<-gapminder %>% group_by(year,continent) %>% mutate(avglifeexp=mean(lifeExp))
ggplot(continent_lifeExp,aes(x=year,y=avglifeexp,color=continent))+geom_point()+geom_line()

#1B: Scale and Smooth
#At the risk of oversimplifying, I suspect that scale_x_log10() convertes the x values to a log, while geom_smooth() computes a general trend line for the data in the plot

#1C: Challenge!
ggplot(gapminder,aes(x=gdpPercap,y=lifeExp))+
  geom_point(aes(color=continent,size=pop))+scale_x_log10()+
  geom_smooth(method='lm',color='black',linetype='dashed')+theme_bw()

#This seems a bit too cluttered to really be useful. I tried doing some additional searching into how to alter the color gradient or transparency of the points so they could be more easily seen in the jumble, but was unsuccessful.