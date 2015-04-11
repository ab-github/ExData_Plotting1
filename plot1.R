## plot1.R
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
png(filename = "plot1.png")

## plot histogram
hist(df$Global_active_power, col = "red", main = paste("Global Active Power"), xlab = "Global Active Power (kilowatts)")

## close the device
dev.off()

