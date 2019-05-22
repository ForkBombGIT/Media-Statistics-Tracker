# Define UI for application that draws a histogram
ui <- fluidPage(
  #html styles
  tags$head(
    tags$style(HTML("
      h1 {
        margin-top: 0px;
      }

    "))
  ),
  # Application title
  titlePanel("Media Statistics Tracker"),
  tags$hr(),
  sidebarPanel(
    tags$h1(textOutput("medium")),
    helpText("Discover trends of media mediums throughout the years."),
    selectInput("medium", 
                label = "Choose a media medium to display:",
                choices = list("Film", 
                               "Television",
                               "Video Games", 
                               "Music"),
                selected = "Film"),
    selectInput("graph", 
                label = "Choose a graph to display:",
                choices = list("Histogram"),
                selected = "Histogram"),
    selectInput(
      inputId =  "date", 
      label = "Choose a year to display trends from:", 
      choices = 1950:2100
    )
  ),
  mainPanel(
    textOutput("graph"),
    textOutput("date")
  )
)