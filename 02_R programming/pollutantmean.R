# Programming Assignment 1
# R version 4.0.5
# Platform: x86_64-w64-mingw32/x64 (64-bit)
#Running under: Windows 10 x64 (build 19041)
library(data.table)
pollutantmean <- function(directory, pollutant, id = 1:332){
    # Format the # as 001 etc & append .csv to the #
    files <- paste0(directory, "/", formatC(id, width = 3, flag = "0"), ".csv")
    # banch read into a data tab.
    datalist <- lapply(files, fread)
    datas <- rbindlist(datalist)
    # extract & cal.
    ans <- mean(datas[[pollutant]], na.rm = T)
    return(ans)
}
