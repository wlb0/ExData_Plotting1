## exdata-014 Assignment 1 part 2
## code for plot 2
## assumes source data has already been downloaded and unzipped to
## csv file "household_power_consumption.txt" in the current directory

if (!require("sqldf")) {
    install.packages("sqldf")
}

library(sqldf)

# define wData as a file with indicated format 
wData <- file("household_power_consumption.txt") 
attr(wData, "file.format") <- list(sep = ";", header = TRUE) 

# use sqldf to read it in keeping only rows for the two specified dates
plotData <- sqldf("select * from wData where date = '1/2/2007' or date = '2/2/2007'")

# add column with date and time in proper date/time format,
# update date column to be proper date format
plotData$dateTime <- strptime(paste(plotData$Date,plotData$Time),format="%d/%m/%Y %H:%M:%S")
plotData$Date <- strptime(plotData$Date, "%d/%m/%Y")

# perform plot
png(filename="plot2.png", width=480, height=480)
with(plotData, plot(dateTime, 
     Global_active_power, 
     type="l",
     col="black", 
     xlab="", 
     ylab="Global Active Power (kilowatts)", 
     main=""))
dev.off()
