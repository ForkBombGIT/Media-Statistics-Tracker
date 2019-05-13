library(shiny)
library(rvest) 

#IMDb - Movies
imdb_movies <- 'http://www.imdb.com/'

#IMDb - TV
imdb_tv <- 'http://www.imdb.com/'

#IGDb - Games
igdb <- 'http://www.igdb.com/'

# Define UI for application that draws a histogram
ui <- fluidPage(
    # Application title
    titlePanel("Media Statistics Tracker"),
    tags$hr(),
    sidebarLayout(
                  sidebarPanel(
                    helpText("Discover trends of media mediums throughout the years."),
                    selectInput("medium", 
                                label = "Choose a media medium to display:",
                                choices = list("Film", 
                                               "Television",
                                               "Video Games", 
                                               "Music"),
                                selected = "Film"),
                    selectInput(
                      inputId =  "date", 
                      label = "Choose a year to display trends from:", 
                      choices = 1950:2100
                    )
                  ),
                  mainPanel("main panel")
    )
)

# Define server logic 
server <- function(input, output) {}

# Run the application 
shinyApp(ui = ui, server = server)
