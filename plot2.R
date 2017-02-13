############ COURSERA ################### 
#### EXPLANATORY DATA ANALYSIS ##########
#######################Plot 2##################################################
library(dplyr)
library(lubridate)

# To save data and memory resources, we read only the relevant columns
# From plot1.R, I used nrow(dt1) to get number of rows to be loaded 
# A which command used to determine the row number of the date 2007/02/01

dt <- read.table("powerconsumption.txt", sep = ";", skip = 66637, nrows = 2880, 
                 na.strings=c("NA","?"), colClasses = "character")

colnames(dt)[1:3] <- c("date", "time", "gpa")
# gpa: Global_active_power
# grp: Global_reactive_power 
# gin: Global_intensity

#names(dt)
# We now need to set date and time variables as such
# There is no need of keeping separate date and time columns, so, we combine
#### and select only the columns we will be using here
dt1 <- dt %>% mutate(date = as.POSIXct(dmy_hms(paste(date, time))),
                        gpa = as.numeric(gpa)) %>% select(date,gpa)

#head(dt1)
# Now we invoke the device and plot
png("plot2.png", width = 480, height = 480, units = "px")
plot(dt1$date,dt1$gpa, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()