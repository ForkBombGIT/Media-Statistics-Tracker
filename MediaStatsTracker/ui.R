library(ggplot2)
library(DT)

# Define UI for application that draws a histogram
ui <- fluidPage(
  #html styles
  tags$head(
    tags$style(HTML("
      h3 {
        margin-top: 0px;
        margin-bottom: 10px;
      }
      
      dt { float: left; clear:both; margin-bottom: 5px; font-weight: normal;}
      dd { float: right; }
      dl { overflow: hidden; }
    "))
  ),
  
  # Application title
  titlePanel("Media Statistics Tracker"),
  tags$hr(),
  sidebarLayout(
    sidebarPanel(
      tags$h3(textOutput("medium")),
      tags$dl(
        tags$dt("Mean Rating:"),
        tags$dd(textOutput("mean")),
        tags$dt("Median Rating:"),
        tags$dd(textOutput("median")),
        tags$dt("Mode Rating:"),
        tags$dd(textOutput("mode")),
        tags$dt("Maximum Rating:"),
        tags$dd(textOutput("max")),
        tags$dt("Minimum Rating:"),
        tags$dd(textOutput("min")),
        tags$dt("Standard Deviation of Rating:"),
        tags$dd(textOutput("sd"))
      ),
      hr(),
      helpText("Discover trends of media mediums throughout the years."),
      selectInput("medium", 
                  label = "Choose a media medium to display:",
                  choices = list("Film", 
                                 "Television"),
                  selected = "Film"),
      selectInput("graph", 
                  label = "Choose a graph to display:",
                  choices = list("Bar"),
                  selected = "Bar"),
      selectInput(
        inputId =  "date", 
        label = "Choose a year to display trends from:", 
        choices = 1900:2100
      )
    ),
    mainPanel(
      plotOutput("plot",height = '450px',width = '550px'),
      fluidRow(column(DT::dataTableOutput("table"),width = 12))
    )
  )
)