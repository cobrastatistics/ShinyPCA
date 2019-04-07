library(shiny)

ui <- fluidPage(
  
  titlePanel("Interactive PCA"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput(inputId = "dataset",
                  label = "Choose a dataset:",
                  choices = c("Employment", "Olympics"))
    ),
    
    mainPanel(
      
      plotOutput(outputId = "pcaPlot")
      
    )
  )
)
