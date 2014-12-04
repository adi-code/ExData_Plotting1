# load sqldf package for read.csv.sql function
library(sqldf)

# the path to data set
filename <- "exdata-data-household_power_consumption/household_power_consumption.txt"

# SQL query, select rows for the first two days of February 2007
sql <- "select * from file where Date = '1/2/2007' or Date = '2/2/2007';"

# read selected rows
power <- read.csv.sql(filename, sep = ";", row.names = F, sql = sql)

# create Datetime column
power$Datetime <- as.POSIXlt(paste(power$Date, power$Time), format="%d/%m/%Y %H:%M:%S")

# plot
png("plot1.png", width=480, height=480, units="px")
par(bg=NA)
hist(power$Global_active_power, breaks=12, freq=T, col="red",
          xlab="Global Active Power (kilowatts)", ylab="Frequency",
          main="Global Active Power")
dev.off()