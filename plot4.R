#We use sqldf to read only required lines from the CSV data file
library(sqldf)

#We assume  the data to be under /data folder relative to the code
#We also assume that ? will be converted NA
power_df <-read.csv.sql(file="./data/household_power_consumption.txt", 
                        sql="select * from file where Date in ('1/2/2007', '2/2/2007')", sep=";")
power_df <- power_df[complete.cases(power_df),]


#Plot 4
pnfDev <- png("plot4.png", width=480, height=480)
par(mfcol=c(2,2))
x <- as.POSIXct(strptime(paste(power_df$Date,power_df$Time), "%d/%m/%Y %H:%M:%S"))
plot(x, power_df$Global_active_power, type="n", xlab=NA,ylab="Global Active Power")
lines(x,power_df$Global_active_power)

plot(x, power_df$Sub_metering_1, type="n", ylab="Energy sub metering")
lines(x,power_df$Sub_metering_1)
lines(x,power_df$Sub_metering_2, col="red")
lines(x,power_df$Sub_metering_3, col="blue")
legend("topright", lwd=2, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)


plot(x, power_df$Voltage, type="n", xlab="datetime",ylab="Voltage")
lines(x,power_df$Voltage)

plot(x, power_df$Global_reactive_power, type="n", xlab="datetime",ylab="Global_reactive_power")
lines(x,power_df$Global_reactive_power)
dev.off()
