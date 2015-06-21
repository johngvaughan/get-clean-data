==================================================================
Modifications to Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Original authors
================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

This codebook describes modifications to the original dataset downloaded from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Date of modification: 21 June 2015


The modified dataset includes the following files:
=========================================

1. 'CodeBook.md' (this file)

2. README.md
   Gives a detailed description of the way in which the input dataset has been modified

3. 'tidyData.txt'
   Combines and summarizes the contents of the original input files.

The input files have been modified by the R script "run_analysis.R"

Inertial signals in the input dataset have been omitted


=================================================================================

Variables in the output file, "tidyData.txt"
--------------------------------------------
There are 66 summary variables in the output file.

They represent summaries of corresponding mean and standard deviation calculations in the input dataset. 

The figures corresponding to mean() and std() values in X_train.txt and X_test.txt have been summarized as follows:

The means are calculated for each subject, and for each activity performed by that subject.

The 66 resulting variables are presented as 180 summary observations in the file "tidyData.txt".

The variable names have been modified to indicate that they have been summarized in this way.

Two columns have been added to the output data to identify the subject and the corresponding activities carried out.

The names of the summary variables are:

 [1] "meantbodyaccmeanx"            "meantbodyaccmeany"            "meantbodyaccmeanz"           
 [4] "meantbodyaccstdx"             "meantbodyaccstdy"             "meantbodyaccstdz"            
 [7] "meantgravityaccmeanx"         "meantgravityaccmeany"         "meantgravityaccmeanz"        
[10] "meantgravityaccstdx"          "meantgravityaccstdy"          "meantgravityaccstdz"         
[13] "meantbodyaccjerkmeanx"        "meantbodyaccjerkmeany"        "meantbodyaccjerkmeanz"       
[16] "meantbodyaccjerkstdx"         "meantbodyaccjerkstdy"         "meantbodyaccjerkstdz"        
[19] "meantbodygyromeanx"           "meantbodygyromeany"           "meantbodygyromeanz"          
[22] "meantbodygyrostdx"            "meantbodygyrostdy"            "meantbodygyrostdz"           
[25] "meantbodygyrojerkmeanx"       "meantbodygyrojerkmeany"       "meantbodygyrojerkmeanz"      
[28] "meantbodygyrojerkstdx"        "meantbodygyrojerkstdy"        "meantbodygyrojerkstdz"       
[31] "meantbodyaccmagmean"          "meantbodyaccmagstd"           "meantgravityaccmagmean"      
[34] "meantgravityaccmagstd"        "meantbodyaccjerkmagmean"      "meantbodyaccjerkmagstd"      
[37] "meantbodygyromagmean"         "meantbodygyromagstd"          "meantbodygyrojerkmagmean"    
[40] "meantbodygyrojerkmagstd"      "meanfbodyaccmeanx"            "meanfbodyaccmeany"           
[43] "meanfbodyaccmeanz"            "meanfbodyaccstdx"             "meanfbodyaccstdy"            
[46] "meanfbodyaccstdz"             "meanfbodyaccjerkmeanx"        "meanfbodyaccjerkmeany"       
[49] "meanfbodyaccjerkmeanz"        "meanfbodyaccjerkstdx"         "meanfbodyaccjerkstdy"        
[52] "meanfbodyaccjerkstdz"         "meanfbodygyromeanx"           "meanfbodygyromeany"          
[55] "meanfbodygyromeanz"           "meanfbodygyrostdx"            "meanfbodygyrostdy"           
[58] "meanfbodygyrostdz"            "meanfbodyaccmagmean"          "meanfbodyaccmagstd"          
[61] "meanfbodybodyaccjerkmagmean"  "meanfbodybodyaccjerkmagstd"   "meanfbodybodygyromagmean"    
[64] "meanfbodybodygyromagstd"      "meanfbodybodygyrojerkmagmean" "meanfbodybodygyrojerkmagstd"

_________________________________________________________________________________________________

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Files in the input dataset
--------------------------
1 'features_info.txt': Shows information about the variables used on the feature vector.

2 'features.txt': List of all features.

3 'activity_labels.txt': Links the class labels with their activity name.

4 'train/X_train.txt': Training set.

5 'train/y_train.txt': Training labels.

6 'test/X_test.txt': Test set.

7 'test/y_test.txt': Test labels.

8 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 


Note from input dataset 
=======================
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.


For more information about the original dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
