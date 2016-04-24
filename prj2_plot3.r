##################################################
##  Exploratory Data Analysis Project 2 Plot 3  ##
##  Author: Kevin Yang                          ##
##################################################
#Read in data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library("ggplot2")

#summarize emissions by year
baltimore <- subset(NEI,fips=="24510")
baltimore2 <- with(baltimore,aggregate(Emissions,by= list(year, type),FUN="sum"))
names(baltimore2) <- c("year","sum.emissions","type")

#Plot total emissions by year to PNG device
png(filename="plot2.png")
plot(baltimore1$year,baltimore1$sum.emissions, xlab="Year", 
     ylab="Total Emissions",type="b",main="Total Emissions by Year in Baltimore")
dev.off()

