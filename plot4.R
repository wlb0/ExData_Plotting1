## exdata-014 Assignment 1 part 4
## code for plot 4
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
png(filename="plot4.png", width=480, height=480)
par(mfrow = c(2,2))

# top left plot (pretty much same as part 2)
with(plotData, plot(dateTime, 
                Global_active_power, 
                type="l",
                col="black", 
                xlab="", 
                ylab="Global Active Power", 
                main=""))

# top right plot
with(plotData, plot(dateTime, 
                Voltage, 
                type="l",
                col="black", 
                xlab="datetime", 
                ylab="Voltage", 
                main=""))

# bottom left plot (essentially same as part 3)
with(plotData, plot(dateTime, 
    Sub_metering_1, 
    type="l",
    col="black", 
    xlab="",
    ylab="Energy sub metering", 
    main=""))
with(plotData, points(dateTime,
    Sub_metering_2,
    type="l",
    col="red"))
with(plotData, points(dateTime,
    Sub_metering_3,
    type="l",
    col="blue"))
legend("topright",
    bty="n",      # no border around legend this time
    lty=1,
    col=c("black", "red", "blue"),
    legend=names(plotData[7:9]),
    cex=0.95)

# bottom right plot
with(plotData, plot(dateTime, 
                Global_reactive_power, 
                type="l",
                col="black", 
                xlab="datetime", 
                main=""))

dev.off()
