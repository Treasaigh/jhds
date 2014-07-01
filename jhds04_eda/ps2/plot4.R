# Load Data from Working Directory
NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')


# Subset and Reshape Data
ei_sector <- unique(SCC$EI.Sector)
coal_sector <- ei_sector[intersect(grep('Coal', ei_sector), grep('Fuel Comb', ei_sector))]
SCC_coal <- subset(SCC,EI.Sector %in% coal_sector)
NEI_coal <- merge(x = NEI, by.x = 'SCC',
                  y = SCC_coal, by.y = 'SCC')

library(reshape2)
NEI_melt <- melt(data = NEI_coal,
                 id.vars = c('year','EI.Sector'),
                 measure.vars = 'Emissions')
NEI_cast <- dcast(NEI_melt, year + EI.Sector ~ variable, sum)


# Plot
library(ggplot2)

png(filename = 'plot4.png',
    width = 900,
    height = 600,
    units = 'px')

ggplot(data = NEI_cast, aes(x=year, y=Emissions)) +
    geom_line(aes(color=EI.Sector), size=2) +
    geom_point(fill='black', size=3, shape=16) +
    scale_y_log10() +
    ggtitle('Total Emissions from Coal Sources by Year and Source') +
    xlab('Year Measured') +
    ylab('Fine Particulate Matter Emitted (tons) [log10 scale]')

dev.off()

