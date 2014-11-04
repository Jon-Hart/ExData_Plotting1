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

png("plot4.png", 480, 480)
par(mfcol=c(2,2))

# Construct plot 1

plot(power.data$Global_active_power, type="l",
     xlab="", ylab="Global Active Power (kilowatts)", xaxt="n"
)
axis(1, c(0, 1440, 2880), labels=c("Thu", "Fri", "Sat"))


# Construct plot 2

plot(power.data$Sub_metering_1, type="l",
     xlab="", ylab="Energy sub metering", xaxt="n"
)
lines(power.data$Sub_metering_2, col="red")
lines(power.data$Sub_metering_3, col="blue")
axis(1, c(0, 1440, 2880), labels=c("Thu", "Fri", "Sat"))
legend("topright", lty=1, col=c("black", "red", "blue"), bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#construct plot 3
plot(power.data$Voltage, type="l", 
     xlab="datetime", ylab="Voltage",
     xaxt="n")
axis(1, c(0, 1440, 2880), labels=c("Thu", "Fri", "Sat"))

#construct plot 4
plot(power.data$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power",
     xaxt="n")
axis(1, c(0, 1440, 2880), labels=c("Thu", "Fri", "Sat"))

dev.off()

