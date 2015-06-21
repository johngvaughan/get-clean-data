# get-clean-data
## Contains R script for submitted for the Getting and Cleaning Data Coursera project
##
## Coursera Data Science Specialization
##
## Getting and Cleaning Data
##
## Course Project
##
## File: run_analysis.R
## Requires: Folder "UCI HAR Dataset" in the same directory as this script.
## This folder contains the raw data for this script.
## It must be downloaded and then unzipped from
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##
## Last update: Sunday 21 June 2015
##
## Version Information
## iMac, 2GHz Intel Core 2 Duo
## Mac OS X Version 10.6.8
## RStudio Version 0.98.1091
## R version 3.1.0 (2014-04-10) -- "Spring Dance"
## data.table version 1.9.2
##
## Project requirements
## You should create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each 
##    measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set
##    with the average of each variable for each activity and each subject.
## 
## References
## 1. David Hood's personal course project FAQ
##    https://class.coursera.org/getdata-015/forum/thread?thread_id=26
## 2. Problem using fread() with some data files
##    https://class.coursera.org/getdata-015/forum/thread?thread_id=120
## 3. Why is rbindlist “better” than rbind?
##    http://stackoverflow.com/questions/15673550/why-is-rbindlist-better-than-rbind
## 4. How to apply activity labels?
##    https://class.coursera.org/getdata-015/forum/thread?thread_id=112#comment-276
## 5. R help -- Bulk Match/Replace
##    http://r.789695.n4.nabble.com/Bulk-Match-Replace-td1311133.html
## 
## General note
## The combined data set is  assembled according to the diagram provided 
## by David Hood in the thread at Reference[4] above.
##
## Step 1
## Merge the training and the test sets to create one data set
## This is divided into seven substeps as follows:
## 
## Step 1.1
## Read in the training data as a data frame from X_train.txt using read.table()
## and convert it to a data table called X_trainDT
## Note that fread() does not read X_train.txt correctly
## 
## Step 1.2
## Read in the subject labels as a data table from subject_train.txt
## using fread()
## 
## Step 1.3
## Apply the subject labels to the training data by adding them
## as a column to the right of the existing X_trainDT table
##
## Step 1.4
## Read in the test data as a data frame from X_test.txt using read.table()
## and convert it to a data table called X_testDT
## Note that fread() does not read X_test.txt correctly
## 
## Step 1.5
## Read in the subject labels as a data table from subject_test.txt
## using fread()
## 
## Step 1.6
## Apply the subject labels to the test data by adding them
## as a column to the right of the existing X_testDT table
## 
## Step 1.7
## Join the test data in X_testDT to the training data in X_trainDT
## by adding the rows of X_testDT after the rows of X_trainDT
## 
##
## Step 2
## Extract only the measurements on the mean and standard deviation for each 
## measurement.
## Step 2 is divided into four substeps as follows:
## 
## Step 2.1
## Read in the measured feature labels
## ("tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z" ...) 
## as a data table from features.txt using fread()
## 
## Step 2.2
## Extract the rows of the featuresDT table that contain mean() or std() 
## These are put in a data table "mean_std_featuresDT"
## mean_std_featuresDT$V1 contains the column numbers of the variables to be
## retained in X_combinedDT
## mean_std_featuresDT$V2 contains the corresponding feature labels
## 
## Step 2.3
## Construct a vector to select columns in X_combinedDT.
## Include the mean() and std() variables  in X_combinedDT
## PLUS the column at the right-hand side containing the subject identifiers.
## This vector is named "column_select".
##
## Add a selector for column 562 to column_select. Column 562 is the rightmost column 
## and contains the "Subject" identifiers.
## 
## Step 2.4
## Extract the required variables and put them in table X_extractedDT
## 
##
## Step 3
## Use descriptive activity names to name the activities in the data set
## Step 3 comprises five substeps:
##
## Step 3.1
## Get the numeric activity labels from files "y-train.txt" and "y-test.txt"
## Put them in data tables "trainLabelDT" and "testLabelDT" respectively
## 
## Step 3.2
## Get the table giving the correspondence between numeric and text activity
## labels from file "activity_labels.txt"
## 
## Step 3.3
## Concatenate the training and test label tables to form the activities table.
## Name this "activitiesCombinedDT"
## 
## Step 3.4
## Substitute the text labels for the numeric labels in activitiesCombinedDT
## 
## Step 3.5
## Add the activity label vector to the right 
## of the extracted data table X_extractedDT
##
##
## Step 4
## Appropriately label the data set with descriptive variable names.
## It is important to include labels for the "Subject" and "Activities" columns.
## This is arranged in three substeps:
##
## Step 4.1
## Modify the measured feature labels in mean_std_featuresDT$V2
## ("tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z" ...) 
## according to guidance provided in lectures
## 
## featuresDT has already been read from "./UCI HAR Dataset/features.txt"
## 
## mean_std_featuresDT$V1 contains the column numbers of the variables that 
## have been retained in X_combinedDT.
## mean_std_featuresDT$V2 contains the feature labels of the variables that 
## have been retained in X_combinedDT.
## 
## Syntactically valid names are described in the make.names {base} descriptor
## at https://stat.ethz.ch/R-manual/R-devel/library/base/html/make.names.html
##
## However, in Lecture 4-1 of this module, "Editing Text Variables", Jeff Leek
## goes beyond this, stating the desirable characteristics of variable names as:
## - All lower case when possible
## - Descriptive
## - Not duplicated
## - No underscores or dots or white spaces
##
## So I have decided to modify the variable names to make them syntactically 
## correct and also comply with Jeff Leek's requirements
##
## Make syntactically valid names with make.names(),
## remove the dots with gsub() and 
## convert all characters to lowercase with tolower().
## Put the result in a vector named "featureLabels".
##
## Step 4.2
## Add labels for the Subjects and Activities to the "featureLabels" vector
##
## Step 4.3
## Apply the feature labels to data table "X_extractedDT" by substituting them for the 
## existing column labels.
## 
## 
## Step 5
## From the data set in step 4, create a second, independent tidy data set
## with the average of each variable for each activity and each subject.
##
## I am using data.table 1.9.2, so a range of column names cannot be specified
## The variables to be summarized are in columns 1 to 66
##
## Put the tidy set in a data table named "reducedDT" 
##
## Tidy the order of the "subject" ids and
## modify the labels to show that they now refer to averages.
## I decided to prefix every variable label with the string "mean" to distinguish 
## between them and the previous unsummarized variables.
##
## The reducedDT table now contains the tidy data set
##
## Write the data set to a text file
## As required, use write.table() with row.name=FALSE
