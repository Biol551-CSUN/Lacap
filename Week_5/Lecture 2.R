### Week 5 Lecture 2 
### Created by: Roland Lacap
### Created on: 2021-02-24
###############################################

### Load Libraries ###
library(tidyverse)
library(here)
library(lubridate)

# What time is it now?
now()
now(tzone ="EST") #time in the east coast
now(tzone ="GMT") #time in GMT/London

# What day is today??
today() 
today(tzone = "GMT") #day in GMT/London

pm(now()) #is it morning? FALSE
leap_year(now())

# these will all produce the same results
ymd("2021-02-24")
mdy("02/24/2021")
mdy("February 24 2021")
dmy("24/02/2021")

ymd_hms("2021-02-24 10:22:20 PM")
mdy_hms("02/24/2021 22:22:20") #get in the habit for using military time
mdy_hm("February 24 2021 10:22 PM")

#Making a vector of dates as a character string
datetimes<-c("02/24/2021 22:22:20",
             "02/25/2021 11:21:10",
             "02/26/2021 8:01:52")
#convert to datetimes
datetimes<- mdy_hms(datetimes)

month(datetimes, label = TRUE, abbr = FALSE) #label = TRUE will make it spelled out/abbr = FALSE spells out the whole month

wday(datetimes, label = TRUE) #extract day of the week
#same can occur for time
hour(datetimes)
minute(datetimes)
second(datetimes)

datetimes + hours(4) #adds 4 hours to time, in the event that one machine is wrong
#this is different from hour(), which extracts the hour, hours() is used to add

datetimes + days(2) # this adds 2 days

#rounding the dates or times
round_date(datetimes, "minute") # round to nearest minute
round_date(datetimes, "5 mins") # round to nearest 5 minute

#ThinkSharePair moment
glimpse(CondData)

CondData<- CondData %>% 
  mutate(DateTime = year(date)) 

glimpse(CondData)
