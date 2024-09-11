#Types of variables
#Numerical variables can be classified as *Continuous or *Discrete based on 
#  whether or not the variable can take on an infinite number of values or only 
#  non-negative whole numbers, respectively.
#If the variable is categorical, we can determine if it is *ordinal based on 
#  whether or not the levels have a natural ordering.

#Univariate data analysis - distribution of single variable
#Bivariate data analysis - relationship between two variables
#Multivariate data analysis - relationship between many variables at once, 
#   usually focusing on the relationship between two while conditioning for others

library(tidyverse)
library(palmerpenguins)
glimpse(penguins)
#Environment --> Global Environment --> package:palmerpenguins

adelie <- penguins |>
  filter(species == "Adelie") |>
  na.omit()
adelie

#body_mass_g	      numerical, continuous
#bill_length_mm	    numerical, continuous
#bill_depth_mm	    numerical, continuous
#flipper_length_mm	numerical, continuous
#species          	categorical, not ordinal
#island	            categorical, not ordinal
#sex	              categorical, not ordinal
#year	              numerical, discrete

#Describing shapes of numerical distributions
# -shape:
#    -skewness: right-skewed, left-skewed, symmetric (skew is to the side of the
#               longer tail)
#    -modality: unimodal, bimodal, multimodal, uniform
# -center: mean (mean), median (median), mode (not always useful)
# -spread: range (range), standard deviation (sd), inter-quartile range (IQR)
# -unusual observations

#HISTOGRAMS
ggplot(adelie, aes(x = body_mass_g)) +
  geom_histogram()

ggplot(adelie, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 100)

ggplot(adelie, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 100, color = "black", fill = "darkorange") +
  labs( 
    x = "Body Mass (g)", 
    y = "Frequency", 
    title = "Adelie Penguins on Palmer Islands"
  )

hist(adelie$body_mass_g)
hist(adelie$body_mass_g, breaks = 20)
hist(adelie$body_mass_g, breaks = 6) #gives 5

hist(adelie$body_mass_g, breaks = 5,
     xlab = "Body Mass (g)", 
     ylab = "Frequency", 
     main = "Adelie Penguins on Palmer Islands")

#Density Plots
ggplot(adelie, aes(x = body_mass_g)) +
  geom_density()
#Adjusting Density plots
ggplot(adelie, aes(x = body_mass_g)) +
  geom_density(adjust = 0.5)

ggplot(adelie, aes(x = body_mass_g)) +
  geom_density(adjust = 0.9)

ggplot(adelie, aes(x = body_mass_g)) +
  geom_density() #adjust = 1

ggplot(adelie, aes(x = body_mass_g)) +
  geom_density(adjust = 2)

#fancy density plot
ggplot(adelie, aes(x = body_mass_g)) +
  geom_density(adjust = 0.9, fill = "darkred", alpha = 0.5) +
  xlim(2300, 5200) +
  labs( 
    x = "Body Mass (g)", 
    y = "Density", 
    title = "Adelie Penguins on Palmer Islands"
  )


#Density Plot (Base R)
plot(density(adelie$body_mass_g), type = "l")

plot(density(adelie$body_mass_g, adjust = 0.9), type = "l")
#customize
plot(density(adelie$body_mass_g, adjust = 0.9), type = "l",
     xlab = "Body Mass (g)", 
     main = "Adelie Penguins on Palmer Islands")


#BOXPLOTS
ggplot(data = adelie, aes(x = body_mass_g)) +
  geom_boxplot()

ggplot(data = adelie, aes(x = body_mass_g)) +
  geom_boxplot(color = "black", fill = "darkorange") +
  labs( 
    x = "Body Mass (g)", 
    y = NULL, 
    title = "Adelie Penguins on Palmer Islands"
  ) +
  theme( 
    axis.ticks.y = element_blank(), 
    axis.text.y = element_blank() 
  ) 

#BoxPlot Base R
boxplot(adelie$body_mass_g)

