#' Visualization of the raw data
#'
#' @param x data frame of the raw data
#'
#' @return images of the raw data
#' @export
plotraw <- function(x){
  layout(matrix(c(1:10), 5, 2, byrow = FALSE),heights=c(1,1,1,1,1))
  par(cex = 1, mar = c(2,4,0.5,1)) #cex = 0.8,

  # pressure
  print(paste(Sys.time(), 'plotting P'))
  plot(x$TIMESTAMP, x[,'Pressure_Avg'], type='l', lwd=1.5, col='blue', ylab='Air Pressure')
  abline(h = seq(700, 1000, 50), col = 'grey')

  # Temperature
  print(paste(Sys.time(), 'plotting t'))
  mycol <- rainbow(length(colname_t))
  plot(x$TIMESTAMP, x[, colname_t[1]], col=mycol[1], ylab='T', type = 'p', pch = 20, cex = 0.5, ylim = lim_t, axes = FALSE)# type='l', lwd=1.5) #, ylim =c(-5, 25))
  axis(2)
  # axis.POSIXct(1, at = xat, labels = xlabels) # It worked before. But now it is not working.
  axis.POSIXct(1, x$TIMESTAMP, at = xat, labels = xlabels)
  box()
  abline(h = seq(-15, 30, 5), v = as.numeric(xat), col = 'grey')
  for (m in 2:length(colname_t)){
    points(x$TIMESTAMP, x[, colname_t[m]], col=mycol[m], ylab='T', type = 'p', pch = 20, cex = 0.5) #, type='l',lwd=1.5)
  }
  legend('topright', bty = 'n', col = mycol, legend = colname_t, lty = 1)

  # RH
  print(paste(Sys.time(), 'plotting RH'))
  mycol <- rainbow(length(colname_t))
  plot(x$TIMESTAMP, x[, colname_rh[1]], col=mycol[1], ylab='RH', type = 'p', pch = 20, cex = 0.5, ylim = lim_rh, axes = FALSE)# type='l', lwd=1.5) #, ylim =c(0, 110))
  axis(2)
  # axis.POSIXct(1, at = xat, labels = xlabels)
  axis.POSIXct(1, x$TIMESTAMP, at = xat, labels = xlabels)
  box()
  abline(h = seq(0,100,20), v = as.numeric(xat), col = 'grey')
  for (m in 1:length(colname_rh)){
    points(x$TIMESTAMP, x[, colname_rh[m]], col=mycol[m], type = 'p', pch = 20, cex = 0.5) #, type='l',lwd=1.5)
  }

  # wind speed
  print(paste(Sys.time(), 'plotting WS'))
  mycol <- rainbow(length(colname_ws))
  plot(x$TIMESTAMP, x[, colname_ws[1]], col = mycol[1], ylab='Wind Speed', pch = 20, cex = 0.5, type = 'p', ylim = lim_ws, axes = FALSE)# ,type='l' ) #, ylim = c(0, 6))
  axis(2)
  # axis.POSIXct(1, at = xat, labels = xlabels)
  axis.POSIXct(1, x$TIMESTAMP, at = xat, labels = xlabels)
  box()
  abline(h = seq(0, 20, 1), v = as.numeric(xat), col = 'grey')
  for (m in 2:length(colname_ws)){
    points(x$TIMESTAMP, x[, colname_ws[m]], cex = 0.5, type = 'p', pch = 20, col=mycol[m]) # type='l',
  }
  legend('topright', bty = 'n', col = mycol, legend = colname_wd, lty = 1)

  # wind direction
  print(paste(Sys.time(), 'plotting WD'))
  plot(x$TIMESTAMP, x[,colname_wd[1]], type='p', cex = 0.5, col = mycol[1], ylab='Wind dir', ylim = lim_wd, axes = FALSE) #c(0,360))
  axis(2)
  axis.POSIXct(1, x$TIMESTAMP, at = xat, labels = xlabels)
  # axis.POSIXct(1, at = xat, labels = xlabels)
  box()
  abline(h = seq(0, 360, 45), v = as.numeric(xat), col = 'grey')
  for (m in 2:length(colname_wd)){
    points(x$TIMESTAMP, x[, colname_wd[m]], type='p',cex = 0.5, col=mycol[m])
  }

  # valves
  print(paste(Sys.time(), 'plotting valves'))
  plot(x$TIMESTAMP, x$vFlushing, type='l', lwd=1, col='red', ylab='valve number', ylim = lim_valve, axes = FALSE)
  axis(2)
  # axis.POSIXct(1, at = xat, labels = xlabels)
  axis.POSIXct(1, x$TIMESTAMP, at = xat, labels = xlabels)
  box()
  abline(v = as.numeric(xat), col = 'grey')
  points(x$TIMESTAMP, x$vSampling, type='l',lwd=1,col='blue')
  legend('topright', bty = 'n', col = c('red', 'blue'), legend = c('flushing', 'sampling'), lty = 1)

  # flowrate
  print(paste(Sys.time(), 'plotting flow rate'))
  plot(x$TIMESTAMP, x$flowrate_m, type='l', lwd=1, col='red', ylab='flowrate', ylim = lim_flow, axes = FALSE)
  axis(2)
  # axis.POSIXct(1, at = xat, labels = xlabels)
  axis.POSIXct(1, x$TIMESTAMP, at = xat, labels = xlabels)
  box()
  abline(h = seq(0, 2, 0.5), v = as.numeric(xat), col = 'grey')
  points(x$TIMESTAMP, x$flowrate_f, type='l',lwd=1, col='blue')
  legend('topright', bty = 'n', col = c('red', 'blue'), legend = c('flushing', 'sampling'), lty = 1)

  # CO2
  print(paste(Sys.time(), 'plotting CO2'))
  plot(x$TIMESTAMP, x[,'irga_co2_Avg'], type = 'p', pch = 20, cex = 0.5, col='red', ylab='CO2', ylim = lim_co2, axes = FALSE) #, type='l', lwd=1, ylim = c(0, 900))
  axis(2)
  # axis.POSIXct(1, at = xat, labels = xlabels)
  axis.POSIXct(1, x$TIMESTAMP, at = xat, labels = xlabels)
  box()
  abline(v = as.numeric(xat), col = 'grey')
  box()

  # H2O
  print(paste(Sys.time(), 'plotting H2O'))
  plot(x$TIMESTAMP, x[,'irga_h2o_Avg'], type = 'p', pch = 20, cex = 0.5, col='blue', ylab='H2O', ylim = lim_h2o, axes = FALSE) #type='l', lwd=1.5,  ylim = c(0, 60))
  axis(2)
  # axis.POSIXct(1, at = xat, labels = xlabels)
  axis.POSIXct(1, x$TIMESTAMP, at = xat, labels = xlabels)
  box()
  abline(h = seq(0), v = as.numeric(xat), col = 'grey')

  # Title
  plot.new()
  text(x=0.5, y=0.5, paste('Advection\n', as.Date(d, origin = "1970-01-01"), sep = ''),cex=2.5)
  par(mar=c(5,9,4.6,3),cex.lab=3,cex.axis=3,cex.main=3,xpd=F)
}

