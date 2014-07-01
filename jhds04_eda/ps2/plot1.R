# Load Data from Working Directory
NEI <- readRDS('summarySCC_PM25.rds')


# Reshape Data
library(reshape2)
NEI_melt <- melt(data = NEI,
                 id.vars = 'year',
                 measure.vars = 'Emissions')
NEI_cast <- dcast(NEI_melt, year ~ variable, sum)


# Plot
png(filename = 'plot1.png',
    width = 800,
    height = 600,
    units = 'px')

plot(x = NEI_cast$year,
     y = NEI_cast$Emissions,
     type = 'b',
     main = 'Total Fine Particulate Matter Emitted by Year Measured',
     xlab = 'Year Measured',
     ylab = 'Fine Particulate Matter Emitted (tons)',
     col = 'blue',
     pch = 16,
     cex = 2,
     lwd = 3)

dev.off()



