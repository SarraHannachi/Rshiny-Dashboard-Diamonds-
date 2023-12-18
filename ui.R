#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(shinyWidgets)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel(
      tags$h1(
        "Diamond Catalogue: Over 50,000 diamonds",
        style = "display: inline-block; background-color:black; color:white; width: 100%; height: 50px;text-align: center;"
      )
    ),
    
    #Filter boxes
    tags$div(
      tags$h3("Select your diamond filters:", style = "color:black;font-style: italic")
    ),
    
    br(),
    br(),
    
    fluidRow(
      column(4,
             selectInput(
               inputId = "cut", label = "Diamond Cut", width = "100%",
               choices = levels(diamonds$cut),
               selected = levels(diamonds$cut),
               multiple = TRUE
             )),
      
      column(
        4,
        selectInput(
          inputId = "clarity", label = "Diamond Clarity", width = "100%",
          choices = levels(diamonds$clarity),
          selected = levels(diamonds$clarity),
          multiple = TRUE
        )),
      column(
        4,
        selectInput(
          inputId = "color", label = "Diamond Color", width = "100%",
          choices = levels(diamonds$color),
          selected = levels(diamonds$color),
          multiple = TRUE
        ))
      ),
    tags$div(
      tags$h4("PS: The filter choices are ordered from lowest to highest quality",
              style = "color:grey;font-style:italic;font-size:13px;")
    ),
    br(),
    br(),
    tags$div(
      tags$h3("Select your preferred price range:", style = "color:black;font-style:italic")
    ),
    br(),
    
      # Sidebar with a slider input

    sidebarLayout(
      sidebarPanel(
              sliderInput("price","Price Range ($):",
                          min = min(diamonds$price), max = max(diamonds$price),
                          value = c(min(diamonds$price),max(diamonds$price)))
        ),

      # Main Panel (table & plots)
      
          mainPanel(
            tabsetPanel(
              tabPanel("Diamonds Info",DT::dataTableOutput("table")),
              tabPanel("Table & Cut",plotOutput("plot1")),
              tabPanel("Clarity & Carat",plotly::plotlyOutput("plot2",width = "auto"))
            )
          )
),
br(),
br()
)
)

