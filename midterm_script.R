library(readr)
library(plyr)
library(stringr)
library(dplyr)
library(lubridate)

#read in the csv
eggs<- read_csv("~/Desktop/midterm/data/erdCalCOFIcufes_bb4a_5c83_ad3a.csv")
zoop <- read_csv("~/Desktop/midterm/data/195101-201404_Zoop.csv")

#using the "lapply" function from the "dplyr" package, remove fields which contain all "NA" values
zoop <- zoop[,which(unlist(lapply(zoop, function(x)!all(is.na(x)))))] 

###convert time to an ARC GIS format 
##YYYY-MM-DD hh:mm:ss
### x is already in the proper format

##zoop is not even close

#create new fields with decimal degree latitude and longitude values
#combine deg and min column together sep by space

zoop$Lat_mindec<- zoop$Lat_Min/60
zoop$Lat_Deg<-as.numeric(zoop$Lat_Deg)
zoop$Lat_DecDeg<- zoop$Lat_mindec + zoop$Lat_Deg

zoop$Lon_mindec<- zoop$Lon_Min/60
zoop$Lon_Deg<-as.numeric(zoop$Lon_Deg)
zoop$Lon_DecDeg<- (zoop$Lon_mindec + zoop$Lon_Deg)*-1
  
# create a date-time field
zoop$dateTime <- str_c(zoop$Tow_Date," ",zoop$Tow_Time,":00")

zoop$tow_date <- NULL
zoop$tow_time <- NULL



##egg data set seems to be in working order to begin with
##adding a year column 
eggs$time_UTC <- gsub(x = eggs$time_UTC, pattern = "T", replacement = " ")

eggs <- eggs[,c(1:4,5:26)]

#export data
write.table(zoop, "zoop.txt", sep = "\t", row.names = FALSE)
write.table(eggs, "eggs.txt", sep = "\t", row.names = FALSE)



