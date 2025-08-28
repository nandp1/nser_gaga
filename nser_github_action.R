
#if (!require(devtools)) install.packages("devtools", repos = "https://cloud.r-project.org")
if (!require(tidyverse)) install.packages("tidyverse", repos = "https://cloud.r-project.org")
#if (!require(gitcreds)) install.packages("gitcreds", repos = "https://cloud.r-project.org")
if (!require(nser)) install.packages("nser", repos = "https://cloud.r-project.org")

#library(gitcreds)
#gitcreds::gitcreds_set('${{ secrets.ABCD }}')
#Sys.setenv(GITHUB_PAT = '${{ secrets.ABCD }}')

#if (!require(nser)) remotes::install_github('nandp1/nser')

#library(devtools)
library(tidyverse)
library(nser)

month = format(Sys.time(), "%m")
mt1 = month
month = as.integer(month)
month = month.abb[month]
month = toupper(month)
year = format(Sys.time(), "%Y")
date = format(Sys.time(), "%d")
# date in numeric
dd = paste0( date, mt1, year)
aa = paste0(dd, '.csv')

bhavcopy = bhav(dd)
dd1 = bhavcopy$TIMESTAMP[1]
dd = dmy(dd)
dd1 = dmy(dd1)

if(dd == dd1){
  #
  #fo = read.csv('fo.csv')
  err = read_csv("err.csv", col_types = cols(SYMBOL = col_character()))

  bhavcopy = tryCatch(bhav(dd), error=function(e) err)
 
  if (!dir.exists("2025")) dir.create("2025")
  
  # save as .csv file
  write.csv(bhavcopy, aa)
  
  print('Bhavcopy downloaded Sucessfully')
} else{
  print('No Bhavcopy available for today')
}


#git add .
#git add *.csv
#git commit -m "MY MESSAGE HERE"
