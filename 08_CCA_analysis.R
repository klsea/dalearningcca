# dalearningCCA
# CCA from Mikella
# 

# load required packages
library(here)
library(tidyverse)
library(yacca)
library(CCP)

# load source functions

# set hard-coded variables

# read data in
data <- read.csv(here('data', 'stock-bond_subject-level_data.csv'))
data <- na.omit(data)

#age, midbrain, amygdala, insula, acc
d2r <- data[c(2,8,14,16,18)]

#decision making
dm <- data[3:7]

cca.fit <- cca(d2r, dm, xlab=c("AGE", "MIDBRAIN", "AMYGDALA", "INSULA", "ACC"), ylab=c("INFLEX", "RISK_SEEK", "INCORR_CHOICE", "PROB_ERR_ABS", "PROB_ERR"), standardize.scores=TRUE)

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

#important outputs
cc_coeffs <- cca.fit[["corr"]]
cc_coeffs_sq <- cca.fit[["corrsq"]]

d2r_canon_coeffs <- cca.fit[["xcoef"]][,1] #standardized canonical coefficients 
dm_canon_coeffs <-  cca.fit[["ycoef"]][,1]


d2r_structural <- cca.fit[["xstructcorr"]][,1] #structure coefficients (r)
dm_structural <- cca.fit[["ystructcorr"]][,1]


d2r_structural_sq <- cca.fit[["xstructcorrsq"]][,1] #structure coefficients (r^2)
dm_structural_sq <- cca.fit[["ystructcorrsq"]][,1]

#simple regressions from poster 
ageInflex <- lm(inflexibility ~ age, data=data)
midbrainInflex <- lm(inflexibility ~ midbrain, data=data)
amygdalaInflex <- lm(inflexibility ~ amygdala, data=data)

summary(ageInflex)
summary(midbrainInflex)
summary(amygdalaInflex)

(ageInflex <- cor.test(formula = ~ inflexibility +age, data=data))
(midbrainInflex <- cor.test(formula = ~ inflexibility + midbrain, data=data))
(amygdalaInflex <- cor.test(formula = ~ inflexibility + amygdala, data=data))

