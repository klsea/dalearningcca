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

subject <- df %>% group_by(subject, domain, objective_probability) %>% summarize(
  n = n(),
  mean_choice = mean(choice, na.rm = TRUE)
)

group <- subject %>% group_by(domain, objective_probability) %>% summarize(
  n = n(), 
  stock_choice = mean(mean_choice, na.rm = TRUE), 
  se = sd(mean_choice)/sqrt(n)
)
# graphs
plot <- ggplot(group, aes(objective_probability, stock_choice, colour = domain)) +
  geom_point(shape = 1) +
  geom_errorbar(aes(min=stock_choice-se, max = stock_choice+se)) +
  geom_line() +
  geom_abline(intercept = 0, slope = 1, linetype = 'dashed', alpha = .5) +
  xlab('Objective Probability') + ylab('Stock Choice') +
  theme_bw() + expand_limits(y =c(0,1)) + 
  scale_colour_brewer(palette="Set1", name="Domain") 
plot

# plot1 <- ggplot(subject, aes(objective_probability, mean_choice)) +
#   geom_point(shape = 1, position=position_jitter(width=.05,height=.05), color = 'blue', alpha = .35) +
#   geom_abline(intercept = 0, slope = 1, linetype = 'dashed', alpha = .5) +
#   geom_smooth(method="glm", method.args=list(family="binomial")) + 
#   xlab('Objective Probability') + ylab('Proportion of Stock Choices') +
#   theme_bw()
# plot1
# 
# plot2 <- ggplot(subject, aes(objective_probability, mean_choice)) + 
#   geom_point(shape = 1, position=position_jitter(width=.05,height=.05)) +
#   geom_boxplot(data = subject, aes(objective_probability, mean_choice, group = objective_probability, 
#                                  color = 'red', fill = 'red', alpha=.01), width=.05) + 
#   expand_limits(y=c(0,1)) +
#   xlab('Objective Probability') + ylab('Proportion of Stock Choices') +
#   theme_bw() + theme(legend.position = 'none') + facet_wrap(~block_trial)
# plot2


