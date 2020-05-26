#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(GGally)


server <- function(input, output) {
  
  # read in the CSV
  the_data_fn <- reactive({
    inFile <- input$file1
    if (is.null(inFile)) return(NULL)
    the_data <-   read.csv(inFile$datapath, header = (input$header == "Yes"),
                           sep = input$sep, quote = input$quote, stringsAsFactors=FALSE)
    return(the_data)
  })
  
  
  
  
  # Check boxes to choose columns
  output$choose_columns_biplot <- renderUI({
    
    the_data <- the_data_fn()
    
    colnames <- names(the_data)
    
    # Create the checkboxes and select them all by default
    checkboxGroupInput("columns_biplot", "Choose up to five columns to display on the scatterplot matrix", 
                       choices  = colnames,
                       selected = colnames[1:10])
  })
  
  lowerFn <- function(data, mapping, method = "lm", ...) {
    p <- ggplot(data = data, mapping = mapping) +
      geom_point(colour = "blue") +
      geom_smooth(method = method, color = "red", ...)
    p
  }
  
  # corr plot
  output$corr_plot <- renderPlot({
    the_data <- the_data_fn()
    # Keep the selected columns
    columns_biplot <-    input$columns_biplot
    the_data_subset_biplot <- the_data[, columns_biplot, drop = FALSE]
    ggpairs(the_data_subset_biplot, lower = list(continuous = wrap(lowerFn, method = "lm")),
            diag = list(continuous = wrap("barDiag", colour = "blue")),
            upper = list(continuous = wrap("cor", size = 10))
    )
                                          
  })

  
}
