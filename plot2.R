##------------------------------------------------------------------------------
## plot2.R : Script File to read household power consumption data and generate
## ... plot2.png
##------------------------------------------------------------------------------

## Reading data into powerData dataframe and processing it.
## It is assumed that the dataset file is extracted in a subfolder
## ... of the working directory called 'data'.
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

## Generate plot2.png
##------------------------------------------------------------------------------
png("plot2.png", width = 480, height = 480)
with(powerData,plot(Time, Global_active_power, col = "black", type = "l",
                    ylab = "Global Active Power (kilowatts)", xlab = ""))
                    
dev.off()