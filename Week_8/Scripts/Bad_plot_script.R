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
require(jpeg)

### Get data
office_ratings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-17/office_ratings.csv')

office_Badplot <- office_ratings %>% 
  ggplot(aes(x=imdb_rating,
             y=total_votes,
             fill = title)) +
  geom_jitter(alpha = 0.5,
              fill = title) +
  guides(fill = FALSE)
  ggsave(here("Week_8","Output","Bad_plot.png")) 

office_Badplot 

office_Good <- office_ratings %>% 
  unite(col = "Season_Episode",
        c(1:2),
        sep = ":") %>% 
  unite(col = "Title",
        c("Season_Episode", "title"),
        sep = " ") %>% 
  group_by(Title) %>% 
  summarise(max_rating = max(imdb_rating),
            max_votes = max(total_votes)) %>% 
  arrange(desc(max_rating)) %>% 
  slice_max(max_rating, n = 10)

theoffice_img <- readJPEG(here("Scripts","The_office_logo.jpg"))

office_Goodplot <- office_Good %>% 
  ggplot(aes(x=max_votes,
             y=Title,
             fill = as.factor(max_rating))) +
  geom_bar(stat="identity") +
  labs(title = "The Office", #add titles and change axis labels
       subtitle = "Top 10 Episodes",
       x = "Total Votes from Audience",
       y = "Season:Episode",
       caption = "Source: SteamCharts | @LacapRoland")+
  theme_bw()+
  guides(fill = guide_legend(title="IMDB Rating"))+
  scale_fill_manual(values = c("#D6E3F3","#DDB78C","#54A8D6"))+
ggsave(here("Week_8","Output","Good_plot.png")) 

office_Goodplot
