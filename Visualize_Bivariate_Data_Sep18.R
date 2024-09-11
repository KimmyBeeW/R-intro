#Bivariate data analysis: Relationship between two variables
#Data: Palmer Penguins --> Measurements for penguin species, island in Palmer 
#   Archipelago, size (flipper length, body mass, bill dimensions), and sex.
library(tidyverse)
library(palmerpenguins)
glimpse(penguins)

#focus on adelie species
adelie <- penguins |>
  filter(species == "Adelie") |>
  na.omit()
adelie

#Variables
    #body_mass_g	      numerical, continuous
    #bill_length_mm	    numerical, continuous
    #bill_depth_mm	    numerical, continuous
    #flipper_length_mm	numerical, continuous
    #species	          categorical, not ordinal
    #island	            categorical, not ordinal
    #sex	              categorical, not ordinal
    #year               numerical, discrete



#Visualizing relationship between two numerical variables

#Describing relationship between two numerical variables
    #form: linear, nonlinear, quadratic, exponential
    #direction: positive, negative, no direction
    #strength: strong, moderate, weak, no relationship
    #unusual observations

#Scatterplot
ggplot(adelie, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point()
      #form: mostly linear, direction: positive, strength: weak or moderate

#Scatterplot w/curve
ggplot(adelie, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point() +
  geom_smooth()

#Scatterplot w/curve and SPAN
ggplot(adelie, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point() +
  geom_smooth(span = 0.25)
ggplot(adelie, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point() +
  geom_smooth(span = 0.75)
ggplot(adelie, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point() +
  geom_smooth(span = 1) #shows best that it's mostly linear
ggplot(adelie, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point() +
  geom_smooth(span = 2)

#customize
ggplot(adelie, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(size = 2, color = "darkred") +
  geom_smooth(span = 1.0, color = "saddlebrown", fill = "tan") +
  theme_minimal() +
  labs( 
    x = "Bill depth (mm)", 
    y = "Bill length (mm)",
    title = "Bill depth and length",
    subtitle = "Adelie Penguins on Palmer Islands",
    caption = "Source: Palmer Station LTER / palmerpenguins package"
  ) 

#Scatterplot (base R)
plot(bill_depth_mm ~ bill_length_mm, data = adelie)
#Customize (base R)
plot(bill_depth_mm ~ bill_length_mm, data = adelie,
     pch = 19, size = 2, col = "darkred",
     xlab = "Bill depth (mm)", 
     ylab = "Bill length (mm)", 
     main = "Adelie Penguins on Palmer Islands")

#What have we learned about the relationship between bill length & depth for 
# Adelie penguins?
      #form: linear
      #direction: positive
      #strength: weak relationship
      #no unusual observations



#Visualizing relationship between one numerical variable and one categorical variable
#Describing relationship between one numerical variable and one categorical variable
      #Conditional distributions
      #Given levels of categorical variable, difference in
          #shape
          #center
          #spread
          #unusual observations
#Overlaid Histograms
ggplot(penguins, aes(x = body_mass_g, fill = species)) +
  geom_histogram() 
#Overlaid Density plots
ggplot(penguins, aes(x = body_mass_g, fill = species)) +
  geom_density() 
#Customize
ggplot(penguins, aes(x = body_mass_g, fill = species)) +
  geom_density(adjust = 1.5,
               alpha = 0.5) +    #alpha determines opacity
  scale_fill_manual(values = c("darkred","darkorchid","cyan4")) +
  theme_minimal() +
  labs( 
    x = "Body Mass (g)", 
    y = "Density",
    fill = "Species",
    title = "Penguins on Palmer Islands",
    caption = "Source: Palmer Station LTER / palmerpenguins package"
  )

#Side-by-side Box plots
ggplot(penguins, aes(x = body_mass_g, y = species)) +
  geom_boxplot() 
ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot() 
#Side-by-side Box plots (Base R)
boxplot(body_mass_g ~ species, data = penguins)

#What have we learned about the relationship between species & body mass?
          #shape: all are unimodal and slightly right skewed
          #center: Gentoo are biggest, Adelie are slightly smaller than Chinstrap
          #spread: Chinstrap have smallest variation, Adelie and Gentoo are similar
          #no unusual observations



#Visualizing relationship between two categorical variables
#Describing relationship between two categorical variables
    #Conditional frequencies / relative frequencies
    #Given levels of one categorical variable, difference in proportion of 
    #    levels of other categorical variable
#Panel of bar charts using facet_wrap
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(alpha = 0.8) +
  facet_wrap(~ species) +
  theme_minimal() +
  labs( 
    title = "Penguins on Palmer Islands",
    caption = "Source: Palmer Station LTER / palmerpenguins package"
  ) +
  scale_fill_manual(values = c("darkred","darkorchid","cyan4"), 
                    guide = FALSE) 

#Stacked Bar plot
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar() 
#Segmented Bar Plot
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill") 

#What have we learned about the relationship between island & species?
    #Adelie penguins are on all three islands
    #Chinstrap penguins are only on Dream
    #Gentoo penguins are only on Biscoe

#Lecture Review
#Visualizing two variables
  #Both numerical: scatterplot
  #One numerical and one categorical: overlaid histograms, density plots, 
  #   side-by-side box plots
  #Both categorical: separate bar charts, complex bar charts

#Appendix: Variations on Scatterplots
  #big data / overlaid dots, details of geom_smooth, contours (instead of curve)


#Variations on Scatterplots: With big data and/or overlaid dots
ggplot(adelie, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(size = 5, color = "darkorange", alpha = 0.5) +
  geom_smooth(span = 1.0, color = "saddlebrown", fill = "tan")

#Scatterplot with curve but no uncertainty bands
ggplot(adelie, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point() +
  geom_smooth(span = 1.0, se = FALSE)

#Scatterplot with lines
ggplot(adelie, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point() +
  geom_smooth(method = "lm")

#Scatterplot with bivariate distribution countours
ggplot(adelie, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point() + 
  geom_density2d(adjust = 2)

