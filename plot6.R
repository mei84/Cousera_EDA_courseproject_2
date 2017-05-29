setwd("C:/Users/¿Ô/Desktop/Rprogramming/assignment/GettingAndCleaningData/exdata_data_NEI_data")
getwd()

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
  
library(plyr) 
library(ggplot2)

SCC_MV <- SCC[grep("On-Road", SCC$EI.Sector), ]
NEI_Balt_LA <- NEI[NEI$fips=="24510" | NEI$fips=="06037",]
NEI_MV_Balt_LA <- merge(NEI_Balt_LA,SCC_MV)
Emission_MV_Balt_LA <- ddply(NEI_MV_Balt_LA, .(year, fips), summarise, TotalEmissions = sum(Emissions))

Emission_MV_Balt_LA$City <- ""
Emission_MV_Balt_LA[Emission_MV_Balt_LA$fips=="24510",]$City <- "Baltimore"
Emission_MV_Balt_LA[Emission_MV_Balt_LA$fips=="06037",]$City <- "Los Angeles"

Baseline_Balt <- Emission_MV_Balt_LA[Emission_MV_Balt_LA$City=="Baltimore" & Emission_MV_Balt_LA$year==1999,]$TotalEmissions
Baseline_LA <- Emission_MV_Balt_LA[Emission_MV_Balt_LA$City=="Los Angeles" & Emission_MV_Balt_LA$year==1999,]$TotalEmissions
Emission_MV_Balt_LA$EmissionsVar <- NA
Emission_MV_Balt_LA[Emission_MV_Balt_LA$City=="Baltimore",]$EmissionsVar <- Emission_MV_Balt_LA[Emission_MV_Balt_LA$City=="Baltimore" ,]$TotalEmissions /Baseline_Balt
Emission_MV_Balt_LA[Emission_MV_Balt_LA$City=="Los Angeles",]$EmissionsVar <- Emission_MV_Balt_LA[Emission_MV_Balt_LA$City=="Los Angeles" ,]$TotalEmissions /Baseline_LA


## Draw plot6  
g <- ggplot(Emission_MV_Balt_LA, aes(x=year, y=EmissionsVar*100, colour=City, group=City)) 
g <- g + geom_line(size=1) + ggtitle("Motor Vehicle PM 2.5 emission Variation in Baltimore and LA")
g <- g + ylab("Emission Variation (baseline 1999=100)")
g <- g + annotate("text", x = 2004, y = 80, size=4, label = "LA PM 2.5 MV emission increased 4%,")
g <- g + annotate("text", x = 2004, y = 75, size=4, label = "Baltimore PM 2.5 MV emission decreased 75%")

png(filename="plot6.png",  width= 480, height = 480) 
print(g)
dev.off() 
