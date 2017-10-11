library(readr)
library(plyr)

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
  z$dateTime <- str_c(z$tow_date," ",z$tow_time,":00")
z$dateTime <- as.POSIXct(strptime(z$dateTime, tz = "America/Los_Angeles")) #Hint: look up input time formats for the 'strptime' function
z$tow_date <- NULL; z$tow_time <- NULL



