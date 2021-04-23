# Programming Assignment 1
# R version 4.0.5
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows 10 x64 (build 19041)
library(data.table)
corr <- function(directory, threshold = 0){
    # Reading in all files & making a large data.table
    datalist <- lapply(file.path(directory, list.files(path = directory, pattern="*.csv")), fread)
    datas <- rbindlist(datalist)
    # Only keep ID of completely observed cases w/ more than threshold
    completes <- datas[complete.cases(datas)]
    # .(N, corr), cal 1st nrows, 2nd, cor, group by ID
    ans <- completes[, .(.N, corr = cor(sulfate, nitrate)), by = ID][N > threshold]
    # return a numeric vector of cor
    return(ans$corr)
}
