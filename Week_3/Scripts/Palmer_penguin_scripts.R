### Created by Roland Lacap
### 02/08/2021
### We installed "palmerpenguins" for this exercise. 
#########################################################

###Load Libraries#######################################
library(tidyverse) #make sure this is in every script
library(palmerpenguins)
glimpse(penguins)

###
ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     color = species)) +
  geom_point()
