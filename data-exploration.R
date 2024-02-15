# the following exercises are a test in disguise. 
# what do you think about the coding? 
# can you think of any improvements to the following?

rm(list=ls()) # always clean up your environment! 

# install.packages("tidyverse") #uncomment to install tidyverse if you haven't already

library(tidyverse)
library(dbplyr)

## PROBLEM 1 ##

> visualizing your data is important!
> summary statistics can be highly misleading, and simply plotting the data can reveal a lot more!
> Lets look at the Anscombe’s Quartet data. There are four different data sets.
> Anscombe, F. J. (1973). "Graphs in Statistical Analysis". American Statistician. 27 (1): 17–21. doi:10.1080/00031305.1973.10478966. JSTOR 2682899.

anscombe_quartet = readRDS("/Users/kezhuniu/Desktop/Longi_Prac/LDP_W5/anscombe_quartet.rds")

# let's explore the dataset 
str(anscombe_quartet)
glimpse(anscombe_quartet)

# what does the function str() do? 
#str function displays the structure of a dataset, an alternative to summary 

# let's check some summary statistics:

anscombe_quartet %>% 
  group_by(dataset) %>% 
  summarise(
    mean_x    = mean(x),
    mean_y    = mean(y),
    min_x     = min(x),
    min_y     = min(y),
    max_x     = max(x),
    max_y     = max(y),
    crrltn    = cor(x, y)
  )

# what do the summary statistics tell us about the different datasets? 
#The summary statistics show the mean, minimum, maximum and correlation coefficient for x and y values in each of the four datasets 

# let's plot the data with ggplot:

require(ggplot2)

 ggplot(anscombe_quartet, aes(x=x,y=y)) +
  geom_point() + 
  geom_smooth(method = "lm",formula = "y ~ x") +
  facet_wrap(~dataset)

#save the plot

ggsave("anscombe_quartet.png", width = 20, height = 20, units = "cm")

### What do the plots tell us about the different datasets?
#The distribution of data points in the four datasets are different. Data in the first and the third datasets are linear, but the first dataset has a larger variance (than the third dataset). dataset 2 is a polynormial and dataset 4 all values are the same except for one outlier. 

### Describe the relationship between x and y in the different datasets
#Positive correlation in dataset 1 and 3, polynormial in dataset 2, pseudo-correlation in dataset 4 

### Would linear regression be an appropriate statistical model to analyse the x-y relationship in each dataset?
#Linear regression would be appropriate for analyzing dataset 1 and 3 but not 2 and 4

### What conclusions can you draw for the plots and summary statistics?
#Distribution of data within each dataset is not consistent with the summary statistics. Dataset 1 and 3 show linear positive correlations, but dataset 2 and 4 are non-linear distributions. So we cannot infer the distribution of a whole dataset based only on its summary statistics. 




## PROBLEM 2 ##

# load in the datasaurus dataset
datasaurus_dozen <- readRDS("/Users/kezhuniu/Desktop/Longi_Prac/LDP_W5/datasaurus_dozen.rds")

# explore the dataset 
glimpse(datasaurus_dozen)

# how many rows and columns does the datasaurus_dozen file have? 
#1846 rows and 3 columns 

# plot the dataset 
ggplot(datasaurus_dozen, aes(x=x, y=y)) + 
  geom_point() +
  geom_smooth(method = "lm", formula = "y~x")

# calculate the correlations and summary statistics for x and y in all datasets: 
datasaurus_dozen %>%
   group_by(dataset) %>%
  summarise(mean_x = mean(x),
            mean_y = mean(y),
            max_x = max(x),
            max_y = max(y),
            min_x = min(x),
            min_y = min(y),
            cor_x.y = cor(y,x)
          )

# Plot the relationships between x and y in each dataset including the line of best fit.
ggplot(datasaurus_dozen, aes(x=x, y=y)) + 
  geom_point() +
  geom_smooth(method = "lm", formula = "y~x") +
  facet_wrap(~dataset)

# save the plot 
ggsave("datasaurus.png", width = 20, height = 20, unit = "cm")

# what conclusions can you draw for the plots and summary statistics? 
#Even though all datasets have negative correlations, the distribution of data points in none of the dataset is linear. Therefore, presence of significant correlation might not capture the distribution of the whole dataset, careful check of the distribution of the whole dataset is necessary before any further analysis. 