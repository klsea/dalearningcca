# dalearningCCA
# clean subject-level data
# 4.13.23 KLS

# load required packages
library(here)
library(tidyverse)

# load source functions

# set hard-coded variables

# read data in and create combined data frame
df <- data.frame(matrix(ncol = 17, nrow = 0))
names <- c('subject', 'stock_quality_1', 'stock_quality_2', 'domain', 'block_trial', 
                  'current_earnings', 'choice', 'choice_rt', 'confidence_rating', 
                  'confidence_rating_rt', 'objective_probability', 'outcome', 
                  'prob_estimate', 'prob_estimate_rt', 'total_earnings')
colnames(df) <- names

#  loop thru participants files 
files <- list.files(here('data', 'sub_level'))

for (file in files) {
  dt <- read.table(here('data', 'sub_level', file), 
                   sep = '\t', header = TRUE)
  
  # clean data file
  dt <- dt %>% filter(Procedure.Block. == 'Real')
  dt <- dt[c(2, 53, 54, 56, 57, 60, 61, 62, 58, 59, 75, 76, 85, 86, 91)] #grep('InvestmentChoice.RESP', colnames(dt))
  colnames(dt) <- names
  dt$cumulative_trial <- seq(1:60)
  dt$block_number <- rep(1:10, each = 6)
  
  # reorgannize
  dt <- dt[c(1, 17, 16, 5, 2:4, 7:8, 13:14, 9:10, 12, 6, 11, 15)]
  df <- rbind(df, dt)
}

write.csv(df, here('data', 'stock-bond_trial-level_data.csv'), row.names = FALSE)
