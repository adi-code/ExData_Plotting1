# load sqldf package for read.csv.sql function
library(sqldf)

# remember locale
lt <- Sys.getlocale("LC_TIME")
# set new locale
Sys.setlocale("LC_TIME", "C")

# the path to data set
filename <- "exdata-data-household_power_consumption/household_power_consumption.txt"

# SQL query, select rows for the first two days of February 2007
sql <- "select * from file where Date = '1/2/2007' or Date = '2/2/2007';"

# read selected rows
power <- read.csv.sql(filename, sep = ";", row.names = F, sql = sql)

# create Datetime column
power$Datetime <- as.POSIXlt(paste(power$Date, power$Time), format="%d/%m/%Y %H:%M:%S")

png("plot3.png", width=480, height=480, units="px")
par(bg=NA)
plot(power$Datetime, power$Sub_metering_1, type="l",
          ylab="Energy sub metering", xlab="")
lines(power$Datetime, power$Sub_metering_2, col="red")
lines(power$Datetime, power$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1)
dev.off()

# restore locale
Sys.setlocale("LC_TIME", lt)