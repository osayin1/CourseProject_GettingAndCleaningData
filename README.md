CourseProject_GettingAndCleaningData
====================================

Author: Ozan Sayin
Date  : 05/25/2014

This repo contains a script run_analysis.R that performs a specific analysis on the Samsung Wearable Computing Data, which can be accessed here http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

In the data folder "UCI HAR Dataset", there are two data folders "test" and "train", which include a variety of measurements (i.e. 561 distinct observations defined in features.txt and features_info.txt). 

## Analyses performed by run_analysis.R
* Merge the data from the "test" and "train" folders into one single data
* Finds the measurements that were acquired after applying mean() and std() on original recordings. These correspond to feature names listed in features.txt containing "mean()" and "std()" as explained in features_info.txt.
* Extracts only the measurements found in the previous step from the merged data. 
* Renames the measurement names with more descriptive English-like names. To this end, a lower CamelCase convention was adopted (http://journal.r-project.org/archive/2012-2/RJournal_2012-2_Baaaath.pdf)
* Assings these descriptive names as column names to the data. 
* For each subject and activity(e.g. Walking, Standing etc.) combination calculates the average for each measurement. 
* Saves the data to a text file called "average_mean_std_data.txt"
