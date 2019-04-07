library(sqldf) ## sqldf package
png("plot3.png") # open the png screen device

## loading the data
df <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

## convert Date into character
df$Date <- as.character(as.Date(df$Date,"%d/%m/%Y", origin="1900-01-01"))

## select rows from 2007-02-01 to 2007-02-01
df2 <- sqldf("select * from df WHERE Date BETWEEN '2007-02-01' AND '2007-02-02'")

# transform factor to numeric
df2$Sub_metering_1 <- as.numeric(levels(df2$Sub_metering_1))[df2$Sub_metering_1]
df2$Sub_metering_2<- as.numeric(levels(df2$Sub_metering_2))[df2$Sub_metering_2]
df2$Sub_metering_3 <- as.numeric(levels(df2$Sub_metering_3))[df2$Sub_metering_3]

# plotting step by step
matplot(df2$Sub_metering_1, ylab="Energy sub metering", type = "l", axes=F) # no axes
matplot(df2$Sub_metering_2, type = "l", col="red", add=TRUE)
matplot(df2$Sub_metering_3, type = "l", col="blue", add=TRUE)

## adding legend
legend(2350, 40, legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("black", "red","blue"), lty=1, cex=0.6)

# costumizing the axis
axis(1,at=c(0,1450,2900),labels = c("Thu","Fri","Sat")) 
axis(2)
box() # box

dev.off() # close the png screen device
