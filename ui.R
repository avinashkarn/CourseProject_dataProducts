#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/

library(shiny)
library(ggplot2)
library(GGally)

ui <- bootstrapPage(
  mainPanel(
    titlePanel("Correlation analysis with R Shiny App"),
    
    tabsetPanel(
      
      tabPanel("Data input", 
               p("Upload your data by first selecting the options below:"),
               p("Download example data set here ", a("iris.csv", href = "https://vincentarelbundock.github.io/Rdatasets/csv/datasets/iris.csv")),
               tags$hr(),
               
               radioButtons(inputId = 'header',  
                            label = 'Header',
                            choices = c('Columns have headers'='Yes',
                                        'Columns do not have headers'='No'), 
                            selected = 'Yes'),
               
               radioButtons('sep', 'Separator',
                            c(Comma=',',
                              Semicolon=';',
                              Tab='\t'),
                            ','),
               
               radioButtons('quote', 'Quote',
                            c(None='',
                              'Double Quote'='"',
                              'Single Quote'="'"),
                            '"'),
               
               tags$hr(),
               
               fileInput('file1', 'Upload your file :',
                         accept = c(
                           'text/csv',
                           'text/comma-separated-values',
                           'text/tab-separated-values',
                           'text/plain',
                           '.csv',
                           '.tsv'
                        )),
               p("Next, click on the 'Correlation plot matrix' tab")
      ), 
      
      tabPanel("Correlation plot matrix",
               uiOutput("choose_columns_biplot"),
               tags$hr(),
               p("Please note: This plot may take a few moments to appear when analysing large datasets."),
               
               plotOutput("corr_plot")
              
      ) # end  tab
      
    ))) 