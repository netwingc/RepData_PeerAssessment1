# set the working directory
setwd("c:/data/Rdata/EA/data")
# load the sqldf package
require("sqldf")
# construct the sql statement
selSql<-"SELECT * FROM file WHERE Date  in ('1/2/2007','2/2/2007')"
# read the subset
ds<-read.csv.sql("household_power_consumption.txt", sep=';',sql=selSql)
# change DateTime to the correct format
ds$DateTime <- strptime((paste(ds$Date, ds$Time, sep="-")), format="%d/%m/%Y-%H:%M:%S")
# set global active power from factor to numeric
ds$Global_active_power <- as.numeric(as.character(ds$Global_active_power))
# plot the data
plot(ds$DateTime, ds$Global_active_power, type="l",ylab="Global Active Power (kilowatts)", xlab="")
# copy the screen figure to file
dev.copy(png, file="plot2.png", width=480, height = 480)
# close the device
dev.off()