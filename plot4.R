#######################Plot 2##################################################
library(dplyr)
library(lubridate)

# To save data and memory resources, we read only the relevant columns
# From plot1.R, I used nrow(dt1) to get number of rows to be loaded 
# A which command used to determine the row number of the date 2007/02/01

dt <- read.table("powerconsumption.txt", sep = ";", skip = 66637, nrows = 2880, 
                 na.strings=c("NA","?"), colClasses = "character")

colnames(dt)[-6] <- c("date", "time", "gap", "grp", "voltage","subm1", "subm2", "subm3")
# gap: Global_active_power
# grp: Global_reactive_power 
# subm1 : Sub_metering_1
# subm2 : Sub_metering_2
# subm3 : Sub_metering_3
colClasses <- c(rep("character", 2),rep("numeric",6))
#names(dt)
# We now need to set date and time variables as such
# There is no need of keeping separate date and time columns, so, we combine
#### and select only the columns we will be using here
dt1 <- dt %>% mutate(datetime = as.POSIXct(dmy_hms(paste(date, time)))) %>% 
                        select(datetime,gap,grp,voltage, subm1, subm2, subm3)

#head(dt1)
# # Now we invoke the device and plot
png("plot4.png", width = 480, height = 480, units = "px")

par(mfrow = c(2, 2))

with(dt1, plot(datetime, gap, type = "l", xlab = "", 
               ylab = "Global Active Power (Kilowatts)"))

with(dt1, plot(datetime, voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

with(dt1, plot(datetime,subm1, type="n", xlab = "", ylab = "Energy sub metering"))
with(dt1, points(datetime, subm1, col = "black", type = "l"))
with(dt1, points(datetime, subm2, col = "red", type = "l"))
with(dt1, points(datetime, subm3, col = "blue", type = "l"))
legend("topright", lty=1, col = c("black", "red", "blue"), 
       legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"))

plot(dt1$datetime, dt1$grp, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()