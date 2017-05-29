setwd("C:/Users/¿Ô/Desktop/Rprogramming/assignment/GettingAndCleaningData/exdata_data_NEI_data")
getwd()

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
  
library(plyr) 
library(ggplot2)
SCC_Coal <- SCC[grep("[Cc]omb.*[cC]oal", SCC$Short.Name), ]
NEI_Coal <- merge(NEI,SCC_Coal)
Emission_Coal <- ddply(NEI_Coal, .(year), summarise, TotalEmissions = sum(Emissions))

## Draw plot4  
png(filename="plot4.png",  width= 480, height = 480) 
print(qplot(year, TotalEmissions, geom=c("line"), data=Emission_Coal,
	 main= "Total PM2.5 emissions related to Coal combustion in USA", ylab="Total Emissions (Tons)"))
dev.off() 
