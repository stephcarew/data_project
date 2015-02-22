library(plyr)
#read in list of features
features <- read.table("features.txt")

#read in test and training data
train_data <- read.table("train/X_train.txt")
test_data <- read.table("test/X_test.txt")

#merge test and training data
all_data <- rbind(train_data,test_data)

#label the measurements using the names from features.txt
colnames(all_data) <- features$V2

#extract the std dev
std_data <- all_data[grep("std()", names(all_data))]

#extract the mean
mean_data <- all_data[grep("mean()", names(all_data))]

#remove meanFreq
mean_data <- mean_data[-(grep("meanFreq()", names(mean_data)))]

#merge the measurements of mean and std dev
limited_data <- cbind(mean_data,std_data)

#get the data on which subjects were being measured
subject_train <- read.table("train/subject_train.txt")
subject_test <- read.table("test/subject_test.txt")

#merge test and training subject data
subject_data <- rbind(subject_train,subject_test)
colnames(subject_data) <- "subject_number"

#get the data on which activity was being performed
y_train <- read.table("train/y_train.txt")
y_test <- read.table("test/y_test.txt")

#merge test and training activity data
activity_data <- rbind(y_train,y_test)
colnames(activity_data) <- "activity_number"

#get the activity names that correspond to each activity number
activity_labels <- read.table("activity_labels.txt")
colnames(activity_labels) <- c("activity_number","activity_label")

#add the corresponding activity label to each number
activity_data <- join(activity_data,activity_labels)

#merge the subject and activity data with the measurement data
limited_data <- cbind(subject_data,activity_data,limited_data)

tidy_data <- data.frame()
#start building the first two columns of the tidy data set (subject number and activity)
#counter
z <- 1
for (i in 1:30){
  for (j in 1:6){
    #subject number
    tidy_data[z,1] <- i
    #activity number 
    tidy_data[z,2] <- j
   z <- z+1   
  }
}
#compute the means by subject and activity number and input them into our tidy data set
for (k in 3:68){
  variable_summary <- tapply(limited_data[,k+1], list(limited_data$subject_number,limited_data$activity_number), FUN=mean)
  z <- 1
  for (i in 1:30){
    for (j in 1:6){
      #mean of variable k for subject i and activity j
      tidy_data[z,k] <- variable_summary[i,j]
      z <- z+1   
    }
  } 
}

#replace the activity numbers with the correct activity labels
td_activity_numbers <- as.data.frame(tidy_data$V2)
colnames(td_activity_numbers) <- "activity_number"
#add the corresponding activity label to each number
td_activity_labels <- join(td_activity_numbers,activity_labels)
tidy_data$V2 <- td_activity_labels$activity_label

#label the columns of our tidy data set
names(tidy_data)[1] <- "Subject Number"
names(tidy_data)[2] <- "Activity"
variable_names <- names(limited_data)[4:69]
variable_names <- paste("Average of ",variable_names,sep="")
names(tidy_data)[3:68] <- variable_names
write.table(tidy_data,"tidy_data.txt",row.names = FALSE)