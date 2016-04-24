##################################################
##  Exploratory Data Analysis Project 2 Plot 6  ##
##  Author: Kevin Yang                          ##
##################################################
library("ggplot2")
#Read in data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Merge datasets to obtain SCC names
newdf <- merge(NEI,SCC, by= "SCC")

#Subset data to motor vehicle sources in Baltimore only
newdf2 <- subset(newdf,fips %in% (c("24510","06037")))
mv_rows <- grep("mobile",tolower(newdf2$EI.Sector))
newdf2a <- newdf2[mv_rows,c("SCC","fips","Emissions","type","year")]

#Subset data to motor vehicle sources in Los Angeles only
#newdf3 <- subset(newdf,fips=="06037")
#mv_rows2 <- grep("mobile",tolower(newdf3$EI.Sector))
#newdf3a <- newdf3[mv_rows3,c("SCC","fips","Emissions","type","year")]

#summarize emissions 
SCC_mv <- with(newdf2a,aggregate(Emissions,by= list(year,fips),FUN="sum"))
#SCC_mv_LA <- with(newdf3a,aggregate(Emissions,by= list(year),FUN="sum"))
#names(SCC_mv_Blt) <- c("year","sum.Emissions")
names(SCC_mv) <- c("year","city","sum.Emissions")

#Plot total emissions by year to PNG device
png(filename="plot6.png")
qplot(year,sum.Emissions, data=SCC_mv,xlab="Year", ylab="Total Emissions", 
      geom=c("point","line"), color = city,
      main="Total Emissions from motor vehical Sources between LA and Baltimore")
dev.off()