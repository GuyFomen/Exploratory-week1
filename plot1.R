library(sqldf) # calling package
png("plot1.png") # open screen device

## loading data
df <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

## changing the class from factor to character
df$Date <- as.character(as.Date(df$Date,"%d/%m/%Y", origin="1900-01-01"))

## select the right rows
df2 <- sqldf("select * from df WHERE Date BETWEEN '2007-02-01' AND '2007-02-02'")

# convert factor to numeric
df2$Global_active_power <- as.numeric(levels(df2$Global_active_power))[df2$Global_active_power]

# construct the histogram
hist(df2$Global_active_power, main = "Global Active Power", probability = seq(0,1,0.2), col = "red", xlab = "Global Active Power (Kilowatts)")

dev.off() # close the png device