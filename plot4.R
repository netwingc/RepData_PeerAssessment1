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

# open the png device
png(file = "plot4.png", width = 480, height = 480, units = "px")
# Set up the plot, it's a 2x2 plot
par(mfcol=c(2,2))
# first plot "Global Active Power"
plot(ds$DateTime, ds$Global_active_power, type="l", ylab="Global Active Power", xlab="")
#second plot "Energy sub metering":
plot(ds$DateTime, ds$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(ds$DateTime, ds$Sub_metering_1, type="l", col="black")
lines(ds$DateTime, ds$Sub_metering_2, type="l", col="red")
lines(ds$DateTime, ds$Sub_metering_3, type="l", col="blue")
# Set legend for second plot, set bty = "n" to take away the box around the legend
legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# third plot "Voltage"
plot(ds$DateTime, ds$Voltage, type="l", ylab="Voltage", xlab="datetime")
#fourth plot "Global reactive power"
plot(ds$DateTime, ds$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
# close device
dev.off()
