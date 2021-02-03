### This is my first script. 
### Created by: Roland Lacap
### Created on: 2021-02-03
#################################################


### Load libraries ##############################
library(tidyverse)
library(here)
### Read in data ################################
WeightData<-read_csv(here("Week_2","data","weightdata.csv"))
### Data Analysis ###############################
head(WeightData) # Looks at the top 6 lines of the dataframe
tail(WeightData) # Looks at the bottom 6 lines of the dataframe
View(WeightData) # opens a new window to look at the entire dataframe
