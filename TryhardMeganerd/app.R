#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Минимум оценок у пользователя и фильма"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("rate_user",
                     "Количество оценок пользователя:",
                     min = 1,
                     max = 500,
                     value = 50),
         
         sliderInput("rate_film",
                     "Количество оценок фильма:",
                     min = 1,
                     max = 500,
                     value = 50)
      ),
      
          
        
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

library(recommenderlab)
library(ggplot2)
data(MovieLense)


server <- function(input, output) { 
  output$distPlot = renderPlot({
    ratings_movies <- MovieLense[rowCounts(MovieLense) > input$rate_user, colCounts(MovieLense) > input$rate_film] 
    average_ratings_per_user <- rowMeans(ratings_movies)
    ggplot()+geom_histogram(aes(x=average_ratings_per_user)) +
      ggtitle("Распределение средних оценок пользователей")
  })
}

shinyApp(ui = ui, server = server)



