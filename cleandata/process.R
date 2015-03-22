library(dplyr)
library(data.table)

process <- function() {
    featurefilename <- "features.txt"
    
    if (!file.exists(featurefilename)) {
        print(paste("Error: can't open", featurefilename,  "Current working directory is",  getwd()))
        return(-1)
    }
    
    # clean up the environment
    rm(list=ls())
    
    print("Loading data files. Please be patient. This may take a few seconds ...")
    
    featurenames <- read.table("features.txt")
    mean_std_idx <- grep("(std|mean)", featurenames[,2])
    activity <- read.table("activity_labels.txt")
    activity <- rename(activity, activity.id=V1, activity.label=V2)
    y <- data.frame(rbind(read.table("train/y_train.txt"), read.table("test/y_test.txt")))
    y <- rename(y, activity.id=V1)
    s <- rbind(read.table("train/subject_train.txt"), read.table("test/subject_test.txt"))
    s <- rename(s, subject.id=V1)
    x1 <- read.table("train/x_train.txt")[, mean_std_idx]
    x2 <- read.table("test/x_test.txt")[, mean_std_idx]
    
    print("Loading completed. Processing ...")
    
    target <- cbind(y, s, rbind(x1, x2))
    result <- target %>% group_by(activity.id, subject.id) %>% summarise_each(funs(mean))
    result <- merge(activity, result, by.x="activity.id", by.y="activity.id")
    result <- result[,2:ncol(result)]
    nameidx <- grep("^V", names(result))
    oldname <- names(target)[nameidx]
    mean_std_names <- featurenames[,2][mean_std_idx]
    mean_std_names <- gsub("Gyro", "gyro.", gsub("Body", "body.", gsub("-", "", gsub("\\(.*\\)", "", mean_std_names))))
    mean_std_names <- gsub("^t", "t.", gsub("^f", "f.", gsub("Acc", "acc.", gsub("Gravity", "gravity.", mean_std_names))))
    mean_std_names <- gsub("Freq$", "freq", gsub("Mag", "mag.", gsub("Jerk", "jerk.", gsub("mean", "mean.", mean_std_names))))
    mean_std_names <- gsub("X", ".x", gsub("Y", ".y", gsub("Z", ".z", gsub("Freq", "freq", mean_std_names))))
    mean_std_names <- gsub("\\.\\.", ".", mean_std_names)
    
    result <- setnames(result, old=oldname, new=mean_std_names)
    write.table(result, "tidy.txt", row.name=FALSE)
    print(paste("Processing completed. Output file tidy.file under the directory:", getwd()))
}

process()