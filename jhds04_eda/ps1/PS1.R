file_url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
temp <- tempfile()
download.file(file_url, temp)
hpc_full <- read.table(file = unz(temp,'household_power_consumption.txt'),
                       header = TRUE,
                       sep = ';',
                       quote = '',
                       na.strings = '?')
unlink(temp)




# http://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
# https://class.coursera.org/exdata-003/forum/thread?thread_id=14

hpc_full <- read.table(file = 'household_power_consumption.txt',
                       header = TRUE,
                       sep = ';',
                       quote = '',
                       na.strings = '?')
head(hpc_full)
names(hpc_full)

hpc_full$date_time <- strptime(x = paste(hpc_full$Date, hpc_full$Time, sep=' '),
                               format = '%d/%m/%Y %H:%M:%S',
                               tz = 'GMT')
head(hpc_full$date_time)
class(hpc_full$date_time)

hpc_full$Date <- as.Date(hpc_full$Date, format='%d/%m/%Y')
class(hpc_full$Date)
head(hpc_full$Date)

hpc <- subset(hpc_full, (hpc_full$Date >= '2007-02-01') & (hpc_full$Date <= '2007-02-02'))

# P1
png(filename = 'plot1.png',
    width = 480,
    height = 480,
    units = 'px')
hist(x = hpc$Global_active_power,
     col = 'red',
     main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)',
     ylab = 'Frequency')
dev.off()


# P2
png(filename = 'plot2.png',
    width = 480,
    height = 480,
    units = 'px')
plot(x = hpc$date_time,
     y = hpc$Global_active_power,
     type = 'l',
     xlab = '',
     ylab = 'Global Active Power (kilowatts)')
dev.off()


# P3
png(filename = 'plot3.png',
    width = 480,
    height = 480,
    units = 'px')
par(mfrow = c(1,1))
with(hpc, plot(x = date_time,
               y = Sub_metering_1,
               xlab = '',
               ylab = 'Energy sub metering',
               type = 'n'))
with(hpc, lines(x = date_time,
                y = Sub_metering_1,
                col = 'black'))
with(hpc, lines(x = date_time,
                y = Sub_metering_2,
                col = 'red'))
with(hpc, lines(x = date_time,
                y = Sub_metering_3,
                col = 'blue'))
legend('topright',
       lty = 1,
       y.intersp = 1,
       col = c('black','red','blue'),
       legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
dev.off()




# P4
png(filename = 'plot4.png',
    width = 480,
    height = 480,
    units = 'px')
par(mfrow = c(2,2), 
    mar = c(4,4,1,2),
    oma = c(0,0,0,0))

plot(x = hpc$date_time,
     y = hpc$Global_active_power,
     type = 'l',
     xlab = '',
     ylab = 'Global Active Power (kilowatts)')

plot(x = hpc$date_time,
     y = hpc$Voltage,
     type = 'l',
     xlab = 'datetime',
     ylab = 'Voltage')

with(hpc, plot(x = date_time,
               y = Sub_metering_1,
               xlab = '',
               ylab = 'Energy sub metering',
               type = 'n'))
with(hpc, lines(x = date_time,
                y = Sub_metering_1,
                col = 'black'))
with(hpc, lines(x = date_time,
                y = Sub_metering_2,
                col = 'red'))
with(hpc, lines(x = date_time,
                y = Sub_metering_3,
                col = 'blue'))
legend('topright',
       lty = 1,
       bty = 'n',
       y.intersp = 1,
       col = c('black','red','blue'),
       legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))

plot(x = hpc$date_time,
     y = hpc$Global_reactive_power,
     type = 'l',
     xlab = 'datetime',
     ylab = 'Global-reactive_power')
dev.off()























