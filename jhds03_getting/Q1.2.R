file_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(url=file_url, destfile='data_acs_housing.csv')
acs <- read.table('data_acs_housing.csv', sep=',', header=TRUE)
head(acs$VAL)
table(acs$VAL)

install.packages('xlsx')
install.packages('rJava')
library(rJava)
library(xlsx)
# file_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx'
# download.file(url=file_url, destfile='data_natgas.xlsx')
col_index <- 7:15
row_index <- 18:23
dat <- read.xlsx('data_natgas2.xlsx', sheetIndex=1, colIndex=col_index, rowIndex=row_index)
sum(dat$Zip*dat$Ext,na.rm=T)

library(XML)
file_url <- 'http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'
doc <- xmlTreeParse(file_url, useInternal=TRUE)
root_node <- xmlRoot(doc)
xmlName(root_node)
names(root_node)
zipcodes <- xpathSApply(root_node,'//zipcode', xmlValue)

head(zipcodes)
zipcodes[zipcodes == '21231']
summary(zipcodes[zipcodes == '21231'])

# install.packages('data.table')
library(data.table)
file_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv'
download.file(url=file_url, destfile='data_acs_housing_idaho.csv')
idaho <- read.table('data_acs_housing_idaho.csv', sep=',', header=TRUE)
DT <- fread('data_acs_housing_idaho.csv')
class(DT$pwgtp15)
mean(DT$pwgtp15)

rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
mean(DT$pwgtp15,by=DT$SEX)
tapply(DT$pwgtp15,DT$SEX,mean)
sapply(split(DT$pwgtp15,DT$SEX),mean)
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
DT[,mean(pwgtp15),by=SEX]

# system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]})
# system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})
system.time(DT[,mean(pwgtp15),by=SEX])


























