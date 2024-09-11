#download the data
library(tidyverse)
library(palmerpenguins)
glimpse(penguins)


#make a plot of the data
#Start with the (penguins) data frame: ggplot(data = penguins)
ggplot(data = penguins, 
#build our plot or aesthetic, define the x, y, and any other parameters:
       mapping = aes(x = bill_depth_mm, y = bill_length_mm,
                     color = species)) +
#^^^ don't forget to close parentheses and add a "+" to keep going
  
#Draw the dots on the plot!! And add a "+" NOT ";","...", "," or "and"
  geom_point() +
  
#Label the graph
  labs(
    title = "Bill depth and length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Bill depth (mm)", 
    y = "Bill length (mm)",
    color = "Species",
    caption = "Source: Palmer Station LTER / palmerpenguins package"
  ) +
  scale_color_viridis_d()
#^^^change the colors so that viewers with common forms of colorblindness can see

#Great Job!
# "Start with the penguins data frame, map bill depth to the x-axis and map bill 
# length to the y-axis.Represent each observation with a point and map species to
# the colour of each point. Title the plot “Bill depth and length”, add the 
# subtitle “Dimensions for Adelie, Chinstrap, and Gentoo Penguins”, label the x 
# and y axes as “Bill depth (mm)” and “Bill length (mm)”, respectively, label the 
# legend “Species”, and add a caption for the data source."

#Equivalent Code
#1
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, 
                     y = bill_length_mm,
                     color = species)) + 
  geom_point() +
  scale_color_viridis_d()
#2
ggplot(penguins,
       aes(x = bill_depth_mm, 
           y = bill_length_mm,
           color = species)) + 
  geom_point() +
  scale_color_viridis_d()
#3
penguins |>
  ggplot(aes(x = bill_depth_mm, 
             y = bill_length_mm,
             color = species)) + 
  geom_point() +
  scale_color_viridis_d()

#What was the point of the code aloud?
#     Think about what you want
#     Write code to do each part