### Created by Roland Lacap
### Updated 02/10/2021
### We installed "palmerpenguins" for this exercise. 
#########################################################

###Load Libraries#######################################
library(palmerpenguins)
library(tidyverse) #make sure this is in every script
library(here)
library(beyonce)

###Load Data###########################################
glimpse(penguins)

###Load Plots##########################################
#consider naming plots for later usage of patchwork, this is to create figures. plot1<-
plot1<-ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) + 
geom_point() +
  geom_smooth(method = "lm") + #makes the regression line linear
  labs(x = "Bill depth (mm)", #labs = labels
       y = "Bill length (mm)",
       color = "Species") +
scale_color_manual(values = beyonce_palette(2)) +
 # scale_color_manual(values = c("blue", "purple", "green"))
  theme_bw() + #changes the grid based upon which theme
  # theme changes based upon which elements you input
  theme(axis.title.x = element_text(size = 20,
                                  color = "red"),
        axis.title.y = element_text(size = 20,
                                    color = "blue"), 
        panel.background = element_rect(fill = "linen"),
        legend.position = "top") +
  ggsave(here("Week_3","Output","Penguin.png"),
         dpi = 300) #default is by inches however input dpi can ensure correct parameters

