
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(dplyr)
library(ggplot2)
library(randomForest)
library(Hmisc)

wineWhite <- read.csv('./winequality-white.csv', sep = ";")
wineRed <- read.csv('./winequality-red.csv', sep = ";")

wineWhite$quality <- as.factor(wineWhite$quality)
wineRed$quality <- as.factor(wineRed$quality)

modRF.white <- randomForest(quality ~ ., data = wineWhite, ntree = 200,
                            importance = TRUE)

modRF.red <- randomForest(quality ~ ., data = wineRed, ntree = 200,
                          importance = TRUE)

shinyServer(function(input, output) {
     
     newdata <- reactive({data.frame(
          fixed.acidity = input$fixed.acidity,
          volatile.acidity = input$volatile.acidity,
          citric.acid = input$citric.acid,
          residual.sugar = input$residual.sugar,
          chlorides = input$chlorides,
          free.sulfur.dioxide = input$free.sulfur.dioxide,
          total.sulfur.dioxide = input$total.sulfur.dioxide,
          density = input$density,
          pH = input$pH,
          sulphates = input$sulphates,
          alcohol = input$alcohol)
     })
     
     quality <- reactive({
          
     })
     
     output$scatterplot <- renderPlot({
          if(input$type == "white") {
               ggplot(data = wineWhite, 
                      aes_string(x = input$axis1, y = input$axis2)) + 
                    geom_point(alpha = 0.2) + 
                    geom_point(data = data.frame(newdata(), 
                                   quality = predict(modRF.white, newdata())),
                               aes_string(x = input$axis1, y = input$axis2),
                               color = "red", size = 5, alpha = .8) + 
                    xlab(capitalize(gsub("\\.", " ", input$axis1))) +
                    ylab(capitalize(gsub("\\.", " ", input$axis2)))
          } else {
               ggplot(data = wineRed, 
                      aes_string(x = input$axis1, y = input$axis2)) + 
                    geom_point(alpha = 0.2) + 
                    geom_point(data = data.frame(newdata(), 
                                   quality = predict(modRF.red, newdata())),
                               aes_string(x = input$axis1, y = input$axis2),
                               color = "red", size = 5, alpha = .8) + 
                    xlab(capitalize(gsub("\\.", " ", input$axis1))) +
                    ylab(capitalize(gsub("\\.", " ", input$axis2)))
          }
     })
     
     output$model <- renderPrint({
          if(input$type == "white") {
               modRF.white
          } else {
               modRF.red
          }
     })
     
     output$quality <- renderTable(
          expr = if(input$type == "white") {
               predict(modRF.white, newdata(), type = "vote", norm.votes = F)
          } else {
               predict(modRF.red, newdata(), type = "vote", norm.votes = F)
          },
          digits = 0
     )

     }
)
