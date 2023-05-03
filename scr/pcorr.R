pcorr <- function(data, covariate) {
        ## Input columns of data you would like to correlate and identify the covariate
        ## Creates a table with p-values denoted by ***
        # source('~/Dropbox (Personal)/Functions/pcor.test.R')
        partialCor <- function(data,a,b,c) pcor.test(data[a],data[b], c, na.rm=TRUE) # Partial correlation between a and b controlling for c in data
        names <- colnames(data)
        partialCors <- array(0, dim=c(ncol(data),ncol(data),6))
        for (x in 1:ncol(data)) {
                for (y in 1:ncol(data)) {
                        if (x==y) {
                                t <- vector() #c(1,0,0,0,0,0)
                        } else {
                                t <- data.matrix(partialCor(data,x,y,covariate))
                        }
                        for (z in 1:6) {
                                partialCors[x,y,z] <- t[z]
                        }       
                }
        }
        pcorEstimates <- round(partialCors[,,1],3); 
}