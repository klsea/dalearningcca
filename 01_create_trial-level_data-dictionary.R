# dalearningCCA
# data dictionary for subject-level data
# 4.13.23 KLS

# load required packages
library(here)
library(tidyverse)

# load source functions

# set hard-coded variables

# read in data
dt <- read.csv(here('data', 'stock-bond_trial-level_data.csv'))

# create data dictionary 
dd <- t(dt[1,])
dd <- as.data.frame(rownames(dd))
colnames(dd) <- c('Variable')

# make factors
dt$subject <- factor(dt$subject)
dt$stock_quality_1 <- factor(dt$stock_quality_1)
dt$stock_quality_2 <- factor(dt$stock_quality_2)
dt$domain <- factor(dt$domain)

# create and populate variable name field ####
dd[,'variable_names'] <- NA 
dd$variable_names[grep('subject', dd$Variable)] <- 'participant ID'
dd$variable_names[grep('block_number', dd$Variable)] <- 'Block Number'
dd$variable_names[grep('cumlative_trial', dd$Variable)] <- 'Cumulative Trial Number'
dd$variable_names[grep('block_trial', dd$Variable)] <- 'Trial Number within Block'
dd$variable_names[grep('stock_quality_1', dd$Variable)] <- 'Stock Quality for odd blocks'
dd$variable_names[grep('stock_quality_2', dd$Variable)] <- 'Stock Quality for even blocks'
dd$variable_names[grep('domain', dd$Variable)] <- 'Stock Domain'
dd$variable_names[grep('choice', dd$Variable)] <- 'Stock/Bond Choice'
dd$variable_names[grep('choice_rt', dd$Variable)] <- 'Stock/Bond Choice Response Time'
dd$variable_names[grep('prob_estimate', dd$Variable)] <- 'Probability Good Stock'
dd$variable_names[grep('prob_estimate_rt', dd$Variable)] <- 'Probablity Good Stock Response Time'
dd$variable_names[grep('confidence_rating', dd$Variable)] <- 'Confidence in Probabilty Rating'
dd$variable_names[grep('confidence_rating_rt', dd$Variable)] <- 'Confidence in Probabilty Rating Response Time'
dd$variable_names[grep('outcome', dd$Variable)] <- 'Outcome of Stock'
dd$variable_names[grep('current_earnings', dd$Variable)] <- 'Earnings on Current Trial'
dd$variable_names[grep('objective_probability', dd$Variable)] <- 'Objective Probablity after this trial'
dd$variable_names[grep('total_earnings', dd$Variable)] <- 'Total amount of money earned so far'

# create and populate measurement units ####
dd$measurement_units <- sapply(dt, class)
dd$measurement_units[grep('prob_estimate', dd$Variable)] <- 'percentage'
dd$measurement_units[grep('_rt', dd$Variable)] <- 'ms'
dd$measurement_units[grep('earnings', dd$Variable)] <- 'dollars'

# Create and populate allowed_values field ####
dd[,'allowed_values'] <- NA 
dd$allowed_values[grep('subject', dd$Variable)] <- 'four digit number between 1000 and 2000'
dd$allowed_values[grep('block_number', dd$Variable)] <- '1-10'
dd$allowed_values[grep('cumulative_trial', dd$Variable)] <- '1-60'
dd$allowed_values[grep('block_trial', dd$Variable)] <- '1-6'
dd$allowed_values[grep('stock_quality_1', dd$Variable)] <- 'good or bad'
dd$allowed_values[grep('stock_quality_2', dd$Variable)] <- 'good or bad'
dd$allowed_values[grep('domain', dd$Variable)] <- 'Gain or Loss'
dd$allowed_values[grep('choice', dd$Variable)] <- '1 = stock or 0 = bond'
dd$allowed_values[grep('choice_rt', dd$Variable)] <- 'positive integer'
dd$allowed_values[grep('prob_estimate', dd$Variable)] <- 'positive integer between 0-100'
dd$allowed_values[grep('prob_estimate_rt', dd$Variable)] <- 'positive integer'
dd$allowed_values[grep('confidence_rating', dd$Variable)] <- 'positive integer 1-9'
dd$allowed_values[grep('confidence_rating', dd$Variable)] <- 'positive integer'
dd$allowed_values[grep('outcome', dd$Variable)] <- '-10, -6, -2, 2, 6, 10'
dd$allowed_values[grep('current_earnings', dd$Variable)] <- '-10, -6, -2, 2, 6, 10'
dd$allowed_values[grep('objective_probablity', dd$Variable)] <- '0-1'
dd$allowed_values[grep('total_earnings', dd$Variable)] <- 'integer'

#create and populate description field ####
dd[,'description'] <- NA 
dd$description[grep('stock_quality_1', dd$Variable)] <- 'good: pays higher 
value 70% of the time, lower value 30% of the time; 
bad: pays lower value 70% of the time, higher value 30% of the time'
dd$description[grep('stock_quality_2', dd$Variable)] <- 'good: pays higher 
value 70% of the time, lower value 30% of the time; 
bad: pays lower value 70% of the time, higher value 30% of the time'
dd$description[grep('domain', dd$Variable)] <- 'Gain: $10 or $2; Loss: -$2 or -$10'
dd$description[grep('prob_estimate', dd$Variable)] <- "Subject's estimate of probability that this is the good stock"
dd$description[grep('confidence_rating', dd$Variable)] <- "Subject's confidence in estimate of probability - 'How much do you trust your probability estimate?'"
dd$description[grep('outcome', dd$Variable)] <- 'Outcome of the stock'
dd$description[grep('current_earnings', dd$Variable)] <- 'Earnings on Trial based on choice'
dd$description[grep('objective_probability', dd$Variable)] <- 'Objective Basyesian posterior Probability that the stock is paying from the good distribution'
dd$description[grep('total_earnings', dd$Variable)] <- 'Earnings so far on task'

# save file ####
write.csv(dd, here('data', 'stock-bond_trial-level_data_dictionary.csv'), row.names = FALSE)
