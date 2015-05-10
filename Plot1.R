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


# set Dateformat
powerData$Date = as.Date(powerData$Date, format="%d/%m/%Y")

# define start and end date because of filter
startDate = as.Date("01/02/2007", format="%d/%m/%Y")
endDate = as.Date("02/02/2007", format="%d/%m/%Y")

# filter data with given dates
powerData = powerData[powerData$Date >= startDate & powerData$Date <= endDate, ]


# Creating the plot
png(filename="plot1.png", width=480, height=480)
hist(powerData$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red")
dev.off()

