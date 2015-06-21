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
## 
## Step 1.1
## Read in the training data as a data frame from X_train.txt using read.table()
## and convert it to a data table called X_trainDT
## Note that fread() does not read X_train.txt correctly
## 
library(data.table)
X_trainDF <- read.table("./UCI HAR Dataset/train/X_train.txt", nrows=-1, stringsAsFactors=FALSE)
X_trainDT <- as.data.table(X_trainDF)
## > dim(X_trainDT)
## [1] 7352  561
## 
## Step 1.2
## Read in the subject labels as a data table from subject_train.txt
## using fread()
## 
X_train_subjectDT <- fread("./UCI HAR Dataset/train/subject_train.txt")
## > dim(X_train_subjectDT)
## [1] 7352    1
## 
## Step 1.3
## Apply the subject labels to the training data by adding them
## as a column to the right of the existing X_trainDT table
## 
X_trainDT[,Subject:=X_train_subjectDT$V1]
## > dim(X_trainDT)
## [1] 7352  562
##
## Step 1.4
## Read in the test data as a data frame from X_test.txt using read.table()
## and convert it to a data table called X_testDT
## Note that fread() does not read X_test.txt correctly
## 
X_testDF <- read.table("./UCI HAR Dataset/test/X_test.txt", nrows=-1, stringsAsFactors=FALSE)
X_testDT <- as.data.table(X_testDF)
## > dim(X_testDT)
## [1] 2947  561
## 
## Step 1.5
## Read in the subject labels as a data table from subject_test.txt
## using fread()
## 
X_test_subjectDT <- fread("./UCI HAR Dataset/test/subject_test.txt")
## > dim(X_test_subjectDT)
## [1] 2947    1
## 
## Step 1.6
## Apply the subject labels to the test data by adding them
## as a column to the right of the existing X_testDT table
## 
X_testDT[,Subject:=X_test_subjectDT$V1]
## > dim(X_testDT)
## [1] 2947  562
## 
## Step 1.7
## Join the test data in X_testDT to the training data in X_trainDT
## by adding the rows of X_testDT after the rows of X_trainDT
## 
X_combinedDT <- rbindlist(list(X_trainDT, X_testDT))
##
## Step 2
## Extract only the measurements on the mean and standard deviation for each 
## measurement.
## 
## Step 2.1
## Read in the measured feature labels
## ("tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z" ...) 
## as a data table from features.txt using fread()
## 
featuresDT <- fread("./UCI HAR Dataset/features.txt")
## dim(featuresDT)
## [1] 561   2
##
## Step 2.2
## Extract the rows of the featuresDT table that contain mean() or std() 
## 
mean_std_featuresDT <- featuresDT[grep("mean\\(|std\\(",V2,perl=TRUE),]
## mean_std_featuresDT$V1 contains the column numbers of the variables to be
## retained in X_combinedDT:
## > mean_std_featuresDT$V1
## [1]   1   2   3   4   5   6  41  42  43  44  45  46  81  82  83  84  85  86
## 121 122 123 124 125 126 161 162 163 164 165
## [30] 166 201 202 214 215 227 228
## 240 241 253 254 266 267 268 269 270 271 345 346 347 348 349 350 424 425 426
## 427 428 429
## [59] 503 504 516 517 529 530 542 543
## 
## Step 2.3
## Construct a vector to select columns in X_combinedDT.
## Include the mean() and std() variables  in X_combinedDT
## PLUS the column at the right-hand side containing the subject identifiers.
## 
column_select <- mean_std_featuresDT$V1
## Checked that the Subject variable occupies column 562 in X_combinedDT
## > head(X_combinedDT[,562,with=FALSE])
## Subject
## 1:       1
## 2:       1
## 3:       1
## 4:       1
## 5:       1
## 6:       1
##
## Add a selector for column 562 to column_select
column_select <- c(column_select, 562)
## > length(column_select)
## [1] 67
## 
## Step 2.4
## Extract the required variables and put them in table X_extractedDT
## 
X_extractedDT <- X_combinedDT[,column_select,with=FALSE]
##
## Step 3
## Use descriptive activity names to name the activities in the data set
## 
## Step 3.1
## Get the numeric activity labels from files y-train.txt and y-test.txt
## 
trainLabelDT <- fread("./UCI HAR Dataset/train/y_train.txt")
testLabelDT <- fread("./UCI HAR Dataset/test/y_test.txt")
## > dim(trainLabelDT)
## [1] 7352    1
## 
## Step 3.2
## Get the table giving the correspondence between numeric and text activity
## labels from file activity_labels .txt
## 
activityLabelsDT <- fread("./UCI HAR Dataset/activity_labels.txt")
## > dim(activityLabelsDT)
## [1] 6 2
## 
## Step 3.3
## Concatenate the training and test label tables to form the activies table
## 
activitiesCombinedDT <- rbindlist(list(trainLabelDT, testLabelDT))
## 
## Step 3.4
## Substitute the text labels for the numeric labels in activitiesCombinedDT
## 
## > names(activitiesCombinedDT)
## [1] "V1"
activitiesCombinedDT$V1<-activityLabelsDT$V2[match(activitiesCombinedDT$V1,activityLabelsDT$V1)]
## > dim(activitiesCombinedDT)
## [1] 10299     1
## 
## Step 3.5
## Add the activity label vector to the right 
## of the extracted data table X_extractedDT
##
## > dim(X_extractedDT)
## [1] 10299    67
##
X_extractedDT[,Activity := activitiesCombinedDT$V1]
## > dim(X_extractedDT)
## [1] 10299    68
##
## Step 4
## Appropriately label the data set with descriptive variable names
## 
## Don't forget "Subject" and "Activities"!!!
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
## Put the result in featureLabels.
##
featureLabels <- tolower(gsub("\\.+","",make.names(mean_std_featuresDT$V2),perl=TRUE))
##
## Step 4.2
## Add labels for the Subjects and Activities to the featureLabels vector
## > str(featureLabels)
## chr [1:66] "tbodyaccmeanx" "tbodyaccmeany" "tbodyaccmeanz" "tbodyaccstdx" ...
##
featureLabels <- c(featureLabels,"subject","activity")
##
## > str(featureLabels)
## chr [1:68] "tbodyaccmeanx" "tbodyaccmeany" "tbodyaccmeanz" "tbodyaccstdx" ...
##
## Step 4.3
## Apply the feature labels to X_extractedDT by substituting them for the 
## existing generic column labels ("V1", "V2", "V3", ...)
## 
setnames(X_extractedDT,names(X_extractedDT),featureLabels)
## 
## 
## Step 5
## From the data set in step 4, create a second, independent tidy data set
## with the average of each variable for each activity and each subject.
##
## I am using data.table 1.9.2, so a range of column names cannot be specified
## The variables to be summarised are in columns 1 to 66
##
reducedDT <- X_extractedDT[,lapply(.SD,mean,na.rm=TRUE),by=c("subject","activity"),.SDcols=1:66]
## > dim(reducedDT)
## [1] 180  68
##
## The "subject" ids are not in order, so tidy this up
##
reducedDT <- reducedDT[order(rank(subject))]
##
## Modify the labels to show that they now refer to averages
##
newlabels <- names(reducedDT)[3:68]
newlabels <- gsub("^(.*)$","mean\\1",newlabels,perl=TRUE)
newlabels <-c("subject","activity",newlabels)
setnames(reducedDT,names(reducedDT),newlabels)
##
## The reducedDT table now contains the tidy data set
##
## Write the data set to a text file
## As required, use write.table() with row.name=FALSE
##
write.table(reducedDT, "tidyData.txt", row.names=FALSE)
##
## END SCRIPT