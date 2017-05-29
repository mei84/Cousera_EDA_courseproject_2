setwd("C:/Users/¿Ô/Desktop/Rprogramming/assignment/GettingAndCleaningData/exdata_data_NEI_data")
getwd()

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
  
library(plyr) 
library(ggplot2)
unique(SCC[grep("On-Road", SCC$EI.Sector), ]$EI.Sector)

SCC_MV <- SCC[grep("On-Road", SCC$EI.Sector), ]
NEI_Balt <- NEI[NEI$fips=="24510",]
NEI_MV_Balt <- merge(NEI_Balt,SCC_MV)
Emission_MV_Balt <- ddply(NEI_MV_Balt, .(year), summarise, TotalEmissions = sum(Emissions))


## Draw plot5  
png(filename="plot5.png",  width= 480, height = 480) 
print(qplot(year, TotalEmissions, geom=c("line"), data=Emission_MV_Balt,
	 main= "Total PM2.5 emissions related to Motor Vehicle Sources in Baltimore", ylab="Total Emissions (Tons)"))
dev.off() 