#' Visualization of the temperature data separately
#'
#' @param x data frame of the raw data
#'
#' @return images of the raw temperature data in sub figures
#' @export
plotraw_t <- function(x, ...){
  layout(matrix(c(1:(ceiling((length(colname_t) + 1) /2) * 2)), ceiling((length(colname_t) + 1)/2), 2, byrow = FALSE))
  par(cex = 1, mar = c(2,4,0.5,1)) #cex = 0.8,
  mycol <- rainbow(length(colname_t))
  plot(x$TIMESTAMP, x[, colname_t[1]], col=mycol[1], ylab='T', type = 'p', pch = 20, cex = 0.5, ylim = lim_t, axes = FALSE)# type='l', lwd=1.5) #, ylim =c(-5, 25))
  axis(2)
  # axis.POSIXct(1, at = xat, labels = xlabels)
  axis.POSIXct(1, x$TIMESTAMP, at = xat, labels = xlabels)
  box()
  abline(h = seq(-15, 30, 5), v = as.numeric(xat), col = 'grey')
  for (m in 2:length(colname_t)){
    points(x$TIMESTAMP, x[, colname_t[m]], col=mycol[m], ylab='T', type = 'p', pch = 20, cex = 0.5) #, type='l',lwd=1.5)
  }
  for (m in 1:length(colname_t)){
    plot(x$TIMESTAMP, x[, colname_t[m]], col=mycol[m], ylab='T', type = 'p', pch = 20, cex = 0.5, ylim = lim_t, axes = FALSE)# type='l', lwd=1.5) #, ylim =c(-5, 25))
    axis(2)
    # axis.POSIXct(1, at = xat, labels = xlabels)
    axis.POSIXct(1, x$TIMESTAMP, at = xat, labels = xlabels)
    box()
    abline(h = seq(-15, 30, 5), v = as.numeric(xat), col = 'grey')
    legend('topright', bty = 'n', col = mycol[m], legend = colname_t[m], lty = 1)
  }
}

