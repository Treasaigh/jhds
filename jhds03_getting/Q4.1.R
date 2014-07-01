file_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
acs <- read.csv(url(file_url))

split_names <- strsplit(names(acs), 'wgtp')
split_names[[123]]


library(stringr)
url_gdp <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
gdp <- read.csv(url(url_gdp), skip=4, nrows=190,
                col.names = c('country','rank','u1','economy','usd_MM',
                              'u2','u3','u4','u5','u6'))

gdp$usd_MM_int <- gsub(pattern = ',',
                       replacement = '',
                       x = str_trim(gdp$usd_MM))
gdp$usd_MM_int <- as.integer(gdp$usd_MM_int)
head(gdp$usd_MM_int)
summary(gdp$usd_MM_int)
mean(gdp$usd_MM_int)

countryNames <- gdp$economy
grep("United$",countryNames)
grep("*United",countryNames)
grep("*United",countryNames)
grep("^United",countryNames)



url_gdp <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
url_ed <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
gdp <- read.csv(url(url_gdp), skip=4, nrows=190,
                col.names = c('country','rank','u1','economy','usd_MM',
                              'u2','u3','u4','u5','u6'))
ed <- read.csv(url(url_ed))
merged_data <- merge(x = gdp, by.x = 'country',
                     y = ed, by.y = 'CountryCode')
names(merged_data)
grep('[Ff]iscal',names(merged_data))
grep('[L]atest',names(merged_data))
grep('ABW',merged_data)
grep('United', merged_data$Long.Name)
merged_data$Long.Name[grep('United', merged_data$Long.Name)]

kw_fiscal <- grep('[Ff]iscal', merged_data$Special.Notes)
kw_june <- grep('[Jj]une', merged_data$Special.Notes)
length(kw_june)
kw_intersect <- intersect(kw_fiscal, kw_june)
length(kw_intersect)
merged_data$Special.Notes[kw_june]


# install.packages('quantmod')
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
class(sampleTimes)
head(sampleTimes)
str(sampleTimes)
str(amzn)
head(amzn)
head(amzn['2012'])
amzn_2012 <- amzn['2012']
length(amzn_2012$AMZN.Open)
length(amzn_2012$AMZN.Open[.indexwday(amzn_2012) == 0])










