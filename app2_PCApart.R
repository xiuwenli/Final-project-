#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(plotly)
library(datasets)
setwd(dir = '/Users/user/Final_project')
dataset <- read.csv('genocode_all_pcadf.csv',header = TRUE, sep = ",", quote = "\"", dec = ".", fill = TRUE, row.names = 1)
headerNames=colnames(dataset)
# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Adipose PCA Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        selectInput('x', 'X', c("None"=FALSE,headerNames),headerNames[7]),
        selectInput('y', 'Y', c("None"=FALSE,headerNames),headerNames[8]),
        selectInput('z', 'Z', c("None"=FALSE,headerNames),headerNames[9])
      ),
      
      # Show a plot of the generated distribution
      mainPanel(plotlyOutput("plot"))
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$plot <- renderPlotly({
      # generate bins based on input$bins from ui.R
     plot_ly(genocode_all_pcadf, x = ~get(input$x), y = ~get(input$y), z = ~get(input$z), color = genocode_all_pcadf$tissue.sample.type, colors = c('#BF382A', '#0C4B8E')) %>%
       add_markers() %>%
       layout(scene = list(xaxis = list(title = 'PC4'),
                           yaxis = list(title = 'PC8'),
                           zaxis = list(title = 'PC2')))
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

