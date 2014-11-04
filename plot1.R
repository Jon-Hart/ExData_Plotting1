# Download data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              "power.zip",
              method="curl")
unzip("power.zip")

# Load the data in
power.file <- file("household_power_consumption.txt")
power.lines <- readLines(power.file)
keep <- grepl("^[12]/2/2007",  power.lines)
power.filter <- power.lines[keep]
power.data <- read.table(text=power.filter, sep=";", header=F, na.strings="?",
           colClasses = c("character", "character", rep("numeric", 7)))
colnames(power.data) <- unlist(strsplit(power.lines[1], ";"))
power.data$datetime <- strptime(paste(power.data$Date, power.data$Time), 
                                format="%d/%m/%Y %H:%M:%S")

# Construct plot 1

png("plot1.png", 480, 480)
hist(power.data$Global_active_power, col="red",
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")
dev.off()
