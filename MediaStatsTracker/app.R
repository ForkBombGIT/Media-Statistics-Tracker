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
    tags$hr()
)

# Define server logic 
server <- function(input, output) {}

# Run the application 
shinyApp(ui = ui, server = server)
