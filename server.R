library(shiny)
library(ggplot2)
library(ggrepel)
load("Datasets.RData")

server <- function(input, output) {
  
  
  datasetInput <- reactive({
    
    switch(input$dataset,
           
           "Olympics" = Olympics,
           
           "Employment" = Employment)
    
  })
  
  

  
  
  output$pcaPlot <- renderPlot({
    
    isolate({
      dI <- as.data.frame(datasetInput())
    })
    
    
    pca <- prcomp(dI[,-1], scale. = T, center = T)

    
    ggplot( as.data.frame(pca$x) , 
            aes(x = PC1 , y = PC2 , 
                label = datasetInput()$Country)) +
                    geom_hline( yintercept = 0, linetype = 2) +
                    geom_vline( xintercept = 0, linetype = 2) +
                    geom_point() +
                    geom_text_repel() +
                    theme_classic( base_size = 14)
      
    
  })
  

  
}