#Week 7 Class Code

#Data Import and Export
library(tidyverse)
wide_data<-read_csv("data/wide_eg.csv",skip = 2)
load("data/mauna_loa_met_2001_minute.rda")
#.rda files can contain multiple R objects, .rds is specifically single R object
#.rda files will automatically be assigned to a dataframe, while .rds must be assigned (like a .csv)

#Export data
saveRDS(wide_data,"data/wide_data.rds")
rm(wide_data)

wide_data<-readRDS("data/wide_data.rds")

#other packages for reading data: readxl, googlesheets, googledrive, foreign, rio


#Playing with Date/Time data
library(lubridate)
sample_dates1<-c("2016-02-01","2016-03-17","2017-01-01")
sample_dates1<-as.Date(sample_dates1)
#easy, built in package, but specificaly lookes for YYYY-MM-DD format

sample_date2<-c("02-01-2001","04-04-1991")
sample_date2<-as.Date(sample_date2,format="%m-%d-%Y")
#lower case y = 2 digits in year, upper case Y = 4 digits in year

as.Date("Jul 04, 2017",format="%b%d,%Y")
#lower case b = abbreviated month, upper case B = full name

#Calculations with dates
dt1<-as.Date("2017-07-11")
dt2<-as.Date("2016-04-22")
print(dt1-dt2)  #in days
print(difftime(dt1,dt2,units="week"))  #in weeks
six.weeks<-seq(dt1,length=6,by="week")  #creates sequences of dates with regular interval

two.weeks<-seq(dt1,length=10,by="2 week")


#lubridate is really versatile and simplifies this whole process
ymd("2016/01/01")
dmy("04.04.91")
mdy("Feb 19, 2005")