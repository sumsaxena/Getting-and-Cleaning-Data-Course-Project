Readme.md
=========

This file explains the working of the run_analysis.R

Dependencies: dplyr and reshape2 packages

- The script adds the Activity and Subject variables to each dataset
- The two datasets are then merged together
- The variables which contains "mean" and "std" (standard deviation) are extracted out of the merged dataset
- Activity and Subject are variables added to the extracted dataset 
- The Activity codes in this dataset are replaced with following descriptive labels:
   1 = WALKING
   2 = WALKING_UPSTAIRS
   3 = WALKING_DOWNSTAIRS
   4 = SITTING
   5 = STANDING
   6 = LAYING
- Variable names are converted to more descriptive labels by changing
  (std= Standard Deviation, mean= Mean, Acc= Acceleration, fBody= FFT Body
    tBody = Time Domain Body, Gyro= Gyroscope, tGravity= Time Domain Gravity
    angle= angular)
- The data is then grouped together by Activity and Subject
- A new data set (Activity_Recognition.txt) is created with mean of each variables for each Activity and each Subject
- Activity_recgnition.txt can be viewed using:
   data<- read.table(file_path,header=T)
   view(data)

