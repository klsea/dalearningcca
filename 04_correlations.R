# dalearningCCA
# means and sds
# 4.12.23 KLS

# load required packages
library(here)
library(tidyverse)
library(Hmisc)

# load source functions
source(here('scr', 'corrTableCI.R'))
source(here('scr', 'pcorTableCI.R'))
source(here('scr', 'CIcorr.R'))

# set hard-coded variables

# read data in
dt <- read.csv(here('data', 'stock-bond_subject-level_data.csv'))
dt <- dt %>% filter(complete.cases(.))
dt <- dt[-grep('_notpvc', colnames(dt))]
dt <- dt[-grep('hippocampus', colnames(dt))]
dt <- dt[-grep('thalamus', colnames(dt))]

# correlation table
corTable <- corrTableCI(dt[2:11])
write.csv(corTable, here('figs', 'dalearningCCA_bv_correlations.csv'), row.names = FALSE)
