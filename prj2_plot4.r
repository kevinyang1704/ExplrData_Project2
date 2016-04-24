##################################################
##  Exploratory Data Analysis Project 2 Plot 4  ##
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
#Subset data to Coal sources only
coal_rows <- grep("coal",tolower(newdf$EI.Sector))
newdf1 <- newdf[coal_rows,c("SCC","fips","Emissions","type","year")]

#summarize emissions 
SCC_Coal <- with(newdf1,aggregate(Emissions,by= list(year),FUN="sum"))
names(SCC_Coal) <- c("year","sum.Emissions")

#Plot total emissions by year to PNG device
png(filename="plot4.png")
qplot(year,sum.Emissions, data=SCC_Coal,xlab="Year", 
      ylab="Total Emissions", geom=c("point","line"),
      main="Total Emissions from coal combustion-related sources by Year")
dev.off()
