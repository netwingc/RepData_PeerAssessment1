# set the working directory
setwd("c:/data/Rdata/EA/data")
# load the package
require("sqldf")
# construct the sql statement
selSql<-"SELECT * FROM file WHERE Date  in ('1/2/2007','2/2/2007')"
# load the subset
ds<-read.csv.sql("household_power_consumption.txt", sep=';',sql=selSql)
# change DateTime to the correct format
ds$DateTime <- strptime((paste(ds$Date, ds$Time, sep="-")), format="%d/%m/%Y-%H:%M:%S")
# casting is not neccessary
#ds$Sub_metering_1 <- as.numeric(as.character(ds$Sub_metering_1))
#ds$Sub_metering_2 <- as.numeric(as.character(ds$Sub_metering_2))
#ds$Sub_metering_3 <- as.numeric(as.character(ds$Sub_metering_3))
# open png device
png(file = "plot3.png", width = 480, height = 480, units = "px")

# plot the data
plot(ds$DateTime, ds$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")

# Colour lines
lines(ds$DateTime, ds$Sub_metering_1, type="l", col="black")
lines(ds$DateTime, ds$Sub_metering_2, type="l", col="red")
lines(ds$DateTime, ds$Sub_metering_3, type="l", col="blue")
# set up and contstruct the legend
legend("topright",lty="solid", col = c("black", "red", "blue"),legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# the plot saved with dev.copy is not exactly the same 
#dev.copy(png, file="plot3.png", width=480, height = 480) 
# close the device
dev.off()