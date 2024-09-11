#Multivariate data analysis
library(tidyverse)
library(palmerpenguins)
penguins

#Color
ggplot(penguins,
       aes(x = bill_depth_mm, 
           y = bill_length_mm,
           color = species)) + 
  geom_point() +
  labs( 
    x = "Bill depth (mm)", 
    y = "Bill length (mm)",
    color = "Penguin Species",
    title = "Bill depth and length",
    subtitle = "Penguins on Palmer Islands",
    caption = "Source: Palmer Station LTER / palmerpenguins package"
  ) +
  scale_color_manual(values = c("darkorange","darkorchid","cyan4"))
#Shape
ggplot(penguins,
       aes(x = bill_depth_mm, 
           y = bill_length_mm,
           shape = species)) +
  geom_point() 
#Color and Shape
ggplot(penguins,
       aes(x = bill_depth_mm, 
           y = bill_length_mm,
           color = species,
           shape = species)) + 
  geom_point() +
  scale_color_manual(values = c("darkorange","darkorchid","cyan4"))

#Create panel of plots with faceting `facet_wrap`
ggplot(penguins,
       aes(x = bill_depth_mm, 
           y = bill_length_mm)) +
  geom_point() +
  facet_wrap(~ species)
#Same as
ggplot(penguins,
       aes(x = bill_depth_mm, 
           y = bill_length_mm)) +
  geom_point() +
  facet_wrap(. ~ species)
#Switch it up
ggplot(penguins,
       aes(x = bill_depth_mm, 
           y = bill_length_mm)) +
  geom_point() +
  facet_wrap(~ species, ncol = 2)
#or stack horizontally
ggplot(penguins,
       aes(x = bill_depth_mm, 
           y = bill_length_mm)) +
  geom_point() +
  facet_wrap(~ species, ncol = 1)

#For each species, what have we learned about the relationship between bill measurements?
    #form: all species linear
    #direction: all species positive
    #strength: Adelie weak, Chinstrap and Gentoo moderate relationship
    #unusual observations: Chinstrap and Gentoo each have an outlier bill length

#What are the differences between species?
    #Adelie have long bill depth and small bill length
    #Chinstrap have large bill depth and length
    #Gentoo have small bill depth with large bill length

#What if the “3rd variable” is not categorical?
    #Is there a difference between small / large body mass?

#Convert numerical to categorical `cut_interval`
ggplot(penguins,
       aes(x = bill_depth_mm, 
           y = bill_length_mm)) +
  geom_point() +
  facet_wrap(~ cut_interval(body_mass_g, 2)) #eg.small and big penguins
#Real data has missing values so the NA is the missing data
#Remove Missing Values using `na.omit`
penguins |>
  na.omit() |>
  ggplot(aes(x = bill_depth_mm, 
             y = bill_length_mm)) +
  geom_point() +
  facet_wrap(~ cut_interval(body_mass_g, 3))

#What about 4 Variables? `body_mass_g`, `bill_length_mm`, `bill_depth_mm`, 
  # `flipper_length_mm`, so are “big” penguins large in all 4 measurements?

#Create matrix panel of plots with `facet_grid`
penguins |>
  na.omit() |>
  ggplot(aes(x = bill_depth_mm, 
             y = bill_length_mm)) +
  geom_point() +
  facet_grid(cut_interval(flipper_length_mm, 2) #rows
             ~ cut_interval(body_mass_g, 2)) #columns

#Bill measurements by species and island
ggplot(penguins,
       aes(x = bill_depth_mm, 
           y = bill_length_mm)) +
  geom_point() +
  facet_grid(species ~ island)
#Can do this with aes options
ggplot(penguins,
       aes(x = bill_depth_mm, 
           y = bill_length_mm,
           color = species,
           shape = island)) + 
  geom_point() +
  scale_color_manual(values = c("darkorange","darkorchid","cyan4"))
