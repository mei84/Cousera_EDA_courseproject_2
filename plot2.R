setwd("C:/Users/¿Ô/Desktop/Rprogramming/assignment/GettingAndCleaningData/exdata_data_NEI_data")
getwd()

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

options(scipen=999)    
library(plyr) 
Emissions <- ddply(NEI, .(year), summarise, TotalEmissions = sum(Emissions)) 

NEI_Balt <- NEI[NEI$fips=="24510",]
Emmision_Balt <- ddply(NEI_Balt, .(year), summarise, TotalEmissions = sum(Emissions))

## Draw plot2  
png(filename="plot2.png",  width= 480, height = 480) 
par(mfrow = c(1, 1), bg="transparent") 
barplot(Emmision_Balt$TotalEmissions, names.arg=Emissions$year, ylab="Emissions (Tons)", main="Total PM2.5 Emissions") 
dev.off() 
