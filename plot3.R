# Get file from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# store and extract it in the parent folder in respect of this R file
# Read all data
data <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?", as.is=TRUE)
# Add Datetime column for easy of use in plotting and convert date from chr to Date class
data$Datetime <- suppressWarnings(as.POSIXct(strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")))
data$Date <- suppressWarnings(as.Date(data$Date, "%d/%m/%Y"))
# Get only the subset for Value from 2007-02-01 to 2007-02-02
subData <- subset(data[data$Date >= as.Date("2007-02-01") & data$Date<= as.Date("2007-02-02"),])
# Setup PNG file
png("plot3.png",width=572,height=698)
# Plot base line for Sub_meetering_1
with(subData, plot(Sub_metering_1 ~ Datetime, type = "l",
                 ylab = "Energy sub metering", xlab = NA, col = "black"))
# print additional lines for Sub_metering_2 and Sub_metering_3
lines(subData$Datetime, subData$Sub_metering_2, col = "red")
lines(subData$Datetime, subData$Sub_metering_3, col = "blue")
# Add legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"))
# Finish
dev.off()