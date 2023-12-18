# Rshiny Training Session
# Date: 09.11.2022
#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(shinyWidgets)
library(plotly)

# Define server logic

shinyServer(function(input, output) {

  # create a reactive variable

  selected <- reactive({

    req(input$cut, input$clarity, input$color, input$price)
      
      dataset <- diamonds %>%
        dplyr::filter(cut %in% input$cut &
                        clarity %in% input$clarity & color %in% input$color) %>%
        dplyr::filter(dplyr::between(price, input$price[1], input$price[2]))

    return(dataset)

  })

  # RENDER DATA TABLE
  
  output$table <- DT::renderDataTable({
    
DT::datatable(selected(),rownames = T,extensions = 'Buttons',
              caption = htmltools::tags$caption(
                paste("TABLE:  Diamonds Catalogue (price between ",
                      input$price[1],"  &  ",input$price[2],")"),
                        style="font-style:italic;color:grey")
                        )
    })
    
    # RENDER PLOTS
    
    output$plot1 <- renderPlot({
      
      selected() %>%
        ggplot2::ggplot(
          ggplot2::aes(x = cut, y = table)) +
        ggplot2::geom_col(fill="#84456b") +
        ggplot2::labs(
          title = paste("\n\nTotal Table values by Cut\n"),
          subtitle = paste("\nTable: Width of top of diamond relative to widest point\n\n"),
          x = "\nCut", y = "Table\n" ) +
        ggplot2::theme_classic()
      
    })
    
    
    output$plot2 <- renderPlotly({
      
      plotly::ggplotly(
        ggplot2::ggplot(selected(),
                        ggplot2::aes(x = clarity, y = carat)) +
          ggplot2::geom_point(aes(colour = color),alpha = 0.2) +
          ggplot2::labs(
            title = paste("Total Carat values by Clarity\n\n"), x = "\nClarity", y = "Carat\n") +
          ggplot2::theme_classic()
      )
      
    })

})
