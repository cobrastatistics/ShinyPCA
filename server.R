#Olympics <- read.csv2("C:/Users/nelso/Desktop/Shiny PCA/raw data/Olympics.csv")
#Employment <- read.csv2("C:/Users/nelso/Desktop/Shiny PCA/raw data/Employment.csv")

server <- function(input, output) {
  
  library(ggplot2)
  library(ggrepel)
  
  
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

    
    ggplot( as.data.frame(pca$x) , aes(x = PC1 , y = PC2 , label = datasetInput()$Country)) + # best?mmer data och variabler att visa
      geom_hline( yintercept = 0, linetype = 2) + # ritar referenslinje horizontellt
      geom_vline( xintercept = 0, linetype = 2) + # ritar referenslinje lodr?tt
      geom_point() + # ritar punkter i diagrammet
      geom_text_repel() + # separerar labels som ligger ovanp? varandra
      theme_classic( base_size = 14)  # s?tter l?mpligt tema och grundstorlek p? diagramkomponenter
      
    
  })
  

  
}