
# read test data
X_test <- read.table(paste0(getwd(),"/UCI HAR Dataset/test/X_test.txt"))
y_test <- read.table(paste0(getwd(),"/UCI HAR Dataset/test/y_test.txt"))
subject_test <- read.table(paste0(getwd(),"/UCI HAR Dataset/test/subject_test.txt"))

# read train data
X_train <- read.table(paste0(getwd(),"/UCI HAR Dataset/train/X_train.txt"))
y_train <- read.table(paste0(getwd(),"/UCI HAR Dataset/train/y_train.txt"))
subject_train <- read.table(paste0(getwd(),"/UCI HAR Dataset/train/subject_train.txt"))

## Step 1: Merge the training and the test sets to create one data set.
X_all <- rbind(X_train,X_test)
Y_all <- rbind(y_train,y_test)
subject_all <- rbind(subject_train,subject_test)
data <- cbind(X_all,Y_all,subject_all)

## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
# read features 
features <- read.table(paste0(getwd(),"/UCI HAR Dataset/features.txt"))

# get feature indices indicating mean() and std() on measurements 
mean_idx <- grep("mean()",features[,2],fixed=TRUE) 
std_idx  <- grep("std()",features[,2],fixed=TRUE) 
mean_std_idx <- sort(c(mean_idx,std_idx))
mean_std_data <- data[,mean_std_idx]  #activity and subject labels (last 2 columns) omitted here for now

## Step 3: Uses descriptive activity names to name the activities in the data set
feature_names <- as.character(features[mean_std_idx,2])
names_desc <- gsub("Acc","Acceleration",feature_names,fixed=TRUE) 
names_desc <- gsub("Gyro","AngularVelocity",names_desc,fixed=TRUE) 
names_desc <- gsub("Gyro","AngularVelocity",names_desc,fixed=TRUE) 
names_desc <- gsub("Mag","Magnitude",names_desc,fixed=TRUE) 
names_desc <- gsub("mean()","Mean",names_desc,fixed=TRUE) 
names_desc <- gsub("std()","StandardDeviation",names_desc,fixed=TRUE)
names_desc <- gsub("-","",names_desc,fixed=TRUE) 
names_desc[1:40] <- sub("t","timeSeries",names_desc[1:40],fixed=TRUE) 
names_desc[41:66] <- sub("f","frequencyDomain",names_desc[41:66],fixed=TRUE) 

## Step 4: Appropriately labels the data set with descriptive activity names. 
colnames(mean_std_data) <- names_desc

## Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
colnames(subject_all) <- "subject"
colnames(Y_all) <- "activity"
mean_std_data <- cbind(mean_std_data,subject_all,Y_all)

library(reshape2)
mean_std_tall <- melt(mean_std_data,id.vars=c("subject","activity"))
ave_mean_std <- dcast(mean_std_tall,subject + activity ~variable,mean)

## Finally, write the tidy data into a text file
write.table(ave_mean_std,file="average_mean_std_data.txt",sep="\t")
