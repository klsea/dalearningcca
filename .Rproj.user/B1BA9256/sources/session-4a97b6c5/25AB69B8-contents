# dalearningCCA
# CCA from Mikella modified with new ROIs
# 4.17.23 KLS

# load required packages
library(here)
library(tidyverse)
library(yacca)
library(CCP)

# load source functions

# set hard-coded variables

# read data in
d1 <- read.csv(here('data', 'stock-bond_subject-level_data.csv'))
d1 <- na.omit(d1)
d2 <- read.csv(here('data', 'flb_pvcdata.csv'))
dt <- merge(d1, d2, by = c('subject', 'age'))


# #age, midbrain, amygdala, insula, acc
# d2r <- data[c(2,8,14,16,18)]

grep('thalamus', colnames(dt))
# age, temporal, parietal, frontal, thalamus
d2r <- dt[c(2, 23, 27, 29, 17)]

#decision making
dm <- dt[3:7]

cca.fit <- cca(d2r, dm, xlab=c("AGE", "TEMPORAL", "PARIETAL", "FRONTAL", "THALAMUS"), ylab=c("INFLEX", "RISK_SEEK", "INCORR_CHOICE", "PROB_ERR_ABS", "PROB_ERR"), standardize.scores=TRUE)

#View the results
cca.fit
summary(cca.fit)
#plot(cca.fit)

#Test for significance 
rho <- cca.fit[["corr"]]
N = dim(d2r)[1]
p <- length(d2r)
q <- length(dm)
res1 <- p.asym(rho, N, p, q, tstat = "Wilks")
plt.asym(res1,rhostart=1)

write.csv(res1, here('output', 'altcca2_wilks.csv'))

#important outputs
cc_coeffs <- cca.fit[["corr"]]
cc_coeffs_sq <- cca.fit[["corrsq"]]

d2r_canon_coeffs <- cca.fit[["xcoef"]][,1] #standardized canonical coefficients 
dm_canon_coeffs <-  cca.fit[["ycoef"]][,1]


d2r_structural <- cca.fit[["xstructcorr"]][,1] #structure coefficients (r)
dm_structural <- cca.fit[["ystructcorr"]][,1]


d2r_structural_sq <- cca.fit[["xstructcorrsq"]][,1] #structure coefficients (r^2)
dm_structural_sq <- cca.fit[["ystructcorrsq"]][,1]
