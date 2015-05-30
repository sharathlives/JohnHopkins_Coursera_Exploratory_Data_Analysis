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

#Retain just the Baltimore City data
NEI_Baltimore <- NEISCC_motor[NEISCC_motor$fips == "24510",]

#Aggregate the data
NEI_yearem_Baltimore <- ddply(NEI_Baltimore, .(year), summarize, Emissions = sum(Emissions))



#Create the plot

qplot(x = year, y = Emissions, data = NEI_yearem_Baltimore, xlab = "Year", geom = c("point", "line"), 
      ylab = "Total" ~ PM[2.5] ~"Emissions", main = "Total Motor Vehicle" ~ PM[2.5] ~"Emissions for Baltimore")

#Save the plot as a png
dev.copy(png, file = "plot5.png")
dev.off()