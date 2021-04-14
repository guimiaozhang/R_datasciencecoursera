# Getting and Cleaning Data Course Project

## 1. Original Dataset

  The original data [humman activity recognition using smartphones](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) were collected from the accelerometers from the Samsung Galaxy S smartphone. 

  A full description is available at the site where the data was obtained [full description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## 2. Project Goal

  Obtain a tidy dataset contain both training data and testing data from the raw data with the desirable features and easily understandable content.
  
  All file names mentioned below were obtained from the original dataset.
    
- Desirable features:
    
    Only measurements measurements on the mean and standard deviation for each measurement/feature. Details can be checked the files 'features.txt' and 'feature_info.txt' from the original data set.
    
- Understandable content:
    
    The observations ('X_train.txt', 'X_test.txt') are recorded without describtive feature names yielding difficult understood files. Also, no id information (observation subject, 'subject_train.txt', 'subject_test.txt') is contained in the observation files. In addtion, the classifications for each observations ('y_train.txt', 'y_test.txt') were documented in numbers whereas the activity names ('activity_labels.txt') are preferred to numbers.
    

## 3. Steps

  The attached R script (run_analysis.R) performs the following to clean up the data.

- Clean up classifications **ys**
  
    - Read 'activity_labels.txt' as **activities** data table.
    
    - Read 'y_train.txt' and 'y_test.txt' as a combined **ys** data table. Record the observation order as a new column **ys$ordernow**.
    
    - Merge **activities** and **ys** according to the same activity labels.
    
    - Rearrange the classifications by the original observation order. (10299 by 2)

- Clean up observations **Xs**

    - Read 'features.txt' and extract the feature names as **features**. (561 features total)
    
    - Extract the feature names as **selectfeature** only of the measurements on the mean and standard deviation for each measurement. (66 features total)
    
        Examples of desirable features: tbodyacc-mean()-x, tbodyacc-mean()-y, tbodyacc-mean()-z, tbodyacc-std()-x, tbodyacc-std()-y, tbodyacc-std()-z, tgravityacc-mean()-x, tgravityacc-mean()-y, and etc.
        
    - Read 'X_train.txt' and 'X_test.txt' as a combined **Xs** data table, and set the names for each features simutaneouly. (10299 by 561 dataset)
    
    - Subset **Xs** with only desirable features.(10299 by 66 dataset)

- Clean up ID information **subject**

  Identify the observation subject for each observations. Read 'subject_train.txt' and 'subject_test.txt' as a combined **subject** data table. (10299 records)
  
- Combine the dataset **cleandata**

  Column bind **subject**, **ys**, **Xs** without changing the recording order. Remove activity labels. (10299 by 68 dataset)
  
- Aggregate the dataset for each subject and each activity **tidydata**

  Use **subject** and **activityname** as **id.vars**. 30 subjects and 6 categories of activities yield 180 rows.
  
  Melt and cast **cleandata** by the mean for each measurements. (180 by 68 dataset)
  
  
    Note: R packages 'data.table' and 'dplyr' are required here. Final output file is 'tidydata.txt'