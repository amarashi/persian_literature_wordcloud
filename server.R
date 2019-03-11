
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(tokenizers)
library(RColorBrewer)
library(wordcloud)
library(tools)
library(stopwords)
library(epubr)
library(dplyr)
library(memoise)

Sys.setlocale(locale =  "persian")

shinyServer(function(input, output,session) {
  # books <- list.files("books/")
  # names <- file_path_sans_ext(books)
  # updateSelectInput(session, "author", choices = names,selected = "hafz")
  
  terms <- reactive({
      withProgress({
        setProgress(message = "Processing the text... ")
        getTermFreq(input$author)
      })
  })
  
  observe({
    tok_tbl <- terms()
    updateSliderInput(session, "freq",  max = max(tok_tbl$n)-1)
    updateSliderInput(session, "max",  max = min(500,(max(nrow(tok_tbl)))))
  })
  
  # Make the wordcloud drawing predictable during a session
  wordcloud_rep <- repeatable(wordcloud)
  
  output$abrPlot <- renderPlot({
    tok_tbl <- terms()
    suppressWarnings(wordcloud_rep(words = tok_tbl$value, freq = tok_tbl$n,
              min.freq = input$freq, max.words=input$max,
              rot.per = 0.05,scale = c(input$size,0.1*input$size),
              random.order = F,
              colors = brewer.pal(8, "Dark2"),
              ordered.colors =  F))
    })
  # output$debug <- renderText({input$author  })

})
