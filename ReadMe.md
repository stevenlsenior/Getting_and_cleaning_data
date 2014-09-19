This ReadMe describes how I have approached the programming assignment for the ‘Getting and Cleaning Data’ Coursera course. 

Notes for peer-graders:
For ease of reading (and hopefully marking), the script follows the instructions provided in the project description. I have also tried to provide full explanation in comments in the code. There is no doubt a much more compact way to achieve the same result, using chained operations in the dplyr package. However, I’ve tried to write different code chunks for each part of the assignment. Hopefully this makes it clearer why I’ve done each thing.

Notes on ‘tidy’ data:
The final data set and file conform with the principles of tidy data:
1) each observation (i.e. each subject performing each activity) has its own row (and only one row).

2) each variable has its own column. In this case, I have left the data ‘wide’, in other words, I have not sought to reduce the data to just ‘subject’, ‘activity’, ‘variable’, and ‘value’. This is because, in my view, each of the 79 columns represents a variable (not a value, as in the examples given in Hadley Wickham’s tidy data paper. There has been an active debate about this on the course forums, and reasonable people can differ.

3) each type of observational unit forms its own table. In this case, all observational units are a subject performing an activity.

The script assumes that the ‘UCI HAR Dataset’ provided by the course is in the working directory and has been unzipped. The dataset can be found here: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script uses the dplyr package, which is installed and loaded in lines 9 and 10. Importantly, there appears to be a problem with the ‘group_by’ function, which I found did not work correctly if the plyr package was loaded at the same time. To remove the plyr package use:

> detach(package:plyr)

1. Merge training and test data sets to create one data set
In this step, I: 

a) use the read.table() and readLines() commands to read in the values for the subject ids, activity ids, and associated smartphone sensor variables.

b) use cbind() to merge these into separate test and training datasets. 

c) read in the ‘features.txt’ file to get the variable names. I add ‘subject’ and ‘activity’ to this, because I’ve already added these variables. The reason I rename both files, rather than merging and then renaming only once, is that I found that having the same variable names for both test and training datasets makes using rbind() in the next step simpler

d) finally use rbind() to combine both ‘test’ and ‘train’ into one dataset called ‘all_data’

2. Extracts only the measurements on the mean and standard deviation for each data set
In this step I just use the ‘select()’ function from the dplyr package to select only those variables whose names contain the strings “-mean()” and “-std()”. I assign this to a new dataset called ‘mean_std’

3. Uses descriptive activity names to name activities in the data set
In this step I:

a) read in the ‘activity_labels.txt’ file as ‘act_labs’.

b) create a small function to look up the numeric activity values from the ‘activity’ variable in ‘mean_std’ in the ‘act_labs’ object, and return the corresponding descriptive activity names.

c) using the mutate() function from dplyr and the relabel() function created above, relabel the ‘activity’ variable using the descriptive names from the ‘act_labs’ object.

4. Create a second, independent tidy data set with the average of each variable for each activity and subject
Here I:

a) use a short chain of operations to group the ‘mean_std’ data tbl by subject and activity, calculate the mean for each variable using the ‘summarise_each()’ function, and assign this to a new data tbl called ‘tidy’

b) finally, I write out the data tbl using the ‘write.table()’ function, as instructed in the project descriptions.

Note: viewing the output file in a text editor doesn’t make it look very tidy! To check it, please load it into R. The code to do this is:

> data <- read.table(“tidy_data.txt”, header = T)

If you are using R Studio, the best way to view it is using:

> View(data)

Thanks for reading all the way down here!
 
