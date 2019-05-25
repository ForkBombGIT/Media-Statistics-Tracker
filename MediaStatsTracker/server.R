library(rvest) 
library(ggplot2)
#IMDb - Movies
imdb_movies <- 'http://www.imdb.com/search/title?count=100&release_date=YEAR,YEAR&title_type=feature'

#IMDb - TV
imdb_tv <- 'http://www.imdb.com/search/title?count=100&release_date=YEAR,YEAR&title_type=tv_series'

#IGDb - Games
igdb <- 'https://www.igdb.com/advanced_search'

get.data <- function(year,url) {
  #format url with year
  url <- gsub("YEAR",toString(year),url)
  
  #Reading the HTML code from the website
  webpage <- read_html(url)
  
  #grab genre data
  genre_data_html <- html_nodes(webpage,'.genre')
  
  #genre post processing
  genre_data <- gsub("[ \r\n]","",html_text(genre_data_html))
  genre_data <- gsub(",.*","",genre_data)
  genre_data <- factor(genre_data)
  
  #combile all lists to form a dataframe, and return it
  data.frame(genre = genre_data)
}

# Define server logic 
server <- function(input, output) {
  output$medium <- renderText({ 
    paste(input$medium)
  })
  output$plot <- renderPlot({ 
    df <- NULL
    if (input$medium == "Film") 
      df <- get.data(input$date,imdb_movies)
    else if (input$medium == "Television") 
      df <- get.data(input$date,imdb_tv)
    
    ggplot(df, aes(x=genre)) + geom_bar()
  })
  output$date <- renderText({ 
    paste(input$date)
  })
}
