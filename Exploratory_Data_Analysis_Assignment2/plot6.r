#Read the two files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
library(ggplot2)
library(plyr)

#Join the datasets using SCC variable
NEI_SCC <- merge(NEI, SCC, by="SCC")

# fetch all NEISCC records which contain coal in Short.Name column 
motorMatches  <- grepl("motor", NEI_SCC$Short.Name, ignore.case=TRUE)
NEISCC_motor <- NEI_SCC[motorMatches, ]

#Retain just the Baltimore City and Los Angeles data
NEI_Baltimore <- NEISCC_motor[NEISCC_motor$fips == "24510",]
NEI_LA <- NEISCC_motor[NEISCC_motor$fips=="06037",]

#Add LA and Baltimore columns 
NEI_Baltimore$City <- "Baltimore"
NEI_LA$City <- "LA"

#Merge by rows
NEI_BaltimoreLA <- rbind(NEI_Baltimore,NEI_LA )

#Aggregate the data
NEI_yearem_BaltimoreLA <- ddply(NEI_BaltimoreLA, .(City, year), summarize, Emissions = sum(Emissions))


#Create the plot

qplot(x = year, y = Emissions, data = NEI_yearem_BaltimoreLA,  group = City, color = City, geom = c("point", "line"), xlab = "Year", 
      ylab = "Total" ~ PM[2.5] ~"Emissions", main = "Total Motot Vehicle" ~ PM[2.5] ~"Emissions for Baltimore and LA")

#Save the plot as a png
dev.copy(png, file = "plot6.png")
dev.off()