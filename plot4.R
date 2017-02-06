# Load ggplot2
require(ggplot2)

# Load the data sets
SCC <- readRDS("./Source_Classification_Code.rds")
SUM <- readRDS("./summarySCC_PM25.rds")

# Set coal combustion related sources
SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

# Merge the data 
merge <- merge(x=SUM, y=SCC.coal, by='SCC')
merge.sum <- aggregate(merge[, 'Emissions'], by=list(merge$year), sum)
colnames(merge.sum) <- c('Year', 'Emissions')

# Create the graph
library(ggplot2)
png(filename="./plot4.png")
ggp4 <- ggplot(data=merge.sum, aes(x=Year, y=Emissions/1000)) +  
        geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=2, col=Emissions)) +  
        ggtitle(expression('Total Emissions of PM'[2.5])) +  
        ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) +  
        geom_text(aes(label=round(Emissions/1000,digits=2), size=2, hjust=1.5, vjust=1.5)) +  
        theme(legend.position='none') + scale_colour_gradient(low='black', high='red') 
print(ggp4) 
dev.off() 
