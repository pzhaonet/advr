#' Read and pre process the raw data
#'
#' @param path_raw A character string with the path of the raw data file.
#' @param path_raw_header A character string with path of header file for the raw data.
#'
#' @return A data frame with pre-processed raw data
#' @export
#'
#' @examples
#' get_data('demo')
#' adv_data <- read_adv(path_raw = 'demo/data_sample.csv',
#'                      path_raw_header ='demo/data_header.csv')
read_adv <- function(path_raw, path_raw_header){
  aa <- read.table(file = path_raw,
                   header = FALSE,
                   sep = ',',
                   skip = 4,
                   stringsAsFactors = FALSE,
                   na.strings = c('NA', 'NaN', 'NAN'))
  header  <- read.table(file = path_raw_header,
                        header = FALSE,
                        sep = ',',
                        stringsAsFactors = FALSE)
  colnames(aa) <- header[1,]
  # convert the time stamp of the data records
  aa$TIMESTAMP  <- strptime(aa$TIMESTAMP,
                            '%Y-%m-%d %H:%M:%S',
                            tz = 'GMT')
  # calcualte the flow rate of the measurment air.
  aa$flowrate_m  <- aa$flowvolt_m_Avg/ 5000 * 2
  # calcualte the flow rate of the flushing air.
  aa$flowrate_f  <- aa$flowvolt_f_Avg/ 5000 * 20
  # convert the co2 mixing ratio into dry mixing ratio
  aa$cdry <- aa$irga_co2_Avg / (1-aa$irga_h2o_Avg/1000)
  # convert the h2o mixing ratio into dry mixing ratio
  aa$wdry <- aa$irga_h2o_Avg / (1-aa$irga_h2o_Avg/1000)
  return(aa)
}

