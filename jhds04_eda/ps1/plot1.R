# Make connection to URL, download, unzip, and load into dataframe
file_url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
temp <- tempfile()
download.file(file_url, temp)
hpc_full <- read.table(file = unz(temp,'household_power_consumption.txt'),
                       header = TRUE,
                       sep = ';',
                       quote = '',
                       na.strings = '?')
unlink(temp)

# Convert date and time strings into single datetime column
hpc_full$date_time <- strptime(x = paste(hpc_full$Date, hpc_full$Time, sep=' '),
                               format = '%d/%m/%Y %H:%M:%S',
                               tz = 'GMT')
hpc_full$Date <- as.Date(hpc_full$Date, format='%d/%m/%Y')  # convert date as well to slice
hpc <- subset(hpc_full, (hpc_full$Date >= '2007-02-01') & (hpc_full$Date <= '2007-02-02'))  # subset based on date

# Build plot
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

