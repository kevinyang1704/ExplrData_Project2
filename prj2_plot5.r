##################################################
##  Exploratory Data Analysis Project 2 Plot 5  ##
##  Author: Kevin Yang                          ##
##################################################
library("ggplot2")
#Read in data 
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,"exdata_NEI.zip")
unzip("exdata_NEI.zip", exdir="data")
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

#Merge datasets to obtain SCC names
newdf <- merge(NEI,SCC, by= "SCC")
#Subset data to motor vehicle sources in Baltimore only
newdf2 <- subset(newdf,fips=="24510")
mv_rows <- grep("mobile",tolower(newdf2$EI.Sector))
newdf2a <- newdf2[mv_rows,c("SCC","fips","Emissions","type","year")]

#summarize emissions 
SCC_mv <- with(newdf2a,aggregate(Emissions,by= list(year),FUN="sum"))
names(SCC_mv) <- c("year","sum.Emissions")

#Plot total emissions by year to PNG device
png(filename="plot5.png")
qplot(year,sum.Emissions, data=SCC_mv,xlab="Year", 
      ylab="Total Emissions", geom=c("point","line"),
      main="Total Emissions from motor vehical Sources in Baltimore sources")
dev.off()
