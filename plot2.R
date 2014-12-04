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

# plot
png("plot2.png", width=480, height=480, units="px")
par(bg=NA)
plot(power$Datetime, power$Global_active_power, type="l",
          ylab="Global Active Power (kilowatts)", xlab="")
dev.off()

# restore locale
Sys.setlocale("LC_TIME", lt)