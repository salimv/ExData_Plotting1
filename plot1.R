#We use sqldf to read only required lines from the CSV data file
library(sqldf)

#We assume  the data to be under /data folder relative to the code
#We also assume that ? will be converted NA
power_df <-read.csv.sql(file="./data/household_power_consumption.txt", 
                        sql="select * from file where Date in ('1/2/2007', '2/2/2007')", sep=";")
power_df <- power_df[complete.cases(power_df),]


#Plot 1
pnfDev <- png("plot1.png", width=480, height=480)
par(mfrow=c(1,1))
par(mar=c(4,4,1,1))
with(power_df, hist(Global_active_power, col="red", main="Global Active Power",
                    xlab="Global Active Power (kilowatts)"))
dev.off()
