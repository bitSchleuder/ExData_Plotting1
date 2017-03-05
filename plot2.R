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
png("plot2.png",width=572,height=698)
# mfrom = Column and row count, mar = vector of lines of margins in respect to bottom, top, left , rigth
par(mfrow = c(1, 1), mar = c(5, 4, 1, 1))
# Plot the data values
with(subData, plot(Global_active_power ~ Datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = NA, xaxt = 'n'))
axis.POSIXct(1, at=seq(as.Date("2007-02-01"), as.Date("2007-02-03"), by="day"), format="%a",labels = c("Thu", "Fri", "Sat"))
# Finish
dev.off()