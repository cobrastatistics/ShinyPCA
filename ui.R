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
      
      tabsetPanel(
        tabPanel("Plot",plotOutput("pcaPlot"), selectInput(inputId = "Dimension", label = "Choose a dimension:", choices = c("PC1", "PC2", "PC3"), selected = "PC2")),
        tabPanel("Loadings", DT::dataTableOutput("Loadings")),
        tabPanel("Scree", plotOutput("Scree")),
        tabPanel("Data", DT::dataTableOutput("Data"))
      )
      
      
    )
  )
)
