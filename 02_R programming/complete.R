# Programming Assignment 1
# R version 4.0.5
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows 10 x64 (build 19041)

library(data.table)
complete <- function(directory, id = 1:332){
    files <- paste0(directory, "/", formatC(id, width = 3, flag = "0"), ".csv")
    datalist <- lapply(files, fread)
    datas <- rbindlist(datalist)
    completes <- complete.cases(datas)
    tmp <- datas[completes, .N, by = ID] # .N return nrow group by ID, . abbrev for list
    # return a data.frame id & nobs
    # here, cannot return tmp b/c some id may have no complete cases, tmp ignore those
    nobs <- rep(0, length(id))
    ans <- cbind(id, nobs)
    for(i in 1:nrow(tmp)){
        ans[id == tmp$ID[i], 2] = tmp$N[i]
    }
    return(as.data.frame(ans))
}
