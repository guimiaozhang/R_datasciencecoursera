## R version 4.0.5 (2021-03-31)
## Platform: x86_64-w64-mingw32/x64 (64-bit)

## download, save, unzip files
fileurl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if(!file.exists('data/project')) {dir.create('data/project')}
download.file(fileurl, destfile = 'data/project/program.zip')
unzip('data/project/program.zip', exdir = 'data/project')


library(data.table)
library(dplyr)


Xdir <- paste0('data/project/UCI HAR Dataset/', c('train/X_train', 'test/X_test'), '.txt')
ydir <- paste0('data/project/UCI HAR Dataset/', c('train/y_train', 'test/y_test'), '.txt')
subjectdir <- paste0('data/project/UCI HAR Dataset/', 
                     c('train/subject_train', 'test/subject_test'), '.txt')

## load activities
activities <- fread('data/project/UCI HAR Dataset/activity_labels.txt', 
                    col.names = c('activitylabel', 'activityname'))

## load ys train & test label -> combine -> record recent order -> merge w/ activity name
## -> put back original order of ys
ys <- lapply(ydir, fread, col.names = 'activitylabel') %>% rbindlist
ys$ordernow <- 1:nrow(ys)
ys <- merge(activities, ys, by = 'activitylabel') %>% arrange(ordernow)
ys <- ys[, 1:2]



## load features
features <- fread('data/project/UCI HAR Dataset/features.txt', 
                  col.names = c('colidx', 'name'))$name

## choose feature names w/ either mean or std measurements 
selectfeature <- grep('(mean|std)\\(', features, value = T)


## load Xs train & test -> combine -> select only wanted features -> del. '()' in col names
Xs <- lapply(Xdir, fread, col.names = features) %>% rbindlist
Xs <- Xs[, selectfeature, with = F]
names(Xs) <- gsub('\\(\\)', '', selectfeature) %>% tolower


## load subjects train & test label -> combine
subject <- lapply(subjectdir, fread, col.names = 'subject') %>% rbindlist


## combine a big datasets w/ each observation
cleandata <- bind_cols(subject, ys, Xs)
cleandata[, 2] <- NULL


## aggregates & write
tidydata <- melt(cleandata, id.vars = 1:2) %>% 
    dcast(subject + activityname ~ variable, fun.aggregate = mean)

write.table(tidydata, file = 'tidydata.txt', row.names = F)