#Can combine aes options with faceting
ggplot(penguins,
       aes(x = bill_depth_mm, 
           y = bill_length_mm,
           color = species)) + 
  geom_point() +
  facet_wrap(~ island) +
  scale_color_manual(values = c("darkorange","darkorchid","cyan4"))


#Quick look at many variables
library(GGally)
penguins |>
  select(species, body_mass_g, ends_with("_mm")) |>
  ggpairs(aes(color = species)) +
  scale_colour_manual(values = c("darkseagreen2","lightpink","skyblue1")) +
  scale_fill_manual(values = c("darkseagreen2","lightpink","skyblue1"))



#Summary Statistics (Table 1)
library(table1)
table1(~ island + bill_length_mm + bill_depth_mm, data = penguins)
#Separate Summary Statistics by species
table1(~ island + bill_length_mm + bill_depth_mm | species, 
       data = penguins)
#Customize
# variables have desired names and units
label(penguins$island) <- "Island"
label(penguins$bill_length_mm) <- "Bill Length"
label(penguins$bill_depth_mm) <- "Bill Depth"
label(penguins$species) <- "Species"

units(penguins$bill_length_mm) <- "mm"
units(penguins$bill_depth_mm) <- "mm"

table1(~ island + bill_length_mm + bill_depth_mm | species, 
       data = penguins,
       overall = "Total",
       caption = "Penguins on Palmer Islands", 
       footnote = "Source: Palmer Station LTER / palmerpenguins package")

#Base R
summary(penguins)
mean(penguins$body_mass_g, na.rm = TRUE)
median(penguins$body_mass_g, na.rm = TRUE)
cor(penguins$body_mass_g, penguins$flipper_length_mm, 
    use = "pairwise.complete.obs")

#Lecture Review
#Visualizing multivariate relationships
    #more aes
    #faceting
    #GGalley::ggpairs
  #Summary Statistics (Table 1)
  #Appendix:
    #Just because we can do something doesn’t mean it communicates to the audience
    #More Base R Summary Statistics
    #Adding Text to Graphics

# Just because we can do something, does it communicate to our audience?
# aes options
ggplot(penguins,
       aes(x = bill_depth_mm, 
           y = bill_length_mm,
           color = species,
           size = body_mass_g)) + 
  geom_point() +
  scale_color_viridis_d()
# alpha transparancy
ggplot(penguins,
       aes(x = bill_depth_mm, 
           y = bill_length_mm,
           color = species,
           size = body_mass_g,
           alpha = flipper_length_mm)) + 
  geom_point() +
  scale_color_viridis_d()

#More Base R Summary Statistics
#Base R
#Frequency Table
table(penguins$island)
#Relative Frequency Table
table(penguins$island) |>
  prop.table()
var(penguins$body_mass_g, na.rm = TRUE)
min(penguins$body_mass_g, na.rm = TRUE)
max(penguins$body_mass_g, na.rm = TRUE)
#Quantile Percentile
quantile(penguins$body_mass_g, 
         probs = 0.75,
         na.rm = TRUE)
quantile(penguins$body_mass_g, 
         probs = c(0.1, 0.25, 0.50, 0.75, 0.90),
         na.rm = TRUE)

#Adding Text to Graphics
ggplot(penguins,
       aes(x = body_mass_g, 
           y = flipper_length_mm,
           color = species)) + 
  geom_point() +
  labs( 
    x = "Body Mass (g)", 
    y = "Flipper length (mm)",
    color = "Penguin Species",
    title = "Weight and Flipper",
    subtitle = "Penguins on Palmer Islands",
    caption = "Source: Palmer Station LTER / palmerpenguins package"
  ) +
  annotate(
    geom = "label", 
    x = 5000, y = 190,
    label = "Heavier Penguins have\nLonger Flippers",
    hjust = "left", 
    color = "black"
  ) + 
  scale_color_manual(values = c("darkorange","darkorchid","cyan4"))

#BaseR
plot(flipper_length_mm ~ body_mass_g, data = penguins)
text(5000, 190, "Heavier Penguins have\nLonger Flippers", adj = 0)









