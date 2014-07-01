NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')



# Scratch Plot 4
names(SCC)
summary(SCC$Data.Category)
table(SCC$EI.Sector)
ei_sector <- unique(SCC$EI.Sector)
length(ei_sector)
write.csv(ei_sector, 'ei_sector.txt')
coal_sector <- ei_sector[intersect(grep('Coal', ei_sector), grep('Fuel Comb', ei_sector))]
SCC_coal <- subset(SCC, EI.Sector %in% coal_sector)
NEI_coal <- merge(x = NEI, by.x = 'SCC',
                  y = SCC_coal, by.y = 'SCC')
unique(NEI_coal$EI.Sector)


# Scratch Plot 5
ei_sector <- unique(SCC$EI.Sector)
mobile_sector <- ei_sector[grep('Mobile', ei_sector)]
mobile_sector <- ei_sector[intersect(grep('Mobile', ei_sector), 
                                     grep('Non-Road', ei_sector, invert=TRUE))]

mobile_sector <- ei_sector[setdiff(grep('Mobile', ei_sector),
                                   grep('Non-Road', ei_sector))]

unique(mobile_sector)




SCC_mobile <- subset(SCC, EI.Sector %in% mobile_sector)
NEI_mobile <- merge(x = subset(NEI, fips == '24510'), by.x = 'SCC',
                    y = SCC_mobile, by.y = 'SCC')
unique(NEI_mobile$EI.Sector)










head(subset(NEI, fips == '24510'))


# PNG Memo
png(filename = 'plot1.png',
    width = 480,
    height = 480,
    units = 'px')

# PLOT

dev.off()
