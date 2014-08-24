library(plyr)

readActivityLabels <- function(file = "UCI HAR Dataset/activity_labels.txt") {
  read.table(file, col.names = c('label', 'activity'))
}

readFeatureList <- function(file = "UCI HAR Dataset/features.txt") {
  read.table(file, col.names = c('index', 'feature'))
}

readDataSet <- function(set, activitylabels, featurelist) {
  
  # subject
  subjectfile <- sprintf("UCI HAR Dataset/%s/subject_%s.txt", set, set)
  subject <- read.table(subjectfile, col.names = c('subject'), colClasses = c('factor'))
  
  #  activity
  activityfile <- sprintf("UCI HAR Dataset/%s/y_%s.txt", set, set)
  activity <- merge(
    read.table(activityfile, col.names = c('label')),
    activitylabels)[, 'activity']
  
  # features
  myColClasses <- ifelse(grepl("mean\\(\\)|std\\(\\)", featurelist$feature, perl = T), 'numeric', 'NULL') 
  myColNames <- gsub("[\\(\\)]", "", featurelist$feature) # strip unwanted characters
  
  featurefile <- sprintf("UCI HAR Dataset/%s/X_%s.txt", set, set)
  features <- read.table(featurefile,
    col.names = myColNames,
    colClasses = myColClasses)
  
  cbind(subject, activity, features)
}

runAnalysis <- function() {
  activitylabels <- readActivityLabels()
  featurelist <- readFeatureList()
  
  data <- rbind(
    readDataSet('train', activitylabels, featurelist),
    readDataSet('test', activitylabels, featurelist)
  )

  # use numcolwise() to run a summary over all numeric columns
  tidy <- ddply(data, .(subject, activity), numcolwise(mean))
  
  write.table(tidy, "tidy.txt", row.names = F)
  tidy
}
