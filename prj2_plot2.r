##################################################
##  Exploratory Data Analysis Project 2 Plot 2  ##
##  Author: Kevin Yang                          ##
##################################################
#Read in data 
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,"exdata_NEI.zip")
unzip("exdata_NEI.zip", exdir="data")
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

#summarize emissions by year
baltimore <- subset(NEI,fips=="24510")
baltimore1 <- with(baltimore,aggregate(Emissions,by= list(year),FUN="sum"))
names(baltimore1) <- c("year","sum.emissions")

#Plot total emissions by year to PNG device
png(filename="plot2.png")
plot(baltimore1$year,baltimore1$sum.emissions, xlab="Year", 
     ylab="Total Emissions",type="b",main="Total Emissions by Year in Baltimore")
dev.off()

