install.packages("rvest")
install.packages("xml2")
library(xml2)
library(rvest)
library(dplyr)
library(tidyverse)


html<- read_html("https://www.merriam-webster.com/thesaurus/research")

html %>%  
  html_nodes(".mw-list") %>% html_text () %>% 
  head(n=1) # take the first 1st records

##code to webscrape a list of synonyms for the merriam webster thesaurus 
words <- c("department","surgery","staff","Doctor","consent")
htmls <- paste0("https://www.merriam-webster.com/thesaurus/", words)
getwd()

info_list <-  map(htmls, ~ .x   %>%
                   read_html() %>%
                   html_node(".mw-list") %>%
                   html_text())

df <- data.frame(matrix(unlist(info_list), nrow=length(info_list), byrow=T))

words<-data.frame(words,df)

words %>% write_csv("webscrapetest.csv")


POSpeech <-  map(htmls, ~ .x   %>%
                    read_html() %>%
                    html_node(".important-blue-link") %>%
                    html_text())

df2pos <- matrix(unlist(POSpeech), nrow=length(POSpeech), byrow=T)
