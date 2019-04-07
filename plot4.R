library(sqldf) # caling the sqldf package
png("plot4.png") # open the png device

### lodadin the data
df <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

## converting the variable date into character
df$Date <- as.character(as.Date(df$Date,"%d/%m/%Y", origin="1900-01-01"))

## selecting the right rows
df2 <- sqldf("select * from df WHERE Date BETWEEN '2007-02-01' AND '2007-02-02'")

# transforming the factor variable into numeric variable
df2$Global_active_power <- as.numeric(levels(df2$Global_active_power))[df2$Global_active_power]

df2$Voltage <- as.numeric(levels(df2$Voltage))[df2$Voltage]

df2$Global_reactive_power <- as.numeric(levels(df2$Global_reactive_power))[df2$Global_reactive_power]

df2$Sub_metering_1 <- as.numeric(levels(df2$Sub_metering_1))[df2$Sub_metering_1]
df2$Sub_metering_2<- as.numeric(levels(df2$Sub_metering_2))[df2$Sub_metering_2]
df2$Sub_metering_3 <- as.numeric(levels(df2$Sub_metering_3))[df2$Sub_metering_3]

## diving the screen into 4 to diplay each plot
par(mfrow=c(2,2))

## Global active power plot
y <- df2$Global_active_power
plot(y, type = "l",  xlab="", ylab = "Global Active Power(Kilowatts)", axes = FALSE)
axis(1,at=c(0,1450,2900),labels = c("Thu","Fri","Sat"))
axis(2)
box()
## voltage plot
x <- df2$Voltage
plot(x, type = "l",  xlab="datetime", ylab = "Voltage", axes = FALSE)
axis(1,at=c(0,1450,2900),labels = c("Thu","Fri","Sat"))
axis(2)
box()

##Enegy sub metring plot
matplot(df2$Sub_metering_1, ylab="Energy sub metering", type = "l", axes=F)
matplot(df2$Sub_metering_2, type = "l", col="red", add=TRUE)
matplot(df2$Sub_metering_3, type = "l", col="blue", add=TRUE)

# adding legend 
legend(1500, 40, legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("black", "red","blue"), lty=1, bty = "n", cex=0.6)
axis(1,at=c(0,1450,2900),labels = c("Thu","Fri","Sat"))
axis(2)
box()

## Global reactive power plot
z <- df2$Global_reactive_power
plot(z, type = "l",  xlab="", ylab = "Global_reactive_power", axes = FALSE)
axis(1,at=c(0,1450,2900),labels = c("Thu","Fri","Sat"))
axis(2)
box()

# closing the png device
dev.off()