#' plot raw data in day, hour, or other length
#'
#' @param aa A data frame with pre-processed raw data
#' @param sub_by A integer or NA indicating that the sub-figures are plotted by n days. if sub_by == NA, then plot the entire data set.
#' @param suffix A character string with the file name of the image
#'
#' @return Figures in day, hour, or other length.
#' @export
plot_adv <- function(aa, sub_by = 1, suffix = 'daily'){
  # A function to plot the raw data
  plotraw <- function(x){
    layout(matrix(c(1:10), 5, 2, byrow = FALSE),
           heights=c(1, 1, 1, 1, 1))
    par(cex = 1, mar = c(2,4,0.5,1)) #cex = 0.8,

    # plot the air pressure
    print(paste(Sys.time(), 'plotting P'))
    plot(x = x$TIMESTAMP, y = x[,'Pressure_Avg'],
         type='l', lwd = 1.5, col='blue',
         ylab='Air Pressure')
    abline(h = seq(700, 1000, 50), col = 'grey')

    # plot the air temperature
    print(paste(Sys.time(), 'plotting t'))
    mycol <- rainbow(length(colname_t))
    plot(x = x$TIMESTAMP, y = x[, colname_t[1]],
         col = mycol[1], type = 'p', pch = 20, cex = 0.5,
         ylab='T', ylim = lim_t,
         axes = FALSE)
    axis(2)
    axis.POSIXct(1, x$TIMESTAMP,
                 at = xat, labels = xlabels)
    box()
    abline(h = seq(-15, 30, 5),
           v = as.numeric(xat), col = 'grey')
    for (m in 2:length(colname_t)){
      points(x = x$TIMESTAMP, y = x[, colname_t[m]],
             col = mycol[m], type = 'p',
             pch = 20, cex = 0.5,
             ylab='T')
    }
    legend('topright', bty = 'n', col = mycol,
           legend = colname_t, lty = 1)

    # plot the relative humidity
    print(paste(Sys.time(), 'plotting RH'))
    mycol <- rainbow(length(colname_t))
    plot(x$TIMESTAMP, x[, colname_rh[1]], col = mycol[1],
         type = 'p', pch = 20, cex = 0.5,
         ylab='RH', ylim = lim_rh, axes = FALSE)
    axis(2)
    axis.POSIXct(1, x$TIMESTAMP,
                 at = xat, labels = xlabels)
    box()
    abline(h = seq(0, 100, 20),
           v = as.numeric(xat),
           col = 'grey')
    for (m in 1:length(colname_rh)){
      points(x = x$TIMESTAMP, y = x[, colname_rh[m]],
             col=mycol[m], type = 'p', pch = 20, cex = 0.5)
    }

    # plot the wind speed
    print(paste(Sys.time(), 'plotting WS'))
    mycol <- rainbow(length(colname_ws))
    plot(x = x$TIMESTAMP, y = x[, colname_ws[1]],
         col = mycol[1], pch = 20, cex = 0.5, type = 'p',
         ylab='Wind Speed', ylim = lim_ws, axes = FALSE)
    axis(2)
    axis.POSIXct(1, x$TIMESTAMP,
                 at = xat, labels = xlabels)
    box()
    abline(h = seq(0, 20, 1),
           v = as.numeric(xat),
           col = 'grey')
    for (m in 2:length(colname_ws)){
      points(x = x$TIMESTAMP,
             y = x[, colname_ws[m]],
             cex = 0.5, type = 'p', pch = 20, col = mycol[m])
    }
    legend('topright', bty = 'n', col = mycol,
           legend = colname_wd, lty = 1)

    # plot the wind direction
    print(paste(Sys.time(), 'plotting WD'))
    plot(x = x$TIMESTAMP, y = x[,colname_wd[1]],
         type = 'p', cex = 0.5, col = mycol[1],
         ylab = 'Wind dir', ylim = lim_wd, axes = FALSE)
    axis(2)
    axis.POSIXct(1, x$TIMESTAMP, at = xat, labels = xlabels)
    box()
    abline(h = seq(0, 360, 45),
           v = as.numeric(xat),
           col = 'grey')
    for (m in 2:length(colname_wd)){
      points(x = x$TIMESTAMP, y = x[, colname_wd[m]],
             type = 'p',cex = 0.5, col = mycol[m])
    }

    # plot the valve status
    print(paste(Sys.time(), 'plotting valves'))
    plot(x = x$TIMESTAMP, y = x$vFlushing,
         type = 'l', lwd = 1, col = 'red',
         ylab = 'valve number', ylim = lim_valve,
         axes = FALSE)
    axis(2)
    axis.POSIXct(1, x$TIMESTAMP,
                 at = xat, labels = xlabels)
    box()
    abline(v = as.numeric(xat), col = 'grey')
    points(x = x$TIMESTAMP, y = x$vSampling,
           type = 'l', lwd = 1, col = 'blue')
    legend('topright', bty = 'n', col = c('red', 'blue'),
           legend = c('flushing', 'sampling'), lty = 1)

    # plot the flowrates
    print(paste(Sys.time(), 'plotting flow rate'))
    plot(x = x$TIMESTAMP, y = x$flowrate_m,
         type = 'l', lwd = 1, col = 'red',
         ylab = 'flowrate', ylim = lim_flow, axes = FALSE)
    axis(2)
    axis.POSIXct(1, x$TIMESTAMP, at = xat, labels = xlabels)
    box()
    abline(h = seq(0, 2, 0.5),
           v = as.numeric(xat),
           col = 'grey')
    points(x = x$TIMESTAMP, y = x$flowrate_f,
           type = 'l', lwd = 1, col = 'blue')
    legend('topright', bty = 'n', col = c('red', 'blue'),
           legend = c('flushing', 'sampling'), lty = 1)

    # plot the CO2 mixing ratio
    print(paste(Sys.time(), 'plotting CO2'))
    plot(x = x$TIMESTAMP, y = x[,'irga_co2_Avg'],
         type = 'p', pch = 20, cex = 0.5, col='red',
         ylab='CO2', ylim = lim_co2, axes = FALSE)
    axis(2)
    axis.POSIXct(1, x$TIMESTAMP,
                 at = xat, labels = xlabels)
    box()
    abline(v = as.numeric(xat), col = 'grey')
    box()

    # plot the H2O mixing ratio
    print(paste(Sys.time(), 'plotting H2O'))
    plot(x = x$TIMESTAMP, y = x[,'irga_h2o_Avg'],
         type = 'p', pch = 20, cex = 0.5, col = 'blue',
         ylab ='H2O', ylim = lim_h2o, axes = FALSE)
    axis(2)
    axis.POSIXct(1, x$TIMESTAMP,
                 at = xat, labels = xlabels)
    box()
    abline(h = seq(0),
           v = as.numeric(xat),
           col = 'grey')

    # disply the title of the figure
    plot.new()
    text(x = 0.5, y = 0.5, cex = 2.5,
         paste0('Advection\n',
               as.Date(d, origin = "1970-01-01"))
         )
    par(mar = c(5, 9, 4.6, 3), xpd = F,
        cex.lab = 3, cex.axis = 3, cex.main = 3)
  }

  # a function to plot the air temperature. each figure for a single sensor
  plotraw_t <- function(x){
    layout(matrix(c(1:(ceiling((length(colname_t) + 1) /2) * 2)),
                  ceiling((length(colname_t) + 1)/2),
                  2, byrow = FALSE))
    par(cex = 1, mar = c(2, 4, 0.5, 1))
    mycol <- rainbow(length(colname_t))
    plot(x = x$TIMESTAMP, y = x[, colname_t[1]],
         col = mycol[1], type = 'p', pch = 20, cex = 0.5,
         ylab = 'T', ylim = lim_t, axes = FALSE)
    axis(2)
    axis.POSIXct(1, x$TIMESTAMP,
                 at = xat, labels = xlabels)
    box()
    abline(h = seq(-15, 30, 5),
           v = as.numeric(xat), col = 'grey')
    for (m in 2:length(colname_t)){
      points(x = x$TIMESTAMP, y = x[, colname_t[m]],
             col = mycol[m], ylab='T',
             type = 'p', pch = 20, cex = 0.5)
    }
    for (m in 1:length(colname_t)){
      plot(x = x$TIMESTAMP, y = x[, colname_t[m]],
           col=mycol[m], type = 'p', pch = 20, cex = 0.5,
           ylab='T', ylim = lim_t, axes = FALSE)
      axis(2)
      axis.POSIXct(1, x$TIMESTAMP,
                   at = xat, labels = xlabels)
      box()
      abline(h = seq(-15, 30, 5),
             v = as.numeric(xat),
             col = 'grey')
      legend('topright', bty = 'n', col = mycol[m],
             legend = colname_t[m], lty = 1)
    }
  }

  # a function to plot the air relative humidity. each figure for a single sensor
  plotraw_rh <- function(x){
    layout(matrix(c(1:(ceiling((length(colname_rh) + 1)/2) * 2)),
                  ceiling((length(colname_rh) + 1)/2),
                  2, byrow = FALSE))
    par(cex = 1, mar = c(2, 4, 0.5, 1))
    mycol <- rainbow(length(colname_rh))
    plot(x = x$TIMESTAMP, y = x[, colname_rh[1]],
         col = mycol[1], type = 'p', pch = 20, cex = 0.5,
         ylab ='RH', ylim = lim_rh, axes = FALSE)
    axis(2)
    axis.POSIXct(1, x$TIMESTAMP, at = xat, labels = xlabels)
    box()
    abline(h = seq(0,100,20),
           v = as.numeric(xat),
           col = 'grey')
    for (m in 2:length(colname_rh)){
      points(x = x$TIMESTAMP, y = x[, colname_rh[m]],
             col = mycol[m], ylab = 'T',
             type = 'p', pch = 20, cex = 0.5)
    }

    for (m in 1:length(colname_rh)){
      plot(x = x$TIMESTAMP, y = x[, colname_rh[m]],
           col = mycol[m], type = 'p', pch = 20, cex = 0.5,
           ylab = 'RH', ylim = lim_rh, axes = FALSE)
      axis(2)
      axis.POSIXct(1, x$TIMESTAMP,
                   at = xat, labels = xlabels)
      box()
      abline(h = seq(0,100,20),
             v = as.numeric(xat),
             col = 'grey')
      legend('topright', bty = 'n', col = mycol[m],
             legend = colname_rh[m], lty = 1)
    }
  }

  # configureation of the axis limits
  # temperature
  lim_t <- range(aa[, colname_t], na.rm = TRUE)
  # humidity
  colname_rh <- c(paste('hcRH_Avg(', 1:8, ')', sep = ''))
  lim_rh <- range(aa[, colname_rh], na.rm = TRUE)
  # wind speed
  lim_ws <- range(aa[, colname_ws], na.rm = TRUE)
  # wind direction
  lim_wd <- range(aa[, colname_wd], na.rm = TRUE)
  # valve codes
  lim_valve <- range(aa[, c('vFlushing', 'vSampling')], na.rm = TRUE)
  # flow rates
  lim_flow <- range(aa[, c('flowrate_m', 'flowrate_f')], na.rm = TRUE)
  # co2 mixing ratio
  lim_co2 <- range(aa$irga_co2_Avg, na.rm = TRUE)
  # h2o mixing ratio
  lim_h2o <- range(aa$irga_h2o_Avg, na.rm = TRUE)

  # the entire date range to plot
  date_range <- as.Date(range(aa$TIMESTAMP))

  if(!dir.exists('output')) dir.create('output')
  if(is.na(sub_by)) {
    sub_by <- as.numeric(diff(date_range)) + 1 # the entire dataset
    suffix <- 'all'
  }

  ###### start plot
  for (d in seq(from = date_range[1],
                to = date_range[2],
                by = sub_by)){
    ### config the subplot
    myxlim <- as.numeric(strptime(
      as.Date(c(d, d + sub_by), origin = "1970-01-01"),
      format = '%Y-%m-%d', tz ='GMT'
      ))
    xat <- NULL
    xlabels <- TRUE
    if (sub_by <= 1) {
      xat <- strptime(
        paste(
          strptime(
            as.Date(d, origin = "1970-01-01"),
            format = '%Y-%m-%d',
            tz ='GMT'
          ),
          seq(0, 24, 6)
        ),
        format = '%Y-%m-%d %H',
        tz ='GMT')
      xlabels <- format(xat, format = '%H:%M', tz = 'GMT')
    }
    if (sub_by > 1 & sub_by <= 7) {
      xat <- strptime(
        paste(
          strptime(
            as.Date(
              rep(
                seq(d, by = 1, length.out = sub_by + 1),
                each = 2
                ),
              origin = "1970-01-01"
              ),
            format = '%Y-%m-%d',
            tz ='GMT'), c(0)
          ),
        format = '%Y-%m-%d %H',
        tz ='GMT')
      xlabels <- format(xat, format = '%m-%d %H:%M', tz = 'GMT')
    }

    # prepare sub dataset to plot
    x <- aa[as.Date(aa$TIMESTAMP) >= d &
              as.Date(aa$TIMESTAMP) < d + sub_by, ]
    if (nrow(x) > 0){
      # plot all in one
      print(paste(Sys.time(),
                  as.Date(d, origin = "1970-01-01"),
                  'plotting all in one'))
      png(file = paste(
        './output/', suffix, '_adv_',
        as.Date(d, origin = "1970-01-01"),
        '.png',
        sep = ''
        ),
        width = 1920,
        height = 1080)
      plotraw(x)
      dev.off()

      ### plot t
      print(paste(Sys.time(),
                  as.Date(d, origin = "1970-01-01"),
                  'plotting t individually'))
      png(file = paste(
        './output/', suffix, '_adv_t_',
        as.Date(d, origin = "1970-01-01"),
        '.png',
        sep = ''
        ),
        width = 1920,
        height = 1080)
      plotraw_t(x)
      dev.off()

      ### plot rh
      print(paste(
        Sys.time(),
        as.Date(d, origin = "1970-01-01"),
        'plotting RH individually'))
      png(file = paste(
        './output/', suffix, '_adv_rh_',
        as.Date(d, origin = "1970-01-01"),
        '.png',
        sep = ''
        ),
        width = 1920, height = 1080)
      plotraw_rh(x)
      dev.off()
    }
  }
}

