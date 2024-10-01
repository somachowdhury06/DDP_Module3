#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(bslib)
library(plotly)

# Define UI for application that draws a histogram
fluidPage(

  titlePanel("Exchange Performance from 2019-2024"),

  sidebarLayout(
    sidebarPanel(
      uiOutput("Exchange"),
      uiOutput("Period")
    ),


    mainPanel(
      h3(textOutput("text1")),

      plotlyOutput("distPlot")
    )
  )
)
