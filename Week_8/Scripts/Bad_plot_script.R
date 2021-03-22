### Bad plot vs good plot
### Created by: 2021-03-18
### Created by: Roland Lacap

### Load Libraries
library(tidyverse)
library(here)
library(tidytuesdayR)
library(ggstream)
library(PNWColors)
library(tvthemes)

### Get data
office_ratings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-17/office_ratings.csv') %>% 
  write_csv(here("week_8", "Data", "office_ratings"))

### Bad plot
office_bad <- office_ratings %>% 
  ggplot(aes(x = total_votes,
             y = title,
             fill = season,
             color = episode)) +
  geom_col()+
  theme_brooklyn99()+
  theme(axis.title.y = element_blank(),
        axis.title.x = element_text(color="white"),
        axis.text.x = element_text(color="white"),
        axis.text.y = element_text(color="white",
                                   angle = 45),
        plot.title=element_text(hjust=1, #centered figure title in bold
                                face="bold"),
        plot.subtitle = element_text (hjust = 1))+
  labs(title = "The",
       subtitle = "Office",
       x = "TOTAL")

office_bad

### Good plot
office_good <- office_ratings %>% 
  unite(col = "Season_Episode",
        c(1:2),
        sep = ":") %>% 
  unite(col = "Title",
        c("Season_Episode", "title"),
        sep = " ") %>% 
  top_n(10,imdb_rating) %>% 
  filter(Title != "9:22 A.A.R.M.")
  

office_Goodplot <- office_good %>% 
  ggplot(aes(x=total_votes,
             y=Title,
             fill = as.factor(imdb_rating))) +
  geom_bar(stat="identity") +
  labs(title = "The Office", #add titles and change axis labels
       subtitle = "Top 10 Episodes based on the IMDB Rating",
       x = "Total Votes from Audience",
       y = "Season:Episode",
       caption = "Source: IMDB | @LacapRoland")+
  theme_bw()+
  theme(plot.title=element_text(hjust=0.5, #centered figure title in bold
                                face="bold",
                                size = 20),
        plot.subtitle = element_text (hjust = 0.5))+
  guides(fill = guide_legend(title="IMDB Rating"))+
  scale_fill_manual(values = c("#D6E3F3","#DDB78C","#54A8D6"))

office_Goodplot

