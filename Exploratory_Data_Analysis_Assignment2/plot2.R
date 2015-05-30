#Read the two files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)

#Retain just the Baltimore City data
NEI_Baltimore <- NEI[NEI$fips == "24510",]

#Aggregate emission data by year
NEI_yearem <- tapply(NEI_Baltimore$Emissions, NEI_Baltimore$year, sum)

#Set margins
par("mar" = c(4,6,4,4))

#Create the plot
plot(x = names(NEI_yearem), y = NEI_yearem, type = "l", xlab = "Year", 
     ylab = "Total" ~ PM[2.5] ~"Emissions", main = "Total" ~ PM[2.5] ~"Emissions for Baltimore", col = "violet")

#Save the plot as a png
dev.copy(png, file = "plot2.png")
dev.off()
