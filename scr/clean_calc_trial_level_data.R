limit_to_sample <- function(trial_level_data, subject_level_data) {
  subs <- subject_level_data[complete.cases(subject_level_data), ][1]
  df <- merge(trial_level_data, subs, by = 'subject')
  df <- df[order(df$subject, df$cumulative_trial),]
  return(df)
}

id_optimal_choice <- function(data) {
  data$odd_block <- data$block_number %% 2
  dt <- data %>% mutate(
    optimal_choice = case_when(odd_block == 1 & stock_quality_1 == 'bad' ~ 0, 
                               odd_block == 0 & stock_quality_2 == 'bad' ~ 0, 
                               TRUE ~ 1)
  )
  return(dt)
}

labels_for_graph <- function(data) {
  data$optimal_choice <- recode(data$optimal_choice, '1'='Stock is Good', '0'='Stock is Bad')
  data$optimal_choice <- factor(data$optimal_choice)
  data$domain <- recode(data$domain, 'Gain'='Gain Frame', 'Loss'='Loss Frame')
  return(data)
}
