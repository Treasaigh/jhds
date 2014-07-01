# Load Data from Working Directory
NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')


# Subset and Reshape Data
ei_sector <- unique(SCC$EI.Sector)
mobile_sector <- ei_sector[setdiff(grep('Mobile', ei_sector),
                                   grep('Non-Road', ei_sector))]
SCC_mobile <- subset(SCC, EI.Sector %in% mobile_sector)
NEI_mobile <- merge(x = subset(NEI, fips == '24510'), by.x = 'SCC',  # Subset Baltimore, MD
                    y = SCC_mobile, by.y = 'SCC')

library(reshape2)
NEI_melt <- melt(data = NEI_mobile,
                 id.vars = c('year','EI.Sector'),
                 measure.vars = 'Emissions')
NEI_cast <- dcast(NEI_melt, year + EI.Sector ~ variable, sum)


# Plot
library(ggplot2)

png(filename = 'plot5.png',
    width = 900,
    height = 600,
    units = 'px')

ggplot(data = NEI_cast, aes(x=year, y=Emissions)) +
    geom_line(aes(color = EI.Sector), size=2) +
    geom_point(fill='black', size=3, shape=16) +
    scale_y_log10() +
    ggtitle('Total Emissions from Mobile Sources by Year (Baltimore City, MD)') +
    xlab('Year Measured') +
    ylab('Fine Particulate Matter Emitted (tons) [log10 scale]')

dev.off()
