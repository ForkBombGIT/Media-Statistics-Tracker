library(rvest) 
#IMDb - Movies
imdb_movies <- 'http://www.imdb.com/'

#IMDb - TV
imdb_tv <- 'http://www.imdb.com/'

#IGDb - Games
igdb <- 'http://www.igdb.com/'

# Define server logic 
server <- function(input, output) {
  output$medium <- renderText({ 
    paste(input$medium)
  })
  output$graph <- renderText({ 
    paste(input$graph)
  })
  output$date <- renderText({ 
    paste(input$date)
  })
}