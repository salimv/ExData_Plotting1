#We use sqldf to read only required lines from the CSV data file
library(sqldf)

#We assume  the data to be under /data folder relative to the code
#We also assume that ? will be converted NA
power_df <-read.csv.sql(file="./data/household_power_consumption.txt", 
                        sql="select * from file where Date in ('1/2/2007', '2/2/2007')", sep=";")
power_df <- power_df[complete.cases(power_df),]


#Plot 3
pnfDev <- png("plot3.png", width=480, height=480)
x <- as.POSIXct(strptime(paste(power_df$Date,power_df$Time), "%d/%m/%Y %H:%M:%S"))
par(mar=c(2,3,1,1,))
plot(x, power_df$Sub_metering_1, type="n", ylab="Energy sub metering")
lines(x,power_df$Sub_metering_1)
lines(x,power_df$Sub_metering_2, col="red")
lines(x,power_df$Sub_metering_3, col="blue")
legend("topright", lwd=2, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)
dev.off()
