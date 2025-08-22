
if (!require(devtools)) install.packages("devtools", repos = "https://cloud.r-project.org")
if (!require(tidyverse)) install.packages("tidyverse", repos = "https://cloud.r-project.org")
if (!require(gitcreds)) install.packages("gitcreds", repos = "https://cloud.r-project.org")

library(gitcreds)
#gitcreds::gitcreds_set('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')
Sys.setenv(GITHUB_PAT = "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")

if (!require(nser)) remotes::install_github('nandp1/nser')

library(devtools)
library(tidyverse)
library(nser)

fo = read.csv('fo.csv')
err = read.csv('err.csv')
fodata = readRDS("fodata.rds")

fostock = tryCatch(bhavtoday(), error=function(e) err)
fostock = inner_join(fostock, fo)
fostock = subset(fostock, SERIES == "EQ")

fodata = bind_rows(fodata)
fodata = rbind(fodata, fostock)
fodata$SYMBOL = as.factor(fodata$SYMBOL)
# save as .csv file
write.csv(fodata, 'fodata.csv')

fodata = split(fodata, fodata$SYMBOL)
fodata = lapply(fodata, function(x) x[order(as.Date(x$TIMESTAMP, format="%d-%b-%Y")),])
# remove duplicated rows 
fodata = lapply(fodata, function(x) x[!duplicated(x), ] )

saveRDS(fodata, 'fodata.RDS')


#write.csv(fostock, 'bhav190825.csv')

#survey_data %>%
#  write_rds("survey_data.rds")

