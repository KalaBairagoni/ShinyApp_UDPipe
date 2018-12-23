#
#  TABA GROUP PROJECT 
#  
#  Devender Bansal (PGID 11810089) 
#  Chandrakala Bairagoni (PGID 11810069) 
#


options(shiny.maxRequestSize=30*1024^2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
 
  # Text Upload Code
      dataset <- reactive({
          
          if (is.null(input$file)) {return(NULL)}
          
          else {
            
            Document = readLines(input$file$datapath, encoding = 'utf-8')
            
            review_text  =  str_replace_all(Document, "<.*?>", "") # cleaning all HTML Files
            
  
            return(review_text)}
        
      }) # dataset closure
      
      
      output$cogplot.english <- renderPlot({
        
          en_model =   udpipe_load_model(input$UDPipe$datapath)
          
           reviews <- udpipe_annotate(en_model, dataset())
           
          reviews <- as.data.frame(reviews)
  
          nokia_cooc <- cooccurrence(     # try `?cooccurrence` for parm options
            x = subset(reviews, upos %in% input$posgp), 
            term = "lemma", 
            group = c("doc_id", "paragraph_id", "sentence_id"))  # 0.02 secs
          
          wordnetwork <- head(nokia_cooc, 50)
          wordnetwork <- igraph::graph_from_data_frame(wordnetwork) # needs edgelist in first 2 colms.
          
          ggraph(wordnetwork, layout = "fr") +  
            
            geom_edge_link(aes(width = cooc, edge_alpha = cooc), edge_colour = "orange") +  
            geom_node_text(aes(label = name), col = "darkgreen", size = 4) +
            
            theme_graph(base_family = "Arial Narrow") +  
            theme(legend.position = "none") +
            
           # labs(title = "Cooccurrences within 3 words distance", subtitle = "Selected POS Tage" + input$posgp)
            
           labs(title = "Cooccurrences within 3 words distance")
        
      }) 
 
}) # shinyServer code Goes Here
