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
library(ggplot2)
library(plotly)

dataset <- read.csv('genocode_all_pcadf.csv',header = TRUE, sep = ",", quote = "\"", dec = ".", fill = TRUE, row.names = 1)
headerNames=colnames(dataset)
# Define UI for application that draws a histogram
ui <- fluidPage(
  # Application title
  titlePanel("Data Explore"),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput('x', 'X', c("None"=FALSE,headerNames),headerNames[2]),
      selectInput('y', 'Y', c("Tissue"="tissue.sample.type", "Gender"="Gender", "Age"="Age.group", "Hardy"="Hardy.scale")),
      selectInput('size', 'Size', c("Tissue"="tissue.sample.type", "Gender"="Gender", "Age"="Age.group", "Hardy"="Hardy.scale")),
      selectInput('color', 'Color', c("Tissue"="tissue.sample.type", "Gender"="Gender", "Age"="Age.group", "Hardy"="Hardy.scale")),
      checkboxInput('geom_point', 'geom_point'),
      checkboxInput('geom_dotplot', 'geom_dotplot'),
      checkboxInput('geom_bar', 'geom_bar'),
      checkboxInput('geom_histogram', 'geom_histogram'),
      checkboxInput('geom_violin', 'geom_violin')
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("disPlot")
    )
  )
)
# Define server logic required to draw a histogram
server <- function(input, output) {
  output$disPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    if (input$geom_point)
      p <- ggplot(dataset, aes_string(x = input$x, y = input$y, color = input$color, size = input$size)) + 
        geom_point()
    print(p)
    if (input$geom_bar)
      p <- ggplot(dataset, aes_string(x = input$x, color = input$color, size = input$size)) + 
      geom_bar()
    print(p)
    if (input$geom_histogram)
      p <- ggplot(dataset, aes(x = input$x, color = input$color, size = input$size)) + 
      geom_histogram()
    print(p)
    # geom_dotplot doesn't requires an y input
    if (input$geom_dotplot)
      p <- ggplot(dataset, aes_string(x = input$x, y = input$y, color = input$color, size = input$size)) + 
      geom_dotplot()
    print(p)
    if (input$geom_violin)
      p <- ggplot(dataset, aes_string(x = input$x, y = input$y, color = input$color, size = input$size)) + 
      geom_violin()
    print(p)
  }, height=700)
      
      # draw the histogram with the specified number of bins
}

# Run the application 
shinyApp(ui = ui, server = server)

