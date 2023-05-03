# dalearningCCA
# check optimal choice calculation
# 4.14.23 KLS

# load required packages
library(here)
library(tidyverse)

# load source functions
source(here('scr', 'clean_calc_trial_level_data.R'))

# set hard-coded variables

# read in data
trial_data <- read.csv(here('data', 'stock-bond_trial-level_data.csv'))
sub_data <- read.csv(here('data', 'stock-bond_subject-level_data.csv'))

# limit to 35 subs included
df <- limit_to_sample(trial_data, sub_data)
rm(trial_data, sub_data)

# identify optimal choice for each block
df <- id_optimal_choice(df)

dt <- df %>% group_by(subject, block_number, stock_quality_1, stock_quality_2, domain, optimal_choice) %>% summarize(
  mean_stock_payout = mean(outcome)
)

dt <- dt %>% mutate(
  block_type = case_when(domain == 'Gain' & mean_stock_payout > 6 ~ 'good', 
                         domain == 'Loss' & mean_stock_payout > -6 ~ 'good', 
                         domain == 'Gain' & mean_stock_payout == 6 ~ 'ambiguous', 
                         domain == 'Loss' & mean_stock_payout == -6 ~ 'ambiguous', 
                         TRUE ~ 'bad'
                         )
)

table(dt$block_type)