#' Visualization of the relative humidity data separately
#'
#' @param x data frame of the raw data
#'
#' @return images of the raw relative humidity data in sub figures
#' @export
plotraw_rh <- function(x, ...){
  layout(matrix(c(1:(ceiling((length(colname_rh) + 1)/2) * 2)), ceiling((length(colname_rh) + 1)/2), 2, byrow = FALSE))
  par(cex = 1, mar = c(2,4,0.5,1)) #cex = 0.8,
  mycol <- rainbow(length(colname_rh))

  plot(x$TIMESTAMP, x[, colname_rh[1]], col=mycol[1], ylab='RH', type = 'p', pch = 20, cex = 0.5, ylim = lim_rh, axes = FALSE)# type='l', lwd=1.5) #, ylim =c(-5, 25))
  axis(2)
  # axis.POSIXct(1, at = xat, labels = xlabels)
  axis.POSIXct(1, x$TIMESTAMP, at = xat, labels = xlabels)
  box()
  abline(h = seq(0,100,20), v = as.numeric(xat), col = 'grey')
  for (m in 2:length(colname_rh)){
    points(x$TIMESTAMP, x[, colname_rh[m]], col=mycol[m], ylab='T', type = 'p', pch = 20, cex = 0.5) #, type='l',lwd=1.5)
  }

  for (m in 1:length(colname_rh)){
    plot(x$TIMESTAMP, x[, colname_rh[m]], col=mycol[m], ylab='RH', type = 'p', pch = 20, cex = 0.5, ylim = lim_rh, axes = FALSE)# type='l', lwd=1.5) #, ylim =c(-5, 25))
    axis(2)
    # axis.POSIXct(1, at = xat, labels = xlabels)
    axis.POSIXct(1, x$TIMESTAMP, at = xat, labels = xlabels)
    box()
    abline(h = seq(0,100,20), v = as.numeric(xat), col = 'grey')
    legend('topright', bty = 'n', col = mycol[m], legend = colname_rh[m], lty = 1)
  }
}

#' Read and pre process the raw data
#'
#' @param path_raw the path of the raw data file
#' @param path_raw_header the path of header file for the raw data
#'
#' @return a data frame with pre processed raw data
#' @export
#'
#' @examples
#' if(!dir.exists('demo')) dir.create('demo')
#' download.file('https://github.com/pzhaonet/advr/raw/master/inst2/data.zip', 'demo/data.zip')
#' unzip(zipfile = 'demo/data.zip', exdir = 'demo')
#' adv_data <- read_adv('demo/data_sample.csv', 'demo/data_header.csv')
read_adv <- function(path_raw, path_raw_header){
  aa <- read.table(file = path_raw, header = FALSE, sep = ',', skip = 4, stringsAsFactors = FALSE, na.strings = c('NA', 'NaN', 'NAN'))
  header  <- read.table(file = path_raw_header, header = FALSE, sep = ',', stringsAsFactors = FALSE)
  colnames(aa) <- header[1,]
  aa$TIMESTAMP  <- strptime(aa$TIMESTAMP, '%Y-%m-%d %H:%M:%S', tz = 'GMT')
  aa$flowrate_m  <- aa$flowvolt_m_Avg/ 5000 * 2
  aa$flowrate_f  <- aa$flowvolt_f_Avg/ 5000 * 20
  aa$cdry <- aa$irga_co2_Avg / (1-aa$irga_h2o_Avg/1000)
  aa$wdry <- aa$irga_h2o_Avg / (1-aa$irga_h2o_Avg/1000)
  return(aa)
}

