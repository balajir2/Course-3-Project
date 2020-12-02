Understanding the assignment
a. the Samsung watch generates data. 6 streams of data. These are 
	1. Accelerometer
		X-direction
		Y-Direction
		Z-Direction
	2. Gyroscopic
		X-direction
		Y-Direction
		Z-Direction

b. The data were worked using transforms to derive
	a. Jerk signals (Body Jerk, Gyro Jerk)

c. Using the raw data from the files, 2 files were constructed and given to us as a starting point
	a. x_test && x_train
	b. y_test && y_train
	
	x_test/train contains aggregated data on the measures defined in features
	
To Do
Combine the test and train data that were randomly seperated. 
Join back the participants (subject) who performed the test and join back the 6 activity for which the measures were taken. 

Once there is a combined view of aggregated data, we can group the data by activity and by participant(subject) and find summary data like average. 