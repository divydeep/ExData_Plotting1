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
plot(pwr.s$Global_active_power ~ pwr.s$DT, type = "l",ylab = "Global Active Power (kilowatts)", xlab="")

#Save to file device
dev.copy(device = png, file="plot2.png")
dev.off()
