# dalearningCCA
# 
# 4.19.23 KLS

# load required packages
library(here)
library(tidyverse)
library(stats)
library(yacca)
library(CCP)

# load source functions

# set hard-coded variables

# read in data
sub_data <- read.csv(here('data', 'stock-bond_subject-level_data.csv'))
sub_data<- sub_data[complete.cases(sub_data),]

# get residuals
inflexibility_age <- resid(lm(inflexibility ~ age, sub_data))
stock_first_age <- resid(lm(stock_first ~ age, sub_data))
incorrect_choice_age <- resid(lm(incorrect_choice ~ age, sub_data))
prob_error_abs_age <- resid(lm(prob_error_abs ~ age, sub_data))
prob_error_age <- resid(lm(prob_error ~ age, sub_data))

midbrain_age <- resid(lm(midbrain ~ age, sub_data))
amygdala_age <- resid(lm(amygdala ~ age, sub_data))
insula_age <- resid(lm(insula ~ age, sub_data))
acc_age <- resid(lm(acc ~ age, sub_data))

data <- cbind(sub_data[1:2], 
            data.frame(cbind(inflexibility_age, stock_first_age, 
                             incorrect_choice_age, prob_error_abs_age, 
                             prob_error_age, midbrain_age, amygdala_age, 
                             insula_age, acc_age)))

# run cca
#midbrain, amygdala, insula, acc
d2r <- data[c(8:11)]

#decision making
dm <- data[3:7]

cca.fit <- cca(d2r, dm, xlab=c("MIDBRAIN", "AMYGDALA", "INSULA", "ACC"), ylab=c("INFLEX", "RISK_SEEK", "INCORR_CHOICE", "PROB_ERR_ABS", "PROB_ERR"), standardize.scores=TRUE)

#View the results
cca.fit
summary(cca.fit)
plot(cca.fit)

#Test for significance 
rho <- cca.fit[["corr"]]
N = dim(d2r)[1]
p <- length(d2r)
q <- length(dm)
res1 <- p.asym(rho, N, p, q, tstat = "Wilks")
plt.asym(res1,rhostart=1)

write.csv(res1, here('output', 'altcca1_wilks.csv'))

#important outputs
cc_coeffs <- cca.fit[["corr"]]
cc_coeffs_sq <- cca.fit[["corrsq"]]

d2r_canon_coeffs <- cca.fit[["xcoef"]][,1] #standardized canonical coefficients 
dm_canon_coeffs <-  cca.fit[["ycoef"]][,1]


d2r_structural <- cca.fit[["xstructcorr"]][,1] #structure coefficients (r)
dm_structural <- cca.fit[["ystructcorr"]][,1]


d2r_structural_sq <- cca.fit[["xstructcorrsq"]][,1] #structure coefficients (r^2)
dm_structural_sq <- cca.fit[["ystructcorrsq"]][,1]

