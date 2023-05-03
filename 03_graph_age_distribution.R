# dalearningCCA
# distribution of age
# 4.10.23 KLS

# load required packages
library(here)
library(tidyverse)
library(ggplot2)

# load source functions

# set hard-coded variables

# read data in
dt <- read.csv(here('data', 'stock-bond_subject-level_data.csv'))
dt <- dt %>% filter(complete.cases(.))

# age distribution
age <- ggplot(dt, aes(x=age)) + 
  geom_histogram(aes(y=..density..), binwidth = 10) + 
  geom_density(alpha=.2, fill="#FF6666") + 
  geom_vline(aes(xintercept=mean(age)),
             color="blue", linetype="dashed", size=1) +
  xlab('Age') + ggtitle('Age Distribution') + theme_bw() 

ggsave(here('figs', 'dalearningCCA_age.png'), age)
