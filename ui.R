#
#  TABA GROUP PROJECT 
#  
#  Devender Bansal (PGID 11810089) 
#  Chandrakala Bairagoni (PGID 11810069) 
#



library(shiny)

# Define UI for application that plots the co-occurrences plot

shinyUI(fluidPage(
  
  # Application title
  titlePanel("UDPipe NLP Work Flow - POS COOCCURRENCES PLOTS.."),
  
  # Divide the screen into two parts left and right panels
  sidebarLayout(
    
  
    sidebarPanel(
      
      fileInput("file", "Upload Any Text File.."),
     
      
      fileInput("UDPipe", "Upload respective UDPipe Trained Models (Engish, Hindi, Spanish)"),
      
      span(style = "color:red;", h4(p("Note: Upload text file and respective language UDPipe trained model at a time as a pair."))),
      
      # Forms the group of checkboxes
      checkboxGroupInput("posgp", label = h3("POS Tags"), 
                         choices = list("Adjective" = "ADJ", "Noun" = "NOUN", "Propernoun" = "PROPN", "Adverb" = "ADV", "Verb" = "VERB"),
                         selected = c("ADJ","NOUN","PROPN")),
      
      fluidRow(column(1, verbatimTextOutput("value"))),
      
      
      submitButton(text = "Apply Changes", icon("refresh"))
        
    ), #Left Side Panel Closure 
    

    # **** Right Side Tabs Goes Here *** 
    
    mainPanel(
      
      tabsetPanel(type = "tabs",
                  
                # Each Tab Code Starts HERE 
                
                    tabPanel("Overview",h4(p("How to use this App")),
                           
                           p("Overview of this Project"),
                           
                           p("To use this app you need to upload a text file. Make sure each document as of different language.You can upload any language text file.
                              
                              Upload an another trained model of respective language.Type of text file and language train model should be in synch.

                             Respective cooccurence plot would be displayed on the co-occurence tab at the right panel to do Text Analysis.", align = "justify"),

                           
                           p("If you wish to change the input to see other language cooccurence plots upload respective text file and trained model and then click on Apply changes. Accordingly results in other tab will be refreshed
                             
                             ", align = "Justify"),
                           
                           h5("Note"),
                           
                           p("You might observe no change in the outputs after clicking 'Apply Changes'. Wait for few seconds. As soon as all the computations
                             
                             are over in back-end results will be refreshed.",
                             
                             align = "justify"),
                           
                           
                           verbatimTextOutput("start")
                           
                     ),
 
                tabPanel("Co-Occurrences Plot", h3(p("UDPipe NLP Work Flow UPOS CO-Occurrences Plot..")),
  
                      plotOutput("cogplot.english",height = 700, width = 700)
                )
                  
                            
            ) # Where every tab goes HERE           
           
    ) # Closure of RIGHT Side mainPanel

  ) # Panel for Diving the Areas

)) # Closure of the Main Panel
