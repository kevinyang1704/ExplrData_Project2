##################################################
##  Exploratory Data Analysis Project 2 Plot 1  ##
##  Author: Kevin Yang                          ##
##################################################
#Read in data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#summarize emissions by year
total_emission <- with(NEI,aggregate(Emissions,by= list(year),FUN="sum"))
names(total_emission) <- c("year","sum.emissions")

#Plot total emissions by year to PNG device
png(filename="plot1.png")
plot(total_emission$year,total_emission$sum.emissions, xlab="Year", 
     ylab="Total Emissions",type="b",main="Total Emissions by Year")
dev.off()

