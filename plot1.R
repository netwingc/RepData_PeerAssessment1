# set the working directory
setwd("c:/data/Rdata/EA/data")
# load the sqldf package
require("sqldf")
# construct the sql statement
selSql<-"SELECT * FROM file WHERE Date  in ('1/2/2007','2/2/2007')"
# read the subset
ds<-read.csv.sql("household_power_consumption.txt", sep=';',sql=selSql)
# plot the histogram with the Global_active_power
hist(ds[,c(3)], main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")
# copy screen plot to file
dev.copy(png, file="plot1.png", width=480, height = 480)
# close the device
dev.off()