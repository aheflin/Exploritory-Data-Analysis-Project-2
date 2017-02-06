# Load ggplot2
require(ggplot2)

# Load the data sets
SCC <- readRDS("./Source_Classification_Code.rds")
SUM <- readRDS("./summarySCC_PM25.rds")

SUM$year <- factor(SUM$year, levels=c('1999', '2002', '2005', '2008'))
MD.onroad <- subset(SUM, fips == 24510 & type == 'ON-ROAD')

# Aggregate
MD.df <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum) 
colnames(MD.df) <- c('year', 'Emissions') 

# Create graph

require(ggplot2)
png(filename="./plot5.png")

ggp5 <- ggplot(MD.onroad,aes(factor(year),Emissions)) + 
        geom_bar(stat="identity",fill="grey",width=0.75) + 
        theme_bw() +  guides(fill=FALSE) + 
        labs(x="year", y=expression("Total PM2.5 Emission (10^5 Tons)")) +  
        labs(title=expression("PM2.5 Motor Vehicle Source Emissions in Baltimore from 1999-2008")) 

print(ggp5)
dev.off()

