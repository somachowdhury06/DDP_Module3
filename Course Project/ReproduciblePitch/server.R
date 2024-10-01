#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(plotly)
library(lubridate)

# Define server logic required to draw a candlestick
function(input, output, session) {

  csvdata <- read.csv("Trading data.csv",sep = ",", quote = '"', dec = ".", stringsAsFactors = FALSE)

  csvdata$Date <- as.Date(csvdata$Date, "%m/%d/%Y")

  output$Exchange <- renderUI({
    selectInput("Exchange", "Exchange:", as.list(unique(csvdata$Symbol)),
                selected = levels(csvdata$Symbol)[60] )
  })

  output$Period <- renderUI({
    dtPeriod <- csvdata[csvdata$Symbol == input$Exchange,]
    dtPeriod1 <- dtPeriod[order(dtPeriod$Period, decreasing = FALSE),3]
    selectInput("Period", "Period:", lapply(as.list(unique(dtPeriod1)),sort,decreasing=TRUE),
                selected = levels(dtPeriod1)[60] )
  })

  output$text1 <- renderText({
    paste(input$Exchange, "Performace For The Period", input$Period, sep = " ")
  })


  output$distPlot <- renderPlotly({
    dt <- csvdata[csvdata$Symbol == input$Exchange & csvdata$Period == input$Period, ]

    p <- dt %>% plot_ly(x= ~Date, type="candlestick",
                        open= ~Open, close= ~Close, high= ~High, low= ~Low) %>%
      layout(title=paste(input$Exchange,"Performance", sep = " "))
  })
}
