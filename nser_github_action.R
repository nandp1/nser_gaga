

if (!require(devtools)) install.packages("devtools", repos = "https://cloud.r-project.org")
if (!require(tidyverse)) install.packages("tidyverse", repos = "https://cloud.r-project.org")

library(devtools)
library(tidyverse)

install_github("nandp1/nser")

library(nser)


fostock = bhav('19082025')
fo = read.csv('fo.csv')
fostock = inner_join(fostock, fo)
fostock = subset(fostock, SERIES == "EQ")

write.csv(fostock, 'bhav190825.csv')

#survey_data %>%
#  write_rds("survey_data.rds")


