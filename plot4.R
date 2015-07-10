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

#Set rows/columns, margin and outer margin
par(mfrow = c(2,2),mar=c(4,4,2,1), oma=c(0,0,2,0))

#Create plot
with(pwr.s, {
  plot(pwr.s$Global_active_power ~ pwr.s$DT, type = "l",ylab = "Global Active Power", xlab="")
  plot(pwr.s$Voltage ~ pwr.s$DT, type="l", ylab = "Voltage", xlab="datetime")
  plot(pwr.s$Sub_metering_1 ~ pwr.s$DT,ylab = "Energy sub metering", type ="l", xlab="")
  lines(pwr.s$Sub_metering_2 ~ pwr.s$DT, col = "red")
  lines(pwr.s$Sub_metering_3 ~ pwr.s$DT, col = "blue")
  legend("topright", col=c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = 1,lwd = 2, bty = "n",x.intersp = 0.1, y.intersp = 0.4, inset = c(0,-0.1))
  plot(pwr.s$Global_reactive_power ~ pwr.s$DT, type="l", ylab = "Global_reactive_power", xlab="datetime")})

#Save to file device
dev.copy(device = png, file="plot4.png")
dev.off()
