############ COURSERA ################### 
 #### EXPLANATORY DATA ANALYSIS ##########
library(lubridate)
library(dplyr)

# First we read the dataset into the workspace
dt <- read.table("powerconsumption.txt", sep = ";", 
                 na.strings=c("NA","?"), header = T)

# Converting the date and time columns into date_time formats 
dt$Date <- as.Date(dt$Date, format = "%d/%m/%Y")
dt$Time <- strptime(dt$Time, format ="%H:%M:%S") 

# I got a bid confused here, the strptime includes the current date
# into dr$Time though I specified %H:%M:%S
# Used gsub to remove the year-month-day part
dt$Time <- gsub(x=dt$Time,pattern="2017-02-11",replacement="",fixed=T)

# Here we are filtering so that we have only the selected date range data
dt <- dt %>% filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-01"))
head(dt)

## Plotting
png("plot1.png", width = 480, height = 480, units = "px")
hist(dt$Global_active_power, main = "Global Active Power", col = "red",
     xlab = "Global Active Power (kilowatts)")
dev.off()

 

