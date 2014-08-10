##------------------------------------------------------------------------------
## plot4.R : Script File to read household power consumption data and generate
## ... plot4.png
##------------------------------------------------------------------------------

## Reading data into powerData dataframe and processing it.
##------------------------------------------------------------------------------
powerData <- read.csv("./data//household_power_consumption.txt",sep = ";",
                      comment.char = '', na.strings = "?",
                      colClasses = c("character", "character", rep("numeric",7))
                      )
## Coerce Date variable to type 'Date'
powerData$Date <- as.Date(powerData$Date, format = "%d/%m/%Y")
## Trim dataframe to contain only data for dates of interest
powerData <- powerData[powerData$Date >= "2007-02-01" 
                       & powerData$Date < "2007-02-03",]
## Supply 'date component' to Time variable and
## ... convert to POSIXlt type (DateTime).   
powerData$Time <- paste(powerData$Date, powerData$Time)
powerData$Time <- strptime(powerData$Time, format = "%Y-%m-%d %H:%M:%S")

## Generate plot4.png
##------------------------------------------------------------------------------
png("plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))
## subplot [1,1]
with(powerData, plot(Time, Global_active_power, col = "black", type = "l",
                     ylab = "Global Active Power", xlab = ""))
## subplot [2,1]
with(powerData, plot(Time, Sub_metering_1, type = "l",
                     ylab = "Energy sub metering", xlab = " "))
with(powerData, lines(Time,Sub_metering_2,col="red"))
with(powerData, lines(Time,Sub_metering_3,col="blue"))
legend("topright", lty=1, col=c("black", "red", "blue"),
       bty="n", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
## subplot [1,2]
with(powerData, plot(Time, Voltage, type="l", xlab = "datetime"))
## subplot[2,2]
with(powerData, plot(Time, Global_reactive_power, type = "l",xlab = "datetime"))
dev.off()