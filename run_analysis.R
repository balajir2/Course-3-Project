setwd("D:/2020/Education/Data Science/Course 3/Week 4/Project")
filename <- "Coursera_DS3_Final.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}
# Load the files
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code","activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt",col.names=features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# Merge the files
xcomb<-rbind(x_test,x_train)
ycomb<-rbind(y_test,y_train)
sub_comb<-rbind(subject_test,subject_train)
unified_table<-cbind(xcomb,ycomb,sub_comb)

# Select columns which have mean or std
unified_table1<-unified_table[,grep("mean|std",colnames(unified_table),value = TRUE)]
unified_table1<-cbind(unified_table$code,unified_table$subject,unified_table1)
colnames(unified_table1)[colnames(unified_table1)=="unified_table$code"]<-"code"
colnames(unified_table1)[colnames(unified_table1)=="unified_table$subject"]<-"subject"

# change the code in unifiedtable1 to activity
unified_table1$code<-activitylabels[unified_table1$code,2]
names(unified_table1)[1]<-"activity"

# rename subject column to participant
#names(unified_table1)[2]<-"subject"

# Clean up the column titles and bring back abbreviations in full form
names(unified_table1)<-gsub("Acc","Acceleration",names(unified_table1))
names(unified_table1)<-gsub("Gyro", "Gyroscope", names(unified_table1))
names(unified_table1)<-gsub("BodyBody", "Body", names(unified_table1))
names(unified_table1)<-gsub("Mag", "Magnitude", names(unified_table1))
names(unified_table1)<-gsub("^t", "Time", names(unified_table1))
names(unified_table1)<-gsub("^f", "Frequency", names(unified_table1))
names(unified_table1)<-gsub("tBody", "TimeBody", names(unified_table1))
names(unified_table1)<-gsub("-mean()", "Mean", names(unified_table1), ignore.case = TRUE)
names(unified_table1)<-gsub("-std()", "STD", names(unified_table1), ignore.case = TRUE)
names(unified_table1)<-gsub("-freq()", "Frequency", names(unified_table1), ignore.case = TRUE)
names(unified_table1)<-gsub("angle", "Angle", names(unified_table1))
names(unified_table1)<-gsub("gravity", "Gravity", names(unified_table1))

Answer<-unified_table1 %>% group_by(subject,activity)%>% summarize_all(funs(mean))
write.table(Answer, "FinalData.txt", row.name=FALSE)
