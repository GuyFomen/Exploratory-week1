library(sqldf) ## sqldf package
png("plot2.png")## open the png screen device

## loading the data
df <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# factor to character
df$Date <- as.character(as.Date(df$Date,"%d/%m/%Y", origin="1900-01-01"))

#select rows
df2 <- sqldf("select * from df WHERE Date BETWEEN '2007-02-01' AND '2007-02-02'")

# factor to numeric
df2$Global_active_power <- as.numeric(levels(df2$Global_active_power))[df2$Global_active_power]
y <- df2$Global_active_power

## plot
plot(y, type = "l",  xlab="", ylab = "Global Active Power(Kilowatts)", axes = FALSE)
axis(1,at=c(0,1450,2900),labels = c("Thu","Fri","Sat"))
axis(2)
box()# box

dev.off() # close the png screen
