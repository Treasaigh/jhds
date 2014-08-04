library(ggplot2)
library(reshape2)
storm <- read.csv(file = bzfile('repdata-data-StormData.csv.bz2'),
                  header = TRUE,
                  na.strings = 'NA')
storm$BGN_DATE <- as.Date(storm$BGN_DATE, '%m/%d/%Y')
storm$END_DATE <- as.Date(storm$END_DATE, '%m/%d/%Y')
storm$YEAR <- as.POSIXlt(storm$BGN_DATE)$year + 1900

head(storm)
names(storm)
unique(storm$EVTYPE)
table(storm$EVTYPE)
table(storm$EVTYPE, storm$INJURIES)
table(storm$EVTYPE, storm$FATALITIES)

head(storm$BGN_DATE)
table(storm$YEAR)

# Top n by event frequency
freq <- as.data.frame(table(storm$EVTYPE))
names(freq) <- c('EVTYPE','COUNT')
freq <- freq[order(freq$COUNT, decreasing = TRUE),]
freq_sel <- freq[1:8,'EVTYPE']
# subset(agg_year, EVTYPE %in% freq_sel)


# Event - Population
# agg_event <- data.frame(EVTYPE = sort(unique(storm$EVTYPE)))
agg_event <- data.frame(EVTYPE = freq_sel)
agg_event <- merge(agg_event, (aggregate(INJURIES ~ EVTYPE, data = storm, FUN = 'sum')))
agg_event <- merge(agg_event, (aggregate(FATALITIES ~ EVTYPE, data = storm, FUN = 'sum')))
melt_event <- melt(data = agg_event, id.vars = c('EVTYPE'))

ggplot(data = melt_event, aes(x = EVTYPE)) +
    geom_bar(aes(y = value, fill = variable), stat = 'identity') +
    ggtitle('Total Injuries and Fatalities by Event Type') +
    xlab('Event') +
    ylab('Number of Injuries/Fatalities')


# Event - Economic
summary(storm$PROPDMG)
summary(storm$PROPDMGEXP)

#agg_econ <- data.frame(EVTYPE = sort(unique(storm$EVTYPE)))
agg_econ <- data.frame(EVTYPE = freq_sel)
agg_econ <- merge(agg_econ, (aggregate(PROPDMG ~ EVTYPE, data = storm, FUN = 'sum')))
agg_econ <- merge(agg_econ, (aggregate(CROPDMG ~ EVTYPE, data = storm, FUN = 'sum')))
names(agg_econ) <- c('EVTYPE','PropertyDamage','CropDamage')
melt_econ <- melt(data = agg_econ, id.vars = c('EVTYPE'))

ggplot(data = melt_econ, aes(x = EVTYPE)) +
    geom_bar(aes(y = value, fill = variable), stat = 'identity') +
    ggtitle('Total Economic Damages by Event Type') +
    xlab('Event') +
    ylab('Value of Economic Damage')



# Year
agg_year <- as.data.frame(table(storm$YEAR, storm$EVTYPE))
names(agg_year) <- c('YEAR','EVTYPE','VALUE')
agg_year <- subset(agg_year, EVTYPE %in% freq_sel)
agg_year$YEAR <- as.numeric(levels(agg_year$YEAR))

ggplot(data = agg_year, aes(x = YEAR)) +
    geom_line(aes(y = VALUE, color = EVTYPE), size = 1.3) +
    ggtitle('Number of Recorded Incidents per Year') +
    xlab('Events Recorded') +
    ylab('Year')









agg_year <- merge(agg_year,(aggregate(FATALITIES ~ YEAR, data = storm, FUN = 'sum')))
melt_year <- melt(data = agg_year, id.vars = c('YEAR'))

ggplot(data = melt_year, aes(x = YEAR)) +
    geom_line(aes(y = value, color = variable), size = 1.0) +
    geom_smooth(aes(y = value, color = variable), size = 1.5, method = 'loess', linetype = 2) +
    ggtitle('Injuries and Fatalities by Year') +
    xlab('Year') +
    ylab('Incidents per Year')



















