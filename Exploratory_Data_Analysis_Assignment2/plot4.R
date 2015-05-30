#Read the two files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
library(ggplot2)
library(plyr)

#Join the datasets using SCC variable
NEI_SCC <- merge(NEI, SCC, by="SCC")

# fetch all NEISCC records which contain coal in Short.Name column 
coalMatches  <- grepl("coal", NEI_SCC$Short.Name, ignore.case=TRUE)
NEISCC_coal <- NEI_SCC[coalMatches, ]

#Aggregate the data
NEISCC_yearagg <- aggregate(Emissions ~ year, NEISCC_coal, sum)


#Create the plot

g <- ggplot(NEISCC_yearagg, aes(factor(year), Emissions))
g <- g + geom_bar(stat = "identity") +
  xlab("year") +
  ylab ("Total PM [2.5] Emissions") +
  ggtitle ("Total PM'[2.5] Emissions")
g
#Save the plot as a png
dev.copy(png, file = "plot4.png")
dev.off()