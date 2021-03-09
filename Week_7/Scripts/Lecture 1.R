### Week 7 Lecture 1 ####
### Created on: 2021-03-08 ###
### Created by: Roland Lacap ####

### Load Libraries ###
library(tidyverse)
library(here)
library(maps)
library(mapdata)
library(mapproj)
library(PNWColors)

# Read in data on population in California by county
popdata<-read_csv(here("Week_7","Data","CApopdata.csv"))
#read in data on number of seastars at different field sites
stars<-read_csv(here("Week_7","Data","stars.csv"))

# get data for the entire world
world<-map_data("world")
head(world)

# get data for the USA
usa<-map_data("usa")
head(usa)

# get data for italy
italy<-map_data("italy")
head(italy)

# get data for states
states<-map_data("state")
head(states)

# get data for counties
counties<-map_data("county")
head(counties)

### making the world plot 
ggplot()+
  geom_polygon(data = world, 
               aes(x = long,
                   y = lat,
                   group = group, 
                   fill = region),
               color = "black")+ #coded outside of aesthetics, bc you are not manipulating the data
  theme_minimal()+
  guides(fill = FALSE)+
  theme(panel.background = element_rect(fill = "lightblue"))+
  coord_map(projection = "sinusoidal", 
            xlim = c(-180,180))


# Use the states dataset
CA_data<-states %>%
  filter(region == "california") #filters only CA

  ggplot()+
  geom_polygon(data = CA_data, 
               aes(x = long,
                   y = lat,
                   group = group,
                   fill = region),
               color = "black")+ # gives an outline to california
  theme_bw()+
  guides(fill = FALSE)+ #removes legend
  theme(panel.background = element_rect(fill = "grey"))+
  coord_map(projection = "mercator")  #used tetra projection 

CA_data

# Look at the county data
head(counties)[1:3,] # only showing the first 3 rows for space
# Look at the county data
head(popdata)

CApop_county<-popdata %>%
  select("subregion" = County, Population)  %>% # rename the county col
  inner_join(counties) %>% # make sure that your columns are named the same
  filter(region == "california") # some counties have same names in other states

CApop_plot <- CApop_county %>% 
  ggplot()+
  geom_polygon(data = CApop_county, 
               aes(x = long, 
                   y = lat, 
                   group = group,
                   fill = Population),  
               color = "black")+
  geom_point(data = stars, # add a point at all my sites
             aes(x = long,
                 y = lat,
                 size = star_no))+
  coord_map()+
  theme_void() +
  scale_fill_gradient(trans = "log10")+
  labs(size = "# stars/m2") +
  ggsave(here("Week_7","Output","CApop.pdf"))

CApop_plot
