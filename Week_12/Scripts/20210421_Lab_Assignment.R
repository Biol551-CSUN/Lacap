### Week 12 Lab Assignment
### Created by Roland, Jamie, Jasmin, Claudia
### Created on 2021-04-21

### Load Libraries
library(tidyverse)
library(here)
library(tvthemes)
library(forcats)
library(magick)
library(PNWColors)


### Load Data
intertidaldata <- read_csv(here("Week_12","Data","intertidaldata.csv"))
intertidaldata_lat <- read_csv(here("Week_12","Data","intertidaldata_latitude.csv"))

### Wrangle data
tidaldatafactor <- intertidaldata %>% 
  filter(complete.cases(.)) %>% 
  mutate(Quadrat = recode(Quadrat, 'Low  .' = "Low",
                          'Mid  1' = "Mid")) %>%
  select(1:10) %>% 
  mutate(Quadrat = fct_lump(Quadrat)) %>% 
  pivot_longer(cols = 4:10,
               names_to = "type",
               values_to = "cover") %>% 
  group_by(Site, Quadrat, type) %>% 
  summarise(average_cover = mean(cover, na.rm=TRUE)) %>% 
  inner_join(intertidaldata_lat) %>% 
  mutate(Quadrat = factor(Quadrat,
                          levels = c("Low",
                                     "Mid",
                                     "High")))

tidal_plot <- tidaldatafactor %>% 
  ggplot(aes(x = Latitude, y = average_cover, 
             fill = fct_reorder2(type,Latitude,average_cover)))+
  geom_area(size = 1,
            color = "black")+
  facet_wrap(~Quadrat)+
  labs(fill = "Type",
       y = "Average Percent Cover")+
  theme_spongeBob()+
  theme(strip.text.x = element_text(size = 12,
                                    face = 2,
                                    color = "white"))+
  scale_fill_spongeBob()

tidal_plot

tidal_plot2 <- tidaldatafactor %>% 
  ggplot(aes(x = Quadrat, y = average_cover, 
             fill = fct_reorder2(type,Site,average_cover)))+
  geom_bar(position = "stack",
            stat = "identity")+
  facet_wrap(~Site)+
  labs(fill = "Type",
       y = "Average Percent Cover")+
  theme_spongeBob()+
  theme(strip.text.x = element_text(size = 12,
                                    face = 2,
                                    color = "white"))+
  scale_fill_spongeBob()

tidal_plot2

