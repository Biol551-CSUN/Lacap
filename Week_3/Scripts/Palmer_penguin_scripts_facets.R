### Created by Roland Lacap
### Updated 02/10/2021
### We installed "palmerpenguins" for this exercise. 
#########################################################

###Load Libraries#######################################
library(palmerpenguins)
library(tidyverse) #make sure this is in every script
library(here)

###Load Data###########################################
glimpse(penguins)

###
ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     color = species,)) +
  
