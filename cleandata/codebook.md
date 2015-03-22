#What is in tidy.txt?
## key variables:
  * activity.label: the descriptive label of various activities the subject (i.e. the participant) performed.
  * subject.id: an integer represents the participant.

## measurements variables:
  Given the large number of variables, I structured the variable names with **"."** as the delimiter in the names so each token represents a particular domain. For example, **t.body.acc.jerk.mean.x** can be broken down into tokens *t, body, acc, jerk, mean, x*. Below is list of the explanation of what each token means. Some of the explanation is taken from **features_into.txt** in **UCI HAR Dataset** given I am no expert of this domain.
  * __t__: denote time. The measurement represents the time domain signals captured at a constant rate (50Hz).
  * __f__: denote all variables after performing Fast Fourier Transform to the corresponding t.* variable.
  * __body, gravity__: indicate the measurement is contributed by the activity performed by the participant. Unlike "gravity", which was measured against the *g force*
  * __acc__: linear acceleration, captured by accelerometer.
  * __jerk__: sudden movement captured by accelerometer or gyroscope.
  * __gyro__: the measurement is captured through gyroscope.
  * __mag__: maginitude. Calculated using the Euclidean norm.
  * __x, y, z__: denote the 3-axial signals in X, Y, and Z directions.
  * __mean__: the mean derived from a corresponding measurement. For example, t.body.acc.jerk.mean.x is the mean of x-axis of body linear acceleration of a jerk (captured by accelerometer).
  * __std__: the standard deviation from a corresponding measurement. For example, t.body.acc.jerk.std.x is the standard deviation of x-axis of body linear acceleration of a jerk (captured by accelerometer).
