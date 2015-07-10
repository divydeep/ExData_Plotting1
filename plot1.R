#Include libraries
library(lubridate)
library(dplyr)

#Read data
pwr <- read.table(file = "household_power_consumption.txt",header = TRUE,sep = ";",na.strings = c("?"),stringsAsFactors = FALSE)

#Convert columns to date and time
pwr$Date <- as.Date(pwr$Date, "%d/%m/%Y")
pwr$Time <- strptime(x = pwr$Time, format = "%T")
pwr$Time <- format.POSIXlt(pwr$Time, "%T")

#Subset data only from 02/01/2007 and 02/02/2007
pwr.s <- filter(pwr, pwr$Date == "2007-02-01" | pwr$Date == "2007-02-02" )

#Create histogram
hist(x = pwr.s$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#Save to file device
dev.copy(device = png, file="plot1.png")
dev.off()
