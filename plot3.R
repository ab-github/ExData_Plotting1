## plot3.R
library(sqldf)

## Open a file connection
## The household_power_consumption.txt has to be in the same folder as this R file.
fileConn <- file("household_power_consumption.txt") 


## select necessary data instead of reading the entire file.
df <- sqldf("select * from fileConn where (Date = '1/2/2007' or Date = '2/2/2007')", file.format = list(header = TRUE, sep = ";"))

## Close the file connection
close(fileConn)

## convert the Date and Time columns Date/Time classes.
df$Date <- as.Date(df$Date, "%d/%m/%Y")

datetime <- paste(df$Date, df$Time)

## add a new column called DateTime
df$DateTime <- as.POSIXct(datetime)

## open the png device
png(filename = "plot3.png", width = 480, height = 480, units = "px")

## plot line graph with legend

plot(df$Sub_metering_1 ~ df$DateTime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(df$Sub_metering_2 ~ df$DateTime, type = "l", col = "Red")
lines(df$Sub_metering_3 ~ df$DateTime, type = "l", col = "Blue")

## add legend

legend("topright", col = c("black", "red", "blue"), lwd = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


## close the device
dev.off()

