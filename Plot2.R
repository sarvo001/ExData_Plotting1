# clear workspace
rm(list=ls())

# set working dir to ExData_Plotting1 dir
########################################

# set file name
filename = "exdata_plot1.zip"

# download file and save it to wd
if (!file.exists(filename)) {
  retval = download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                         destfile = filename,
  )
}

# unzip file and read csv into dataframe
powerData = read.csv(unz(filename, "household_power_consumption.txt"), header=T,
                     sep=";", stringsAsFactors=F, na.strings="?",
                     colClasses=c("character", "character", "numeric",
                                  "numeric", "numeric", "numeric",
                                  "numeric", "numeric", "numeric"))


# set datetime format because of plo
powerData$timestamp = strptime(paste(powerData$Date, powerData$Time),
                              format="%d/%m/%Y %H:%M:%S", tz="UTC")
# start datetime
startDate = strptime("01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S", tz="UTC")
# end datetime
endDate = strptime("02/02/2007 23:59:59", format="%d/%m/%Y %H:%M:%S", tz="UTC")
# filer data with given datetimes
powerData = powerData[powerData$timestamp >= startDate & powerData$timestamp <= endDate, ]


# Creating the plot
png(filename="plot2.png", width=480, height=480)
plot(powerData$timestamp, powerData$Global_active_power, type="l", xlab="",
     ylab="Global Active Power (kilowatts)")
dev.off()
