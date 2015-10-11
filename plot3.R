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


##Plot3.png
png("plot3.png")
with(feb, plot(Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black"))
with(feb, points(Time, Sub_metering_2, type = "l", col = "red"))
with(feb, points(Time, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()