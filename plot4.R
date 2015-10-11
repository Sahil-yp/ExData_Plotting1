## Load the required libraries
library(data.table)
library(dplyr)
library(tidyr)

initial.dir <- getwd()

## Check if dataset exists, else download and unzip it
if(!file.exists("household_power_consumption.txt")){
        file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(file_url, destfile = "household_power_consumption.zip")
        unzip("household_power_consumption.zip")
        dateDownloaded <- date()
}

## Reading and Cleaning the Data
all_data <- tbl_df(read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = c("?", "")))
feb <- filter(all_data, Date == "1/2/2007" | Date == "2/2/2007")
feb$Date <- as.Date(feb$Date, format = "%d/%m/%Y")
timetemp <- paste(feb$Date, feb$Time)
feb$Time <- as.POSIXct(strptime(timetemp, format = "%Y-%m-%d %H:%M:%S"))


##Plot4.png
png("plot4.png")
par(mfcol = c(2,2))
with(feb, {
        plot(Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
        {
                plot(Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
                points(Time, Sub_metering_2, type = "l", col = "red")
                points(Time, Sub_metering_3, type = "l", col = "blue")
                legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        }

        plot(Time, Voltage, type = "l", xlab = "datetime")
        plot(Time, Global_reactive_power, type = "l", xlab = "datetime")
})
dev.off()