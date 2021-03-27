### Week 8 Lecture 1
### 2021-03-22

### Load Libraries
library(tidyverse)
library(here)
library(patchwork)
library(ggrepel)
library(gganimate)
library(magick)
library(palmerpenguins)

# plot 1
p1<-penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_length_mm, 
             color = species))+
  geom_point()
p1

# plot 2
p2<-penguins %>%
  ggplot(aes(x = sex, 
             y = body_mass_g, 
             color = species))+
  geom_jitter(width = 0.2)
p2

p1+p2 +
  plot_layout(guides = 'collect')+
  plot_annotation(tag_levels = 'A')

#or put them on top of each other
p1/p2 +
  plot_layout(guides = 'collect')+
  plot_annotation(tag_levels = 'A')

#mtcars portion. we demonstrate ggrepel

View(mtcars)

ggplot(mtcars, aes(x = wt, 
                   y = mpg, 
                   label = rownames(mtcars))) +
  geom_label_repel() + # repel them
  geom_point(color = 'red')

#gganimate, make our plots gifs!
plot_3 <- penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_depth_mm, 
             color = species)) +
  geom_point()+
  transition_states(
    year, # the col we are animating by
    transition_length = 2, #The relative length of the transition.(seconds)
    state_length = 1 # The length of the pause between transitions (seconds)
  )+
  ease_aes("sine-in-out") +
  ggtitle('Year: {closest_state}') +
  anim_save(here("Week_9","output","mypengiungif.gif"))

plot_3

#magick portion. lets add a penguin to our figure!

penguin<-image_read("https://pngimg.com/uploads/penguin/pinguin_PNG9.png")
penguin

penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_depth_mm, 
             color = species)) +
  geom_point() +
  ggsave(here("Week_9","output","penguinplot.png"))

penplot<-image_read(here("Week_9","output","penguinplot.png"))
out <- image_composite(penplot, penguin, offset = "+70+30")
out
