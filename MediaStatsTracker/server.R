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
  
  #grab title data, with post processing
  title_data <- webpage %>% 
                html_nodes('.lister-item-header a') %>% 
                html_text() %>%  
                gsub("[\r\n]","",.) %>%
                factor()
  
  #grab genre data, with post processing
  genre_data <- webpage %>%
                     html_nodes('.lister-item-content') %>%
                     html_node('.genre') %>%
                     html_text() %>%
                     gsub("[ \r\n]","",.) %>%
                     gsub(",.*","",.) %>%
                     factor()
          
  #grab rating data, with post processing
  rating_data <- webpage %>%
                      html_nodes('.ratings-bar') %>%
                      html_node('strong') %>%
                      html_text() %>%
                      gsub("[\r\n]","",.) %>%
                      as.numeric()
  
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
    ggplot(df, aes(x=genre)) + 
      geom_bar() +
      ggtitle(paste("Genre Dispersion of", toString(input$medium),"in the year", toString(input$date))) +
      labs(x = "Genre", y = "Film Count")
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