#' Download the logger program
#'
#' @return a .CR1 program file for the data logger
#' @export
#'
#' @examples
#' get_logger()
get_logger <- function(){
  filesuffix <- c('previous', 'additional_inlet')
  filename <- paste0('logger_', filesuffix, '.CR1')
  myurl <- paste0('https://github.com/pzhaonet/advr/raw/master/inst2/', filename)
  for (i in 1:length(filesuffix)) download.file(url = myurl[i], destfile = filename[i])
}

#' Download an Arduino program file
#'
#' @return an .ino file for the Arduino microcontroller
#' @export
#'
#' @examples
#' get_arduino()
get_arduino <- function(){
  filesuffix <- c('previous', 'additional_inlet')
  filename <- paste0('arduino_', filesuffix, '.ino')
  myurl <- paste0('https://github.com/pzhaonet/advr/raw/master/inst2/', filename)
  for (i in 1:length(filesuffix)) download.file(url = myurl[i], destfile = filename[i])
}

#' Download a demo data file
#'
#' @param exdir A character string with the name where the downloaded file is saved.
#'
#' @return A .zip data file downloaded in the destination directory.
#' @export
#'
#' @examples
#' get_data()
get_data <- function(exdir = 'demo'){
  if(!dir.exists(exdir))
    dir.create(exdir)
  source_url <- 'https://github.com/pzhaonet/advr/raw/master/inst2/data.zip'
  zipfile <- 'data.zip'
  download.file(url = source_url, destfile = zipfile)
  unzip(zipfile = zipfile, exdir = exdir)
  file.remove(zipfile)
}
