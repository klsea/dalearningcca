# dalearningCCA
# means and sds
# 4.10.23 KLS

# load required packages
library(here)
library(tidyverse)

# load source functions

# set hard-coded variables

# read data in
dt <- read.csv(here('data', 'stock-bond_subject-level_data.csv'))
dt <- dt %>% filter(complete.cases(.))
dt <- dt[-grep('_notpvc', colnames(dt))]
dt <- dt[-grep('hippocampus', colnames(dt))]
dt <- dt[-grep('thalamus', colnames(dt))]

# calc means and sds
means <- colMeans(dt[2:11])
sds <- apply(dt[2:11], 2, sd)

# make pretty table
table <- cbind(means, sds)


