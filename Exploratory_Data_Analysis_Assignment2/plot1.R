#Read the two files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)

#Aggregate emission data by year
NEI_yearem <- tapply(NEI$Emissions, NEI$year, sum)

#Set margins
par("mar" = c(4,6,4,4))

#Create the plot
plot(x = names(NEI_yearem), y = NEI_yearem, type = "l", xlab = "Year", 
          ylab = "Total" ~ PM[2.5] ~"Emissions", main = "Total" ~ PM[2.5] ~"Emissions", col = "violet")

#Save the plot as a png
dev.copy(png, file = "plot1.png")
dev.off()

