# Load Data from Working Directory
NEI <- readRDS('summarySCC_PM25.rds')


# Subset and Reshape Data
library(reshape2)
NEI_melt <- melt(data = subset(NEI, fips == '24510'),  # subset for Baltimore City, MD
                 id.vars = 'year',
                 measure.vars = 'Emissions')
NEI_cast <- dcast(NEI_melt, year ~ variable, sum)


# Plot
png(filename = 'plot2.png',
    width = 800,
    height = 600,
    units = 'px')

plot(x = NEI_cast$year,
     y = NEI_cast$Emissions,
     type = 'b',
     main = 'Total Fine Particulate Matter Emitted by Year Measured',
     sub = 'Baltimore City, Maryland',
     xlab = 'Year Measured',
     ylab = 'Fine Particulate Matter Emitted (tons)',
     col = 'green',
     pch = 16,
     cex = 2,
     lwd = 3)

dev.off()


