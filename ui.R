library(shiny)
library(e1071)
shinyUI(
  pageWithSidebar(
  headerPanel('Cell Body Segmentation'),
  
  sidebarPanel(
    numericInput('TotalIntenCh2', 'TotalIntenCh2', value=0),
    numericInput('FiberWidthCh1', 'FiberWidthCh1', value=0),
    submitButton('Submit'),
    h3('Backgroud'),
    p('The dataset "segmentationOriginal" from R package "AppliedPredictiveModeling" was used to build this shiny App.'),
    p('Hill, LaPan, Li and Haney (2007) develop models to predict which cells in a high content screen were well segmented.'),
    p('The data consists of 119 imaging measurements on 2019. The original analysis used 1009 for training and 1010 as a test set.')
    ),
  mainPanel(
    p('The outcome would show which cells in a high content screen were well segmented.'),
    p('There are two different kinds of outcomes:'),
    tags$div(
      tags$ul(
        tags$li('PS : Poorly Segmented'),
        tags$li('WS : Well Segmented')
      )
    ),
    h4('Taking into account the values entered by you:'),
    p('TotalIntenCh2:'), 
    verbatimTextOutput("inputTotalIntenCh2value"),
    p('FiberWidthCh1:'), 
    verbatimTextOutput("inputFiberWidthCh1value"),
    h4('The cells in a high content screen were'),
    verbatimTextOutput("diagnostic"),
    plotOutput('plot1')
  )
)
)
