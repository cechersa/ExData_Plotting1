## Download the file and unzip it
file.download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="household_power_consumption.zip",method="curl")
unzip("household_power_consumption.zip")

## Read file
z <- read.table("household_power_consumption.txt",sep=";")                ## Read file into z object
zcol <- z[1,]                                                             ## Take the column names from file into a vector
z <- read.table("household_power_consumption.txt",sep=";",col.names=zcol) ## Read file again with the rigth column names
z <- z[2:2075260,]                                                        ## Remove the row that contained the names originally
z$Date <- as.Date(z$Date,format="%d/%m/%Y")                               ## Convert date into Date format
zrows <- grep("2007-02-01|2007-02-02",z$Date)                             ## Take row numbers corresponding to 2007-02-01 and 2007-02-02
subz <- z[zrows,]                                                         ## Subset the table


## Plot 1
subz[,3] <- as.numeric(subz[,3])                                                                                              ## Convert the $Global_active_power into numeric
par(mar=c(4,4,2,1),mgp=c(1.8,0.6,0))                                                                                          ## Stablish margins to match the example
hist(subz$Global_active_power,main="Global Active Power", col="red",xlab="Global Active Power (kilowatts)",ylab="Frequency")  ## Plot a histogram of $Global_active_power
dev.copy(png,file="plot1.png", width = 480, height = 480)                                                                     ## Copy file into .png
dev.off()                                                                                                                     ## Close the device


## Plot 2
subz$weekday <- weekdays(subz$Date)                                                                 ## Add a column with the weekday corresponding to the date
unique(subz$weekday)                                                                                ## Check the weekdays
length(grep("Thursday",subz$weekday))                                                               ## Find how many data points belong to each weekday
plot(subz$Global_active_power,type="l", xlab= "", ylab="Global Active Power (kilowatts)",xaxt="n")  ## Plot $Global_active_power
axis(1,at=1, labels="Thu")                                                                          ## Fix X axis with weekday changing in corresponding data points
axis(1,at=1440, labels="Fri")
axis(1,at=2880, labels="Sat")
dev.copy(png,file="plot2.png", width = 480, height = 480)                                           ## Copy file into .png)                                                                      ## Copy file into .png
dev.off()                                                                                           ## Close the device


## Plot 3
plot(subz$Sub_metering_1,type="n", xlab= "", ylab="Energy sub metering",xaxt="n")                   ## Build an empty plot
lines(subz$Sub_metering_1)                                                                          ## Add the three $Sub_meetering data
lines(subz$Sub_metering_2,col="red")                                                                
lines(subz$Sub_metering_3,col="blue")
axis(1,at=1, labels="Thu")                                                                          ## Fix X axis with weekday changing in corresponding data points
axis(1,at=1440, labels="Fri")
axis(1,at=2880, labels="Sat")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1, y.intersp=0.5,x.intersp=0.5,text.width=650) ## Add a legend to corresponding line color
dev.copy(png,file="plot3.png", width = 480, height = 480)                                           ## Copy file into .png
dev.off()                                                                                           ## Close the device


## Plot 4
par(mfrow=c(2,2),cex=0.8,mgp=c(2.5,0.8,0))                                                          ## Stablish spacing and rows/columns to add multiple plots and match the example
plot(subz$Global_active_power,type="l", xlab= "", ylab="Global Active Power",xaxt="n")              ## Repeat plot2
axis(1,at=1, labels="Thu")
axis(1,at=1440, labels="Fri")
axis(1,at=2880, labels="Sat")
plot(subz$Voltage,type="l", xlab= "datetime", ylab="Voltage",xaxt="n")                              ## Plot $Voltage as plot2
axis(1,at=1, labels="Thu")
axis(1,at=1440, labels="Fri")
axis(1,at=2880, labels="Sat")
plot(subz$Sub_metering_1,type="n", xlab= "", ylab="Energy sub metering",xaxt="n")                   ## Repeat plot3
lines(subz$Sub_metering_1)
lines(subz$Sub_metering_2,col="red")
lines(subz$Sub_metering_3,col="blue")
axis(1,at=1, labels="Thu")
axis(1,at=1440, labels="Fri")
axis(1,at=2880, labels="Sat")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,bty="n",y.intersp=0.5,x.intersp=0.5,text.width=1200)
plot(subz$Global_reactive_power,type="l", xlab= "datetime", ylab="Global_reactive_power",xaxt="n")  ## Plot $Active_reactive_power as plot2
axis(1,at=1, labels="Thu")
axis(1,at=1440, labels="Fri")
axis(1,at=2880, labels="Sat")
dev.copy(png,file="plot4.png", width = 480, height = 480)                                           ## Copy file into .png
dev.off()                                                                                           ## Close the device