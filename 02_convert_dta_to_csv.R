# dalearningCCA
# read stata data into r
# 4.17.23 KLS

# load required packages
library(here)
#library(tidyverse)
library(haven)

# load source functions

# set hard-coded variables

# read data in 
dt <- read_dta(here('data', 'flb_pvcdata.dta'))

# save as txt file
write.csv(dt, here('data', 'flb_pvcdata.csv'), row.names = FALSE)
