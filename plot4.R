## plot4.R
library(sqldf)

## Open a file connection
## The household_power_consumption.txt has to be in the same folder as this R file.
fileConn <- file("household_power_consumption.txt") 


## select necessary data instead of reading the entire file.
df <- sqldf("select * from fileConn where (Date = '1/2/2007' or Date = '2/2/2007')", file.format = list(header = TRUE, sep = ";"))

## Close the file connection
close(fileConn)

## convert the Date and Time columns Date/Time classes.
df$Date <- as.Date(sqldf$Date, "%d/%m/%Y")

datetime <- paste(df$Date, df$Time)

## add a new column called DateTime
df$DateTime <- as.POSIXct(datetime)

## open the png device
png(filename = "plot4.png")

## plot graphs in 2 rows and 2 cols
par(mfrow =c(2, 2))

# 1st row 1st col
plot(df$Global_active_power ~ df$DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# 1st row 2nd col
plot(df$Voltage ~ df$DateTime, type = "l", ylab = "Volatge", xlab = "datetime")

# 2nd row 1st col
plot(df$Sub_metering_1 ~ df$DateTime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(df$Sub_metering_2 ~ df$DateTime, type = "l", col = "Red")
lines(df$Sub_metering_3 ~ df$DateTime, type = "l", col = "Blue")
## add legend
legend("topright", col = c("black", "red", "blue"), lwd = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# 2nd row 2nd col
plot(df$Global_reactive_power ~ df$DateTime, type = "l", ylab = "Global_reactive_power", xlab = "datetime")


## close the device
dev.off()

