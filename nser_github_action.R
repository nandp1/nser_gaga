
if (!require(tidyverse)) install.packages("tidyverse", repos = "https://cloud.r-project.org")
if (!require(nser)) install.packages("nser", repos = "https://cloud.r-project.org")

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
dd2 = dd
aa = paste0(dd, '.csv')

bhavcopy = bhav(dd)
dd1 = bhavcopy$TIMESTAMP[1]
dd = dmy(dd)
dd1 = dmy(dd1)

if(dd == dd1){
  #
  #fo = read.csv('fo.csv')
  err = read_csv("err.csv", col_types = cols(SYMBOL = col_character()))

  bhavcopy1 = tryCatch(bhav(dd2), error=function(e) err)
  
  print('Bhavcopy downloaded Sucessfully')
} else{
  print('No Bhavcopy available for today')
}

if (!dir.exists("2025")) dir.create("2025")

# save as .csv file
write.csv(bhavcopy1, aa)

# List all files you want to move (e.g., all csv files)
files_to_move <- list.files(pattern = "^[0-9]+\\.csv$")


for (f in files_to_move) {
  file.rename(f, file.path("2025", f))
}


