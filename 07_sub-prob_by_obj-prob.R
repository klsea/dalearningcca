# dalearningCCA
# trial-level stock choices graph
# 4.14.23 KLS

# load required packages
library(here)
library(tidyverse)
library(ggplot2)

# load source functions
source(here('scr', 'clean_calc_trial_level_data.R'))

# set hard-coded variables

# read in data
trial_data <- read.csv(here('data', 'stock-bond_trial-level_data.csv'))
sub_data <- read.csv(here('data', 'stock-bond_subject-level_data.csv'))

# limit to 35 subs included
df <- limit_to_sample(trial_data, sub_data)
rm(trial_data, sub_data)
df$prob_estimate <- df$prob_estimate/100

subject <- df %>% group_by(subject, domain, objective_probability) %>% summarize(
  n = n(),
  mean_est = mean(prob_estimate, na.rm = TRUE)
)

group <- subject %>% group_by(domain, objective_probability) %>% summarize(
  n = n(), 
  sub_prob = mean(mean_est, na.rm = TRUE), 
  se = sd(mean_est)/sqrt(n)
)

# graphs
plot1 <- ggplot(subject, aes(objective_probability, mean_est)) +
  geom_point(shape = 1, position=position_jitter(width=.05,height=.05), color = 'blue', alpha = .35) +
  geom_abline(intercept = 0, slope = 1, linetype = 'dashed', alpha = .5) +
  geom_smooth() + 
  xlab('Objective Probability') + ylab('Subjective Probabilty') +
  theme_bw()
plot1

plot2 <- ggplot(group, aes(objective_probability, sub_prob, colour = domain)) +
  geom_point(shape = 1) +
  geom_errorbar(aes(min=sub_prob-se, max = sub_prob+se)) +
  geom_line() +
  geom_abline(intercept = 0, slope = 1, linetype = 'dashed', alpha = .5) +
  xlab('Objective Probability') + ylab('Subjective Probabilty') +
  theme_bw() + expand_limits(y =c(0,1)) + 
  scale_colour_brewer(palette="Set1", name="Domain") 
plot2