boxplot(adelie$body_mass_g,
        ylab = "Body Mass (g)", 
        main = "Adelie Penguins on Palmer Islands")


#What have we learned about the Adelie penguin Body Mass?

#Shape: nearly symmetric, with a slight skew toward larger values. Unimodel
#Center: 3700 g
#Spread:IQR about 600 g
#no unusual observations

#VISUALIZING CATEGORICAL DATA
#Frequencey or Relative Frequency of categorical data distributions
#   most likely category
#   least likely category
#   unusual observations

#BARPLOT
#Bar plot (frequency)
ggplot(adelie, aes(x = island)) +
  geom_bar()

ggplot(adelie, aes(x = island)) +
  geom_bar(aes(y = ..prop.., group = 1))

#Pareto chart
#    focus attention on the highest frequency categories
ggplot(adelie, aes(x = fct_infreq(island))) +
  geom_bar()

ggplot(adelie, aes(x = fct_infreq(island))) +
  geom_bar(aes(y = ..prop.., group = 1))

ggplot(adelie, aes(x = fct_infreq(island))) +
  geom_bar(aes(y = ..prop.., group = 1),
           color = "black", fill = "purple") +
  labs( 
    x = NULL, 
    y = "Proportion", 
    title = "Adelie Penguins on Palmer Islands"
  )

#What have we learned about the Adelie penguin Location?

#Found in all three islands
#While approximately equally distributed, slightly more on Dream


#Lecture Review
# Visualizing numerical data: histograms, density plots, box plots
# Visualizing categorical data: bar plot, Pareto chart
# Appendix: Assessing Normality - Q-Q plots, drawing Normal on density plot,  
#                                 Normality Goodness of Fit Test

#Q-Q plot
ggplot(data = adelie, aes(sample = body_mass_g)) +
  geom_qq() +
  geom_qq_line()
#customize
ggplot(data = adelie, aes(sample = body_mass_g)) +
  geom_qq() +
  geom_qq_line() +
  labs( 
    y = "Body Mass (g)", 
    title = "Q-Q plot",
    subtitle = "dots linear if Normally distributed",
    caption = "Adelie Penguins on Palmer Islands"
  ) 

#Q-Q plot (base R)
qqnorm(adelie$body_mass_g)
qqline(adelie$body_mass_g)

#Overlay Normal PDF on Density Plot
ggplot(adelie, aes(x = body_mass_g)) +
  geom_density(adjust = 0.9) +
  stat_function(fun = dnorm,
                args = list(mean = mean(adelie$body_mass_g),
                            sd = sd(adelie$body_mass_g)),
                col = "royalblue") +
  xlim(2300, 5200) +
  labs( 
    x = "Body Mass (g)", 
    y = "Density", 
    title = "Adelie Penguins on Palmer Islands"
  )

#Overlay in base R
plot(density(adelie$body_mass_g, adjust = 0.9), type = "l",
     xlab = "Body Mass (g)", 
     main = "Adelie Penguins on Palmer Islands")
curve(dnorm(x, 
            mean = mean(adelie$body_mass_g), 
            sd = sd(adelie$body_mass_g)), 
      col = "royalblue", add=TRUE)


#Normality Goodness of Fit Test
#    Ho: Normally Distributed
#    If we reject Ho (small p-value) then non-normal
#    If we fail to reject (large p-value) then assume normality

#Normality Goodness of Fit Test
shapiro.test(adelie$body_mass_g)
# Shapiro-Wilk normality test
data:  adelie$body_mass_g
W <- 0.98116 
p-value <- 0.04232

ks.test(adelie$body_mass_g, 
        "pnorm", mean(adelie$body_mass_g), 
        sd(adelie$body_mass_g) )

# Asymptotic one-sample Kolmogorov-Smirnov test
data:  adelie$body_mass_g
D <- 0.07162
p-value <- 0.4423
#alternative hypothesis: two-sided

#Conclude Adelie penguin Body Mass is approximately normal

