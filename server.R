library(shiny)
library(ggplot2)
library(ggrepel)
library(dplyr)
library(DT)

con <- url("https://github.com/cobrastatistics/data/raw/master/datasets.RData")
load(con)

server <- function(input, output) {
  
  
  datasetInput <- reactive({
    
    switch(input$dataset,
           
           "Olympics" = Olympics,
           
           "Employment" = Employment)
    
  })
  


  
  output$pcaPlot <- renderPlot({
    

    dI <- as.data.frame(datasetInput())


    pca <- prcomp(dI[,-1], scale. = T, center = T)
    
   

    
    ggplot( as.data.frame(pca$x) , 
            aes(x = PC1 , y = get(input$Dimension), 
                label = datasetInput()$Country)) +
                    labs(y = paste0(input$Dimension)) +
                    geom_hline( yintercept = 0, linetype = 2) +
                    geom_vline( xintercept = 0, linetype = 2) +
                    geom_point() +
                    geom_text_repel() +
                    theme_classic( base_size = 14)
      
    
  })
  
  
  
  output$Loadings <- DT::renderDataTable({
    
    dI <- as.data.frame(datasetInput())
    
    pca <- prcomp(dI[,-1], scale. = T, center = T)
    
    datatable(pca$rotation)
    
    
  })
  
  
  output$Scree <- renderPlot({
    
    dI <- as.data.frame(datasetInput())
    
    pca <- prcomp(dI[,-1], scale. = T, center = T)
    
    screeplot(pca, main = "")
    
  })
  
  
  output$Data <- DT::renderDataTable({
    
    datasetInput()
    
  })

  
}