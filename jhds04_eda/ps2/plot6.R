# Load Data from Working Directory
NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')


# Subset and Reshape Data
ei_sector <- unique(SCC$EI.Sector)
mobile_sector <- ei_sector[grep('Mobile', ei_sector)]
SCC_mobile <- subset(SCC, EI.Sector %in% mobile_sector)
NEI_mobile <- merge(x = subset(NEI, fips %in% c('24510','06037')), by.x = 'SCC',
                    y = SCC_mobile, by.y = 'SCC')

master_fips <- data.frame(fips = c('24510','06037'),
                          city_name = c('Baltimore City, MD','Los Angeles County, CA'))
NEI_mobile <- merge(x = NEI_mobile, by.x = 'fips',
                    y = master_fips, by.y = 'fips')



library(reshape2)
NEI_melt <- melt(data = NEI_mobile,
                 id.vars = c('year','city_name'),
                 measure.vars = 'Emissions')
NEI_cast <- dcast(NEI_melt, year + city_name ~ variable, sum)


# Plot
library(ggplot2)

png(filename = 'plot6.png',
    width = 900,
    height = 600,
    units = 'px')

ggplot(data = NEI_cast, aes(x=year, y=Emissions)) +
    geom_line(aes(color = city_name), size=2) +
    geom_point(fill='black', size=3, shape=16) +
    scale_y_log10() +
    ggtitle('Total Emissions from Mobile Sources by Year') +
    xlab('Year Measured') +
    ylab('Fine Particulate Matter Emitted (tons) [log10 scale]')

dev.off()
