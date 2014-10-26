## Merge the training and the test sets to create one data set.

# reading column names from features.txt
file_head = read.table("./UCI HAR Dataset/features.txt")

# Training Dataset

# reading training files (training data, activity data and subject data)
data_train<- read.table("./UCI HAR Dataset/train/X_train.txt", 
                        col.names=file_head$V2)
act_train<- read.table("./UCI HAR Dataset/train/Y_train.txt", 
                       col.names="Activity")
sub_train<- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                       col.names="Subject")

# merging traning, activity and subject data 
data_train<- cbind(data_train, act_train,sub_train)

# Test Dataset 

# reading test files (test data, activity data and subject data)
data_test<- read.table("./UCI HAR Dataset/test/X_test.txt",
                       col.names=file_head$V2)
act_test<- read.table("./UCI HAR Dataset/test/Y_test.txt", 
                      col.names="Activity")
sub_test<- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                      col.names="Subject")

# merging training, activity and subject data 
data_test<- cbind(data_test, act_test,sub_test)


# merge test and training datasets
datalist<- rbind(data_train, data_test)



##Extracts only the measurements on the mean and standard deviation 
##for each measurement. 

# Extracting all variables that contain the word "mean"
data_mean <- select(datalist, contains("mean"))
# Extracting all variables that contain the word "mean"
data_std <- select(datalist, contains("std"))

# Adding Activity and Subject data to the extracted variables
data_act<- select(datalist,matches("Activity"))
data_sub<- select(datalist,matches("Subject"))

# binding the extracted variables
data_ext<- cbind(data_mean, data_std, data_act, data_sub)

##Use descriptive activity names to name the activities in the data set

# replacing codes in Activity data with name of the activities
# 1 WALKING
# 2 WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4 SITTING
# 5 STANDING
# 6 LAYING

gsub(1,"WALKING",data_ext$Activity)
gsub(2,"WALKING UPSTAIRS",data_ext$Activity)
gsub(3,"WALKING DOWNSTAIRS",data_ext$Activity)
gsub(4,"SITTING",data_ext$Activity)
gsub(5,"STANDING",data_ext$Activity)
gsub(5,"LAYING",data_ext$Activity)

##Appropriately labels the data set with descriptive variable names. 
# replacing column labels with descriptive ones
# (std= Standard Deviation, mean= Mean, Acc= Acceleration, fBody= FFT Body
#  t Body = Time Domain Body, Gyro= Gyroscope, tGravity= Time Domain Gravity
#  angle= angular)
col_names<- colnames(data_ext)
col_names2<- gsub(".std"," Standard Deviation", col_names)
col_names2<- gsub(".mean"," Mean", col_names2)
col_names2<- gsub("Acc"," Acceleration ", col_names2)
col_names2<- gsub("mean"," Mean", col_names2)
col_names2<- gsub("fBody","FFT Body", col_names2)
col_names2<- gsub("tBody","Time Domain Body", col_names2)
col_names2<- gsub("Body","Body ", col_names2)
col_names2<- gsub("Gyro","Gyroscope ", col_names2)
col_names2<- gsub("tGravity","Time Domain Gravity ", col_names2)
col_names2<- gsub("angle.","Angular ", col_names2)
colnames(data_ext)<- col_names2

##Appropriately labels the data set with descriptive variable names. 
##From the data set in step 4, creates a second, 
##independent tidy data set with the average of 
##each variable for each activity and each subject.

# grouping data by Activity and Subject
by_cuts<- group_by(data_ext, Activity,Subject)

# calculating means for each variable cut by Activity and Subject
new_data<- summarise_each(by_cuts,funs(mean))

# writing to Activity_Recognition.txt
write.table(new_data, file="./Activity_Recognition.txt", row.names=FALSE)
