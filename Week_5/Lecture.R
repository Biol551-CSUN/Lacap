### Week 5 Lecture 9 ##############
### Created by: Roland Lacap ######
### Creaated on: 2021-02-22 #######

### Goal: Join two datasets together using R

### Load Libraries#################
library(tidyverse)
library(here)
library(ghibli)

### Load Data #####################
# environmental data from each site
EnviroData<- read.csv(here("Week_5","data", "site.characteristics.data.csv")) #dataset 1

#Thermal performance data
TPCData<- read.csv(here("Week_5","data","Topt_data.csv")) #dataset 2

glimpse(EnviroData)
glimpse(TPCData)

EnviroData_wide<- EnviroData %>% 
  pivot_wider(names_from = parameter.measured, #pivots the data from long to wide
              values_from = values) %>% 
  arrange(site.letter) #arranges site by alphabetic order-descending

FullData_left<- left_join(TPCData, EnviroData_wide) %>%  #Joining by = "site.letter".
  relocate(where(is.numeric), .after = where(is.character))#relocates all the numeric data after the character data
  
FullData_left_sum_at<- FullData_left %>% 
  group_by(site.letter) %>% 
  summarise_at(vars(E:substrate.cover), #columns from E to substrate cover, can also do numbers
               list(mean = mean, var = var), na.rm = TRUE)
  
#FullData_left_sum<- FullData_left %>% 
 # pivot_longer(names_to = "Variables", 
             #  values_to = "Values") %>% #names of the new column
  #group_by(site.letter,Variables) %>% 
  #summarise(means = mean(Values, na.rm=TRUE), #get mean
   #       vars = var(Values, na.rm=TRUE), #get variance
    #      sd = sd(Values, na.rm=TRUE)) %>% #get standard deviation

### Tibble portion fo the lecture ########

# Tibble 1
T1 <- tibble(Site.ID = c("A", "B", "C", "D"), 
             Temperature = c(14.1, 16.7, 15.3, 12.8))
T1

# Tibble 2
T2 <-tibble(Site.ID = c("A", "B", "D", "E"), 
            pH = c(7.3, 7.8, 8.1, 7.9))
T2

left_join(T1, T2) #missing data will show in C/pH
right_join(T1, T2) #missing data will show in E/temp

inner_join(T1,T2) #only joins the data that is complete in both datasets
full_join(T1,T2) #full join keeps everything

#these are useful to see if data is missing...we should not expect anything from these values
semi_join(T1,T2) #keeps all rows from the first data where there ar ematching values in the second data set, keeping columns from the first dataset
anti_join(T2,T1) #keeps only missing data from either one dataset / pH
anti_join(T1,T2) #keeps only missing data from either one dataset / temperature

