library(rvest) 
library(ggplot2)
library(DT)

#IMDb - Movies
imdb_movies <- 'http://www.imdb.com/search/title?count=100&release_date=YEAR,YEAR&title_type=feature'

#IMDb - TV
imdb_tv <- 'http://www.imdb.com/search/title?count=100&release_date=YEAR,YEAR&title_type=tv_series'

get.data.imdb <- function(year,medium) {
  #format url with year
  url <- ifelse(medium == "Film",gsub("YEAR",toString(year),imdb_movies), gsub("YEAR",toString(year),imdb_tv))
  
  #Reading the HTML code from the website
  webpage <- read_html(url)
  
  #grab genre data
  title_data_html <- html_nodes(webpage,'.lister-item-header a')
  genre_data_html <- html_nodes(webpage,'.genre')
  rating_data_html <- html_nodes(webpage,'.ratings-imdb-rating strong')
  
  #title post processing
  title_data <- gsub("[\r\n]","",html_text(title_data_html))
  
  #genre post processing
  genre_data <- gsub("[ \r\n]","",html_text(genre_data_html))
  genre_data <- gsub(",.*","",genre_data)
  genre_data <- factor(genre_data)
  
  #rating post processing
  rating_data <- gsub("[ \r\n]","",html_text(rating_data_html))
  rating_data <- as.numeric(rating_data)
  
  #combile all lists to form a dataframe, and return it
  data.frame(title = title_data, genre = genre_data,rating = rating_data)
}

# Define server logic 
server <- function(input, output) { 
  #renders the selected medium
  output$medium <- renderText({ 
    paste(input$medium)
  })
  #renders the selected plot, with selected medium data
  output$plot <- renderPlot({ 
    df <- get.data.imdb(input$date,input$medium)
    ggplot(df, aes(x=genre)) + geom_bar()
  })
  
  #renders the list of movies
  output$table <- DT::renderDataTable(get.data.imdb(input$date,input$medium), options = list(scrollX = TRUE))
  
  #renders mean of data
  output$mean <- renderText({
    df <- get.data.imdb(input$date,input$medium)
    paste(round(mean(df$rating,rm.na = TRUE),digits = 2))
  })
  
  #renders median of data
  output$median <- renderText({
    df <- get.data.imdb(input$date,input$medium)
    paste(median(df$rating,rm.na = TRUE))
  })
  
  #renders mode of data
  output$mode <- renderText({
    df <- get.data.imdb(input$date,input$medium)
    uvals <- unique(df$rating)
    paste(uvals[which.max(tabulate(match(df$rating, uvals)))])
  })
  
  #renders std of data
  output$sd <- renderText({
    df <- get.data.imdb(input$date,input$medium)
    paste(round(sd(df$rating),digit = 2))
  })
  
  #renders std of data
  output$max <- renderText({
    df <- get.data.imdb(input$date,input$medium)
    paste(max(df$rating))
  })
  
  #renders std of data
  output$min <- renderText({
    df <- get.data.imdb(input$date,input$medium)
    paste(min(df$rating))
  })
}
