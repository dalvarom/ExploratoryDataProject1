
# Select your working directory
setwd("C:/Temp")

# Create a folder to save the zip file on it
if (!file.exists("./data")) {dir.create("./data")}
zipUrl= "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile = "./data/data.zip"
download.file (zipUrl, destfile=zipFile, method="auto")

# Unzip the file
unzip (zipFile)

# After that you will have a txt file called household_power_consumption.txt
textFile = "household_power_consumption.txt";

## Reading the data
dataFrame<-read.table(textFile, header=TRUE, sep=";", dec=".", na.string="?")
## We will only be using data from the dates 2007-02-01 and 2007-02-02
dataFrameDates<-dataFrame[with(dataFrame, Date=="1/2/2007"|Date=="2/2/2007"), ]
##Construct the plot
Sys.setlocale(category = "LC_TIME", locale = "C")
index <- as.POSIXct(strptime(paste(dataFrameDates$Date, dataFrameDates$Time), "%d/%m/%Y %H:%M:%S"))

png(file="plot3.png",width=480,height=480)
plot (index,dataFrameDates$Sub_metering_1,type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
lines (index,dataFrameDates$Sub_metering_2,type = "l", col = "red")
points (index,dataFrameDates$Sub_metering_3,type = "l", col = "blue")

legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

# Save it as PNG
#dev.copy(png, file="plot3.png")
dev.off()