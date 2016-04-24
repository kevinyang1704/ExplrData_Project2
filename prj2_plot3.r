##################################################
##  Exploratory Data Analysis Project 2 Plot 3  ##
##  Author: Kevin Yang                          ##
##################################################

library("ggplot2")

#Read in data 
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,"exdata_NEI.zip")
unzip("exdata_NEI.zip", exdir="data")
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

#summarize emissions by year and type in Baltimore
baltimore <- subset(NEI,fips=="24510")
baltimore2 <- with(baltimore,aggregate(Emissions,by= list(year, type),FUN="sum"))
names(baltimore2) <- c("year","type","sum.emissions")

#Plot total emissions by year to PNG device
png(filename="plot3.png")
g <- ggplot(baltimore2,aes(year,sum.emissions))
p <- g + geom_point(aes(color=type)) +geom_line(aes(color=type))+labs(x="Year") + labs(y="Total Emissions") +
     labs(title="Total Emissions by Year & Type in Baltimore")
print(p)
dev.off()

