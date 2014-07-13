
# Select your working directory
setwd("D:/Trabajo/Cursos/Exploratory data analysis/project 1")

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
# Set the locale to avoid problems with my local language on the weekdays
Sys.setlocale(category = "LC_TIME", locale = "C")
index <- as.POSIXct(strptime(paste(dataFrameDates$Date, dataFrameDates$Time), "%d/%m/%Y %H:%M:%S"))

##Construct the plot
png(file="plot2.png",width=480,height=480)
plot(index,dataFrameDates$Global_active_power,type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()