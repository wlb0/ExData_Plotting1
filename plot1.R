## exdata-014 Assignment 1 part 1
## code for plot 1
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

# perform plot
png(filename="plot1.png", width=480, height=480)
with(plotData, hist(Global_active_power, 
    col="red",
    xlab="Global Active Power (kilowatts)",
    main="Global Active Power"))
dev.off()
