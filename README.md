# Raw Data 

```
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
```

Download and unzip:

```
$ ls -l train
total 128992
drwxr-xr-x@ 11 alohr  staff       374 Nov 29  2012 Inertial Signals
-rw-r--r--@  1 alohr  staff  66006256 Nov 29  2012 X_train.txt		# 7352 rows, 561 columns
-rw-r--r--@  1 alohr  staff     20152 Nov 29  2012 subject_train.txt	# 7352 rows,   1 column
-rw-r--r--@  1 alohr  staff     14704 Nov 29  2012 y_train.txt          # 7352 rows,   1 column

$ ls -l test
total 51712
drwxr-xr-x@ 11 alohr  staff       374 Nov 29  2012 Inertial Signals	
-rw-r--r--@  1 alohr  staff  26458166 Nov 29  2012 X_test.txt		# 2947 rows, 561 columns
-rw-r--r--@  1 alohr  staff      7934 Nov 29  2012 subject_test.txt	# 2947 rows,   1 column
-rw-r--r--@  1 alohr  staff      5894 Nov 29  2012 y_test.txt		# 2947 rows,   1 column
```

The data set is split into a training set (70%, 21 subjects) and a test set (30%, 7 subjects).

# Transformation

1. Subject

The subject_train.txt and subject_test.txt files contain a single integer identifying the
subject who performed the activities. The number runs from 1 to 30. I use read.table to
read this in.

```R
subject <- read.table(subjectfile, col.names = c('subject'), colClasses = c('factor'))
```

2. Activities

The y_train.txt and y_test.txt files contain an index of the activity. I will use the activity_labels.txt
file to map the activity index to a descriptive name.

```R
activitylabels <- read.table(file, col.names = c('label', 'activity'))
activitylabels
  label           activity
1     1            WALKING
2     2   WALKING_UPSTAIRS
3     3 WALKING_DOWNSTAIRS
4     4            SITTING
5     5           STANDING
6     6             LAYING

# merge and get rid of the 'label' column:
activity <- merge(
    read.table(activityfile, col.names = c('label')),
    activitylabels)[, 'activity']
```

3. Features

The X_train.txt and X_test.txt files contain the feature normalized (bounded witin [-1, 1]) gyroscope
and accelerometer variables. There are 561 variables in the feature vector, but we are asked to extract
the mean and std variables only. I start by reading the features.txt file into a dataframe

```R
head(featurelist, 10)
   index           feature
1      1 tBodyAcc-mean()-X  # include
2      2 tBodyAcc-mean()-Y  # include
3      3 tBodyAcc-mean()-Z  # include
4      4  tBodyAcc-std()-X  # include
5      5  tBodyAcc-std()-Y  # include
6      6  tBodyAcc-std()-Z  # include
7      7  tBodyAcc-mad()-X  # ignore
8      8  tBodyAcc-mad()-Y  # ignore
9      9  tBodyAcc-mad()-Z  # ignore
10    10  tBodyAcc-max()-X  # ignore
```

From this I create a vector suitable for read.tables's colClasses argument to tell read.table which columns to include and
which columns to ignore. A value of 'NULL' instructs read.table to skip the column.

```
head(grepl("mean\\(\\)|std\\(\\)", featurelist$feature, perl=T), 10)
 [1]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE
```

```R
myColClasses <- ifelse(grepl("mean\\(\\)|std\\(\\)", featurelist$feature, perl=T), 'numeric', 'NULL')

features <- read.table(featurefile,
    col.names = gsub("[\\(\\)]", "", featurelist$feature), # strip unwanted characters
    colClasses = myColClasses)
```
