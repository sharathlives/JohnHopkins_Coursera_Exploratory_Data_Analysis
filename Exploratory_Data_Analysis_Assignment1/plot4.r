#Step 1: Read the text file
power_data <- read.table("./data/household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE, stringsAsFactors=FALSE)
#Step 2: Filter the data to include only Feb 1st 2007 and Feb 2nd 2007
power_data$DateFormatted <- as.Date(power_data$Date, "%d/%m/%Y")
power_data_filtered <- power_data[power_data$DateFormatted %in% as.Date(c('2007-02-01', '2007-02-02')),]
# Step 3: Format the date and time variable, Strptime does not output the correct data format. 

power_data_filtered$DateTime <- paste(power_data_filtered$Date, power_data_filtered$Time)
power_data_filtered$DateTime <- strptime(power_data_filtered$DateTime, format = "%d/%m/%Y %H:%M:%S")
power_data_filtered$DateTimetest <- as.POSIXct(paste(power_data_filtered$Date, power_data_filtered$Time), format="%d/%m/%Y %H:%M:%S")

# Step 5: Create plot 4
#Adjust the margins 
par("mar" = c(4,4,2,2))
par(mfrow = c(2,2))
# Plot 1
plot(y = power_data_filtered$Global_active_power, x = power_data_filtered$DateTimetest, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l") 
# Plot 2
plot(y = power_data_filtered$Voltage, x = power_data_filtered$DateTimetest, ylab = "Voltage", xlab = "datetime", type = "l") 
# Plot 3
plot(y = power_data_filtered$Sub_metering_1, x = power_data_filtered$DateTimetest, type = "l", col = "black", xlab="", ylab = "Energy sub metering")
lines(y = power_data_filtered$Sub_metering_2, x = power_data_filtered$DateTimetest, type = "l", col = "red")
lines(y = power_data_filtered$Sub_metering_3, x = power_data_filtered$DateTimetest, type = "l", col = "blue")
legend("topright", legend = c("Sub-metering_1", "Sub-metering_2", "Sub-metering_3"), col = c("black", "blue", "red"), lty = c(1,1,1))
# Plot 4
plot(y = power_data_filtered$Global_reactive_power, x = power_data_filtered$DateTimetest, type = "l", col = "black", xlab="datetime", ylab = "Global_reactive_power")



#Step 6: Save as a .png
dev.copy(png, file = "./Plots/plot4.png")
dev.off()