#' plot raw data in day, hour, or other length
#'
#' @param aa pre processed raw data frame
#' @param sub_by sub figure by n days
#' @param suffix for the file name of the image
#'
#' @return figures in day, hour, or other length
#' @export
plot_adv <- function(aa, sub_by = 1, suffix = 'daily'){
  if(!dir.exists('output')) dir.create('output')
  if(is.na(sub_by)) {
    sub_by <- as.numeric(diff(date_range)) + 1 # the whole dataset
    suffix <- 'all'
  }

  ###### settings
  lim_t <- range(aa[, colname_t], na.rm = TRUE)
  colname_rh <- c(paste('hcRH_Avg(', 1:8, ')', sep = ''))
  lim_rh <- range(aa[, colname_rh], na.rm = TRUE)
  lim_ws <- range(aa[, colname_ws], na.rm = TRUE)
  lim_wd <- range(aa[, colname_wd], na.rm = TRUE)
  lim_valve <- range(aa[, c('vFlushing', 'vSampling')], na.rm = TRUE)
  lim_flow <- range(aa[, c('flowrate_m', 'flowrate_f')], na.rm = TRUE)
  lim_co2 <- range(aa$irga_co2_Avg, na.rm = TRUE)
  lim_h2o <- range(aa$irga_h2o_Avg, na.rm = TRUE)

  date_range <- as.Date(range(aa$TIMESTAMP)) # the entire range to plot

    ###### start plot
  for (d in seq(from = date_range[1], to = date_range[2], by = sub_by)){
    ### settings of the subplot
    myxlim <- as.numeric(strptime(as.Date(c(d, d + sub_by), origin = "1970-01-01"), format = '%Y-%m-%d', tz ='GMT'))
    xat <- NULL
    xlabels <- TRUE
    if (sub_by <= 1) {
      xat <- strptime(paste(strptime(as.Date(d, origin = "1970-01-01"), format = '%Y-%m-%d', tz ='GMT'), seq(0, 24, 6)), format = '%Y-%m-%d %H', tz ='GMT')
      xlabels <- format(xat, format = '%H:%M', tz = 'GMT')
    }
    if (sub_by > 1 & sub_by <= 7) {
      xat <- strptime(paste(strptime(as.Date(rep(seq(d, by = 1, length.out = sub_by + 1), each = 2), origin = "1970-01-01"), format = '%Y-%m-%d', tz ='GMT'), c(0)), format = '%Y-%m-%d %H', tz ='GMT')
      xlabels <- format(xat, format = '%m-%d %H:%M', tz = 'GMT')
    }
    ### prepare sub dataset to plot
    x <- aa[as.Date(aa$TIMESTAMP) >= d & as.Date(aa$TIMESTAMP) < d + sub_by, ]

    if (nrow(x) > 0){
      ### plot all in one
      print(paste(Sys.time(), as.Date(d, origin = "1970-01-01"), 'plotting all in one'))
      png(file = paste('./output/', suffix, '_adv_', as.Date(d, origin = "1970-01-01"), '.png', sep = ''), width = 1920, height = 1080)
      plotraw(x)
      dev.off()

      ### plot t
      print(paste(Sys.time(), as.Date(d, origin = "1970-01-01"), 'plotting t individually'))
      png(file = paste('./output/', suffix, '_adv_t_', as.Date(d, origin = "1970-01-01"), '.png', sep = ''), width = 1920, height = 1080)
      plotraw_t(x)
      dev.off()

      ### plot rh
      print(paste(Sys.time(), as.Date(d, origin = "1970-01-01"), 'plotting RH individually'))
      png(file = paste('./output/', suffix, '_adv_rh_', as.Date(d, origin = "1970-01-01"), '.png', sep = ''), width = 1920, height = 1080)
      plotraw_rh(x)
      dev.off()
    }
  }
}

#' Download the logger program
#'
#' @return a .CR1 program file
#' @export
#'
#' @examples
#' get_logger()
get_logger <- function(){
 download.file('https://github.com/pzhaonet/advr/raw/master/inst2/logger.CR1', 'logger.CR1')
}

#' Download an Arduino program file
#'
#' @return an .ino file
#' @export
#'
#' @examples
#' get_arduino()
get_arduino <- function(){
  download.file('https://github.com/pzhaonet/advr/raw/master/inst2/arduino.ino', 'arduino.ino')
}
