# Load ggplot2
require(ggplot2)

# Load the data sets
SCC <- readRDS("./Source_Classification_Code.rds")
SUM <- readRDS("./summarySCC_PM25.rds")

# Create subset for MD and CA
MD.onroad <- subset(SUM, fips == '24510' & type == 'ON-ROAD') 
CA.onroad <- subset(SUM, fips == '06037' & type == 'ON-ROAD') 

# Aggregate
MD.DF <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum) 
colnames(MD.DF) <- c('year', 'Emissions') 
MD.DF$City <- paste(rep('MD', 4)) 

CA.DF <- aggregate(CA.onroad[, 'Emissions'], by=list(CA.onroad$year), sum) 
colnames(CA.DF) <- c('year', 'Emissions') 
CA.DF$City <- paste(rep('CA', 4))
DF <- as.data.frame(rbind(MD.DF, CA.DF))

# Create graph
library(ggplot2)
png(filename="./plot6.png")

ggp6 <- ggplot(data = DF, aes(x=factor(year), y=Emissions, fill=city)) + 
        geom_bar(aes(fill=year),stat="identity") + 
        facet_grid(scales="free", space="free", .~city) + 
        guides(fill=FALSE) + theme_bw() + 
        labs(x="year", y=expression("Total PM2.5 Emission (Kilo-Tons)")) +  
        labs(title=expression("PM2.5 Motor Vehicle Source Emissions in Baltimore, 
        MD & Los Angeles, CA 1999-2008")) 

print(ggp6)
dev.off() 


