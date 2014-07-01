# API
# Tutorial Link: https://github.com/hadley/httr/blob/master/demo/oauth2-github.r

# install.packages('jsonlite')
# install.packages('httr')
library(jsonlite, httr)

json_data <- fromJSON('https://api.github.com/users/jtleek/repos')
names(json_data)
head(json_data)
json_data$created_at
head(json_data$name[json_data$name == 'datasharing'])
json_data$created_at[json_data$name == 'datasharing']



# SQLDF
# install.packages('sqldf')
library(sqldf)
file_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv'
acs <- read.csv('./data/data_acs_q2.csv')

sqldf("select pwgtp1 from acs")
sqldf("select * from acs where AGEP < 50")
sqldf("select * from acs where AGEP < 50 and pwgtp1")
sqldf("select pwgtp1 from acs where AGEP < 50")


unique(acs$AGEP)

sqldf("select AGEP where unique from acs")
sqldf("select distinct AGEP from acs")
sqldf("select unique * from acs")
sqldf("select unique AGEP from acs")


# HTML
con <- url('http://biostat.jhsph.edu/~jleek/contact.html')
html_data <- readLines(con)
head(html_data)
html_data[10]

nchar(html_data[10])
nchar(html_data[20])
nchar(html_data[30])
nchar(html_data[100])


#.FOR Data, Fixed Width
noaa <- read.fwf(file = './data/data_q2.for',
                 widths = c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4),
                 col.names = c('week','n12_sst','n12_ssta','n3_sst','n3_ssta',
                               'n34_sst','n34_ssta','n4_sst','n4_ssta'),
                 skip = 4,
                 header = FALSE)
head(noaa)
sum(noaa$n3_sst)

sum(noaa$n12_sst)
sum(noaa$n12_ssta)
sum(noaa$n3_sst)
sum(noaa$n3_ssta)
sum(noaa$n34_sst)
sum(noaa$n34_ssta)
sum(noaa$n4_sst)
sum(noaa$n4_ssta)




