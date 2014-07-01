# Load Data from Working Directory
NEI <- readRDS('summarySCC_PM25.rds')


# Subset and Reshape Data
library(reshape2)
NEI_melt <- melt(data = subset(NEI, fips == '24510'),  # subset for Baltimore City, MD
                 id.vars = c('year','type'),
                 measure.vars = 'Emissions')
NEI_cast <- dcast(NEI_melt, year + type ~ variable, sum)


# Plot
library(ggplot2)

png(filename = 'plot3.png',
    width = 800,
    height = 600,
    units = 'px')

ggplot(data = NEI_cast, aes(x=year, y=Emissions)) +
    geom_line(aes(color=type), size=2) +
    geom_point(fill='black', size=3, shape=16) + 
    ggtitle('Total Emissions by Year and Type (Baltimore City, MD)') +
    xlab('Year Measured') +
    ylab('Fine Particulate Matter Emitted (tons)')

dev.off()


