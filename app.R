#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(datasets)
library(plotly)


dataset <- dataset <- read.csv('genocode_all_pcadf.csv',header = TRUE, sep = ",", quote = "\"", dec = ".", fill = TRUE, row.names = 1)
nms <- names(dataset)


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Data Explore"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
     sidebarPanel(
       selectInput('x', 'X', choices = nms, selected = 'Gender'),
       selectInput('y', 'Y', choices = nms, selected = 'Gender'),
       selectInput('z', 'Z', choices = nms, selected = 'Gender'),
       selectInput('color', 'Color', choices = nms, selected = 'tissue.sample.type'),
       checkboxInput('geom_point', 'geom_point'),
       checkboxInput('geom_dotplot', 'geom_dotplot'),
       checkboxInput('geom_bar', 'geom_bar'),
       checkboxInput('geom_histogram', 'geom_histogram'),
       checkboxInput('geom_violin', 'geom_violin')
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        plotlyOutput('trendPlot', height = "900px")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  dataset <- reactive({
    genocode_all_pcadf[sample(nrow(genocode_all_pcadf))]
  })
   
  output$trendPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
    if (input$geom_point)
      p <- ggplot(dataset(), aes_string(x = input$x, y = input$y, color = input$color)) + 
        geom_point()
      print(p)
    
    if (input$geom_bar)
      p <- ggplot(dataset(), aes_string(x = input$x, color = input$color)) + 
        geom_bar()
      print(p)
    if (input$geom_histogram)
      p <- ggplot(dataset(), aes_string(x = input$x, y = input$y, color = input$color)) + 
        geom_histogram()
      print(p)
     
     # geom_dotplot doesn't requires an y input
    if (input$geom_dotplot)
      p <- ggplot(dataset(), aes_string(x = input$x, y = input$y, color = input$color)) + 
        geom_dotplot()
      print(p)
     
    if (input$geom_violin)
      p <- ggplot(dataset(), aes_string(x = input$x, y = input$y, color = input$color)) + 
        geom_violin()
     print(p)


   }, height=700)
      
      # draw the histogram with the specified number of bins
}

# Run the application 
shinyApp(ui = ui, server = server)

