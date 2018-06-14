## Introduction

advr is a package for the scientific research program of CO~2~ advection. 

The CO~2~ advection measurement consists with integrated observations of air temperature, humidity, 2D wind velocity, CO~2~ mixing ratio profile, and chamber flux. The measurement procedure is controlled by a data logger and a microcontroller.

advr has the following features.

- advr provides the technical programs for the data logger and the microcontroller.
- advr pre-processes the raw data and visualize them in a friendly way.

In the future more features will come.

## Installation

```{r}
devtools::install_github('pzhaonet/advr')
```

## Quick Start

```{r}
# load the advr package
library(advr)

# download a demo data file
get_data()

# read the raw data file and pre-process the data
adv_data <- read_adv("demo/data_sample.csv", "demo/data_header.csv")

# configure the file names for the sensors
colname_ws <- paste('mean_wind_speed', 1:4, sep = '')
colname_wd <- paste('resultant_mean_wind_direction', 1:4, sep = '')
colname_t <- c(paste('hcT_Avg(', 1:8, ')', sep = ''), 
               paste('chamberT_Avg(', 1:3, ')', sep = ''))

# visualize the raw data by day
plot_adv(aa = adv_data)

# visualize the entire raw data file 
plot_adv(aa = adv_data, sub_by = NA)
```
[![](https://github.com/pzhaonet/advr/raw/master/img/all_adv_2017-07-12.png)](https://github.com/pzhaonet/advr/raw/master/img/all_adv_2017-07-12.png)
