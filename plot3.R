#Include libraries
library(lubridate)
library(dplyr)

#Read data
pwr <- read.table(file = "household_power_consumption.txt",header = TRUE,sep = ";",na.strings = c("?"),stringsAsFactors = FALSE)

#Subset data only from 02/01/2007 and 02/02/2007
pwr.s <- filter(pwr, pwr$Date == "1/2/2007" | pwr$Date == "2/2/2007" )

#Convert columns to date and time and add new datetime column
pwr.s$Date <- dmy(pwr.s$Date)
pwr.s$Time <- hms(pwr.s$Time)
pwr.s$DT <- paste(pwr.s$Date,pwr.s$Time)
pwr.s$DT <- parse_date_time(pwr.s$DT, c("ymd_hms","%y%m%d %M%S","%y%m%d %S"))

#Create plot
plot(pwr.s$Sub_metering_1 ~ pwr.s$DT,ylab = "Energy sub metering", type ="l", xlab="")
lines(pwr.s$Sub_metering_2 ~ pwr.s$DT, col = "red")
lines(pwr.s$Sub_metering_3 ~ pwr.s$DT, col = "blue")
legend("topright", col=c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = 1,lwd = 2)

#Save to file device
dev.copy(device = png, file="plot3.png")
dev.off()
