#Read the two files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
library(ggplot2)
library(plyr)

#Retain just the Baltimore City data
NEI_Baltimore <- NEI[NEI$fips == "24510",]

#Convert type variable to a factor
NEI_Baltimore$type <- as.factor(NEI_Baltimore$type)

#Aggregate emission data by year
NEI_yearem_Baltimore <- ddply(NEI_Baltimore, .(type, year), summarize, Emissions = sum(Emissions))
NEI_yearem_Baltimore$Pollutant_type <- NEI_yearem_Baltimore$type

#Set margins
par("mar" = c(4,6,4,4))

#Create the plot
qplot(x = year, y = Emissions, data = NEI_yearem_Baltimore,  group = Pollutant_type, color = Pollutant_type, geom = c("point", "line"), xlab = "Year", 
     ylab = "Total" ~ PM[2.5] ~"Emissions", main = "Total" ~ PM[2.5] ~"Emissions for Baltimore by Pollutant Type")

#Save the plot as a png
dev.copy(png, file = "plot3.png")
dev.off()