#Step 1: Read the text file
power_data <- read.table("./data/household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE, stringsAsFactors=FALSE)
#Step 2: Filter the data to include only Feb 1st 2007 and Feb 2nd 2007
power_data$DateFormatted <- as.Date(power_data$Date, "%d/%m/%Y")
power_data_filtered <- power_data[power_data$DateFormatted %in% as.Date(c('2007-02-01', '2007-02-02')),]
# Step 3: Format the date and time variable, Strptime does not output the correct data format. 

power_data_filtered$DateTime <- paste(power_data_filtered$Date, power_data_filtered$Time)
power_data_filtered$DateTime <- strptime(power_data_filtered$DateTime, format = "%d/%m/%Y %H:%M:%S")
power_data_filtered$DateTimetest <- as.POSIXct(paste(power_data_filtered$Date, power_data_filtered$Time), format="%d/%m/%Y %H:%M:%S")

# Step 5: Create plot 1
hist(power_data_filtered$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", right = FALSE)

