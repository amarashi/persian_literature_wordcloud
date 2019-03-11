library(tokenizers)
library(RColorBrewer)
library(wordcloud)
library(tools)
library(stopwords)
library(epubr)
library(dplyr)
library(memoise)
myStopwords <- stopwords::stopwords("fa", "stopwords-iso")
myStopwords <- c(myStopwords,"شمارۀ", "ز","کز" ,"گر","خیام","رباعی" )
# myStopwords <- c("شمارۀ")


getTermFreq <- memoise(function(author) {

  x <- epub(sprintf("books/%s.epub",author))
  df <- x$data[[1]][,"text"]$text
  temp <- unlist(strsplit(df[5:length(df)],  "شماره"))
  tok <- unlist(tokenize_words(temp))
  tok_tbl <- tok %>% as_data_frame() %>% group_by(value) %>% summarise(n = n()) %>% 
    filter(n>0) %>% filter(!(value %in% myStopwords)) %>% arrange(desc(n))
})