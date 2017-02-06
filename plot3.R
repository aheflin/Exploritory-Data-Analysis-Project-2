# Load ggplot2
require(ggplot2)

# Load the data sets
SCC <- readRDS("./Source_Classification_Code.rds")
SUM <- readRDS("./summarySCC_PM25.rds")

# Create sample
SumSample2 <- SUM[sample(nrow(SUM), size=5000, replace=F), ]

Balt <- subset(SUM, fips == 24510)
Balt$year <- factor(Balt$year, levels=c('1999', '2002', '2005', '2008'))

# Create graph
library(ggplot2)
png(filename='./plot3.png', width=800, height=500, units='px')
ggp3 <- ggplot(Balt,aes(factor(year),Emissions,fill=type)) + 
        geom_bar(stat="identity") + 
        theme_bw() + guides(fill=FALSE)+ 
        facet_grid(.~type,scales = "free",space="free") +  
        labs(x="year", y=expression("Total PM2.5 Emission (Tons)")) +  
        labs(title=expression("PM2.5 Emissions, Baltimore City 1999-2008 by Source Type")) 

print(ggp3) 
dev.off()
