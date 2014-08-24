getdata
=======

# The raw data

wget

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

UCI HAR Dataset/

- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.



laptop057:UCI HAR Dataset alohr$ ls -l train
total 128992
drwxr-xr-x@ 11 alohr  staff       374 Nov 29  2012 Inertial Signals
-rw-r--r--@  1 alohr  staff  66006256 Nov 29  2012 X_train.txt		7352 rows, 561 columns
-rw-r--r--@  1 alohr  staff     20152 Nov 29  2012 subject_train.txt	7352 rows,   1 column
-rw-r--r--@  1 alohr  staff     14704 Nov 29  2012 y_train.txt          7352 rows,   1 column

laptop057:UCI HAR Dataset alohr$ ls -l test
total 51712
drwxr-xr-x@ 11 alohr  staff       374 Nov 29  2012 Inertial Signals	
-rw-r--r--@  1 alohr  staff  26458166 Nov 29  2012 X_test.txt		2947 rows, 561 columns
-rw-r--r--@  1 alohr  staff      7934 Nov 29  2012 subject_test.txt	2947 rows,   1 column
-rw-r--r--@  1 alohr  staff      5894 Nov 29  2012 y_test.txt		2947 rows,   1 column




Why is it tidy?
