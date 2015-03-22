#My Code Book (and how did I get there)
##What is in tidy.txt?
### The result:
The file contains the mean for either the mean or the standard deviation of measurements (see **Measurement variables** below) for each activity performed by each participant. 
### Key variables:
  * activity.label: the descriptive label of various activities the subject (i.e. the participant) performed.
  * subject.id: an integer represents the participant.

### Measurements variables:
  Given the large number of variables, I structured the variable names with **"."** as the delimiter in the names so each token represents a particular domain. For example, **t.body.acc.jerk.mean.x** can be broken down into tokens *t, body, acc, jerk, mean, x*. Below is list of the explanation of what each token means. Some of the explanation is taken from **features_into.txt** in **UCI HAR Dataset** given I am no expert of this domain.
  * __t__: denote time. The measurement represents the time domain signals captured at a constant rate (50Hz).
  * __f__: denote all variables after performing Fast Fourier Transform to the corresponding t.* variable.
  * __body, gravity__: indicate the measurement is contributed by the activity performed by the participant. Unlike "gravity", which was measured against the *g force*
  * __acc__: linear acceleration, captured by accelerometer.
  * __jerk__: sudden movement captured by accelerometer or gyroscope.
  * __gyro__: the measurement captured through gyroscope.
  * __mag__: maginitude. Calculated using the Euclidean norm.
  * __x, y, z__: denote the 3-axial signals in X, Y, and Z directions.
  * __mean__: the mean derived from a corresponding measurement. For example, t.body.acc.jerk.mean.x is the mean of x-axis of body linear acceleration of a jerk (captured by accelerometer).
  * __std__: the standard deviation from a corresponding measurement. For example, t.body.acc.jerk.std.x is the standard deviation of x-axis of body linear acceleration of a jerk (captured by accelerometer).

##How did I create the result
1. Simplifying the dataset:
  1. Rather than loading all 561 variables to create a `data.frame`. I started by figuring out what variables I need based on the instructions. I did this by loading `features.txt` first and identified variable names with *Mean* or *Std* in them.
  2. Once I have the indices of the variables required, I load the dataset with only those variables into the data.frames `x` and `y` for the measurement and activities respectively.
  3. `train/` or `test/` subject files are also loaded and V1 is renamed to `subject_id`.
  4. the variable V1, which represents the type of an activity, is renamed to `activity_id` onced loaded.
2. Merging, processing and writing output:
  1. `cbind` and `rbind` were used o merge the data vertically and horizontally.
  2. Use `summarise_each` to group-by activity_id and subject_id and calcualte the mean for the mean and std of the measurements.
  . Merge the outout from step 6. with activity label file and transform `activity_id` to a descriptive presentation, `activity_label` 
  3. To simplify the codebook explaination, I renamed the resulted variable names so they can be easily tell by the tokens.
  4. . Finally the output was written into a file called **tidy.txt**
3. Better messages:
  1. I added some minimal error handling so hopefully it is easier to know what went wrong
  2. Since the loading may take a few seconds, some messages were added so users know what is going on
  3. `rm(list=ls()` is added to ensure a clean environment for the script to run.
  
