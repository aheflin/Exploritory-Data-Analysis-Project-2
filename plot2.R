# Load the data sets
SCC <- readRDS("./Source_Classification_Code.rds")
SUM <- readRDS("./summarySCC_PM25.rds")

# Create sample
SumSample2 <- SUM[sample(nrow(SUM), size=5000, replace=F), ]

# Subset data
Balt <- subset(SUM, fips=='24510')

# Generate graph
png(filename = "./plot2.png")
base2 <- barplot(tapply(X=Balt$Emissions, INDEX = Balt$year, FUN = sum),
        main = 'Total Emission in Baltimore City, MD',
        xlab = 'Year', ylab = expression('PM2.5'))
print(base2)

dev.off()