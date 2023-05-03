pcorTableCI <- function(data, covariate) {
        ## Input columns of data you would like to correlate and identify the covariate
        ## Creates a table with 95% confidence intervals
        #source(here('scr', 'pcorr.R'))
        #source(here('scr', 'CIcorr.R'))
        pcorEstimates <- round(pcorr(data,covariate),3)

        table <- matrix(0, nrow=length(data),ncol=length(data))
        for (x in 1:length(data)) {
                for (y in 1:length(data)) {
                        ci <- CIcorr(.05,pcorEstimates[x,y],1,nrow(data))
                        table[x,y] <- paste0(as.character(pcorEstimates[x,y]), ' [', as.character(round(ci[1],3)), ', ', as.character(round(ci[2],3)), ']')
                }
        }
        pcorTable <- as.data.frame(table); colnames(pcorTable) <- colnames(data); pcorTable <- cbind(colnames(data), pcorTable)
        return(pcorTable)
}        