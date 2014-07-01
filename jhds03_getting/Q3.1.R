file_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
acs <- read.csv(url(file_url))

head((acs$ACR == 3) & (acs$AGS == 6))

agriculture_logical <- ((acs$ACR == 3) & (acs$AGS == 6))
head(agriculture_logical)
which(agriculture_logical)


# install.packages('jpeg')
library(jpeg)
file_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
download.file(url=file_url, destfile='./data/data_q3_image.jpg')
img <- readJPEG('./data/data_q3_image2.jpg', native = TRUE)
quantile(x=img, probs=c(0.3,0.8))

library(plyr)
url_gdp <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
url_ed <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
gdp <- read.csv(url(url_gdp), skip=4, nrows=190,
                col.names = c('country','rank','u1','economy','usd_MM',
                              'u2','u3','u4','u5','u6'))
ed <- read.csv(url(url_ed))

names(gdp)
names(ed)
head(gdp$economy)
tail(gdp$economy)

merged_data <- merge(x = gdp, by.x = 'country',
                     y = ed, by.y = 'CountryCode')
length(intersect(gdp$country, ed$CountryCode))

# merged_data[order(merged_data$rank),]
md_sorted <- arrange(merged_data,desc(merged_data$rank))
md_
head(md_sorted$rank)
md_sorted[13,'economy']


levels(merged_data$Income.Group)
mean(merged_data$rank[merged_data$Income.Group == 'High income: OECD'])
mean(merged_data$rank[merged_data$Income.Group == 'High income: nonOECD'])
by(merged_data$rank, merged_data$Income.Group, mean)


merged_data$bins <- cut(merged_data$rank, breaks = 5)
table(merged_data$bins)
table(merged_data$bins, merged_data$Income.Group)
subset(merged_data, bins == '(0.811,38.8]')


















