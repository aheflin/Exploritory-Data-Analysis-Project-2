# Load the data sets
SCC <- readRDS("./Source_Classification_Code.rds")
SUM <- readRDS("./summarySCC_PM25.rds")

# Create sample
SumSample <- SUM[sample(nrow(SUM), size=2000, replace=F), ]

# Aggregate data
Emissions <- aggregate(SUM[, 'Emissions'], by=list(SUM$year), FUN=sum)
Emissions$PM <- round(Emissions[,2]/1000,2)

# Generate graph
png(filename = "./plot1.png")
base1 <- barplot(Emissions$PM, names.arg = Emissions$Group.1,
        main = expression('Total Emissions of PM2.5'),
        xlab='Year', ylab = expression(paste('PM2.5', ' in Kilotons')))
print(base1)
dev.off()
