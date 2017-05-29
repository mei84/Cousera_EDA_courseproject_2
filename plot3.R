setwd("C:/Users/¿Ô/Desktop/Rprogramming/assignment/GettingAndCleaningData/exdata_data_NEI_data")
getwd()

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
  
library(plyr) 
NEI_Balt <- NEI[NEI$fips=="24510",]
Emmision2_Balt <- ddply(NEI_Balt, .(year,type), summarise, TotalEmissions = sum(Emissions))

## Draw plot3  
png(filename="plot3.png",  width= 480, height = 480) 
library(ggplot2)
par(mfrow = c(1, 1), bg="transparent") 
print(qplot(year, TotalEmissions, facets=.~type, geom=c("line"), data=Emmision2_Balt,
	 main= "Total PM2.5 emissions in Baltimore by type", ylab="Total Emissions (Tons)"))
dev.off() 
