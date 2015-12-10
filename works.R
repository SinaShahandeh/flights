airports <- read.csv(file = "airports.txt")
codes=airports[,c('airport_name', 'city', 'country', 'code')]
codes=data.frame(lapply(codes, as.character), stringsAsFactors = F)
codes$city=tolower(codes$city)

f <- file("request_email.txt")
req<- tolower(readChar(f, nchars = 1000))
req <- unlist(strsplit(req,split = " "))

req_city_ind = which(req %in% tolower(codes$city))


city_from = req[req_city_ind[which(req[(req_city_ind-1)]=="from")]]
city_to = req[req_city_ind[which(req[(req_city_ind-1)]=="to")]]

code_to = codes$code[which(codes$city==city_to)[1]]
coed_from = codes$code[which(codes$city==city_from)[1]]

library(scrapeR)

library(rvest)
library(RSelenium)
#start RSelenium
checkForServer()
startServer()
remDr <- remoteDriver()
remDr$open()

#navigate to your page
remDr$navigate('http://www.ca.kayak.com/flights/YYZ-JFK/2015-11-05/2015-11-09')

#scroll down 5 times, waiting for the page to load at each time
for(i in 1:5){      
  remDr$executeScript(paste("scroll(0,",i*10000,");"))
  Sys.sleep(3)    
}

#get the page html
page_source<-remDr$getPageSource()

#parse it
read_html(page_source[[1]]) %>% html_nodes(".bookitprice") %>%
  html_text()

h = read_html('http://www.ca.kayak.com/flights/YYZ-JFK/2015-11-05/2015-11-09')
html_text(html_nodes(h, '.'))
html_

var fs = require('fs');
