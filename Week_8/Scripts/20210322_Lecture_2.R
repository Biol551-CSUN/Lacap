### Week 8 Lecture 2
### 2021-03-24

### Load Libraries
library(tidyverse)

### Create df
df <- tibble::tibble(
  a = rnorm(10), # draws 10 random values from a normal distribution
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)
head(df)

df<-df %>% #it is likely possible to make a mistate (line 18)
  mutate(a = (a-min(a, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(a, na.rm = TRUE)),
         b = (b-min(b, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(b, na.rm = TRUE)),
         c = (c-min(c, na.rm = TRUE))/(max(c, na.rm = TRUE)-min(c, na.rm = TRUE)),
         d = (d-min(d, na.rm = TRUE))/(max(d, na.rm = TRUE)-min(d, na.rm = TRUE)))
         
### lets create a function!

rescale01 <- function(x) { #creates the function
  value <- (x-min(x, na.rm = TRUE))/(max(x, na.rm = TRUE)-min(x, na.rm = TRUE))
  return(value)
}
#you want to name the equation so that you can return it.

df <- df %>%
  mutate(a = rescale01(a),
         b = rescale01(b),
         c = rescale01(c),
         d = rescale01(d))

### second function
temp_C <- (temp_F - 32) * 5 / 9 #without function

f_to_c <- function(temp_F) { 
  temp_C <- (temp_F - 32) * 5 / 9
  return(temp_C)
}

f_to_c(32)
f_to_c(100)

### think, pair, share moment
c_to_k <- function(temp_c) {
  temp_k <- (temp_c + 273.15)
  return(temp_k)
}

c_to_k(0)
c_to_k(26.85)

### turn plot into a function
library(palmerpenguins)
library(PNWColors)

myplot<-function(data, x, y){ #makes this a function
  #this requires the df, x and y
  
pal <- pnw_palette("Lake",3, type="discrete")

ggplot(penguins, aes(x = {{x}}, y = {{y}}, color = island))+ #we added the curly brackets for x&y
  geom_point()+
  geom_smooth(method = "lm")+ # add a linear model
  scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
  theme_bw()
}

myplot(data = penguins, x = body_mass_g, y = bill_length_mm) #will get an error
#we will need to make it run

### add a default
myPenguinplot<-function(data = penguins, x, y){ # the data frame is specific to penguins
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}

myPenguinplot(x = body_mass_g, y = flipper_length_mm)+
  labs(x = "Body mass (g)",
       y = "Flipper length (mm)")

### the use of if-else statements
#example of how this works

a <- 4
b <- 5

if (a > b) { # my question
  f <- 20 # if it is true give me answer 1
} else { # else give me answer 2
  f <- 10
}

### lets apply this to our plot function
myplot<-function(data = penguins, x, y, lines=TRUE ){ # add new argument for lines
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  if(lines==TRUE){
    ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
      geom_point()+
      geom_smooth(method = "lm")+ # add a linear model
      scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
      theme_bw()
  }
  else{
    ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
      geom_point()+
      scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
      theme_bw()
  }
}

  myPenguinplot2(x = body_mass_g, y = flipper_length_mm)
  