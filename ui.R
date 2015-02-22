
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

choices = c(
     "Fixed acidity" = "fixed.acidity",
     "Volatile acidity" = "volatile.acidity",
     "Citric acid" = "citric.acid",
     "Residual sugar" = "residual.sugar",
     "Chlorides" = "chlorides",
     "Free sulfur dioxide" = "free.sulfur.dioxide",
     "Total sulfur dioxide" = "total.sulfur.dioxide",
     "Density" = "density",
     "pH" = "pH",
     "Sulphates" = "sulphates",
     "Alcohol" = "alcohol",
     "Quality" = "quality"
)

shinyUI(fluidPage(

  # Application title
  titlePanel("Wine Quality Prediction"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      helpText("In this column, select all the attributes for your wine. The 
               attributes will be used for wine quality prediction using a 
               random forest model."),
      helpText("Use ", strong("Update View"), "button to apply changes."),
      br(),
      radioButtons("type", "Select type of wine:",
                   list("White" = "white",
                        "Red" = "red")),
      br(),
      sliderInput("fixed.acidity", "Fixed acidity:",
                  min = 1, max = 15, value = 7),
      sliderInput("volatile.acidity", "Volatile acidity:",
                  min = 0, max = 1.2, value = 0.25),
      sliderInput("citric.acid", "Citric acid:", 
                  min = 0, max = 2, value = 0.3, step = 0.1),
      sliderInput("residual.sugar", "Residual sugar:",
                  min = 0, max = 20, value = 5),
      sliderInput("chlorides", "Chlorides:", 
                  min = 0, max = 0.4, value = 0.04),
      sliderInput("free.sulfur.dioxide", "Free sulfur dioxide:",
                  min = 0, max = 100, value = 35),
      sliderInput("total.sulfur.dioxide", "Total sulfur dioxide:",
                  min = 0, max = 300, value = 140),
      sliderInput("density", "Density:", 
                  min = 0.97, max = 1.04, value = 0.99),
      sliderInput("pH", "pH:",
                  min = 2.4, max = 3.9, value = 3.2),
      sliderInput("sulphates", "Sulphates:",
                  min = 0.2, max = 1.1, value = 0.5),
      sliderInput("alcohol", "Alcohol:", 
                  min = 8, max = 15, value = 10.5),
      submitButton("Update View", icon("refresh")),
      br(),
      helpText("For the visualization of the feature distribution, select 
               variables for the graph on the right. Using the plot, you can 
               do a high-level check if your attributes are inside reasonable
               range."),
      selectInput("axis1", "Select x variable:", choices, 
                  selected = "residual.sugar"),
      selectInput("axis2", "Select y variable:", choices,
                  selected = "alcohol"),
      submitButton("Update View", icon("refresh"))
    ),

    # Show a plot of the generated distribution
    mainPanel(
         h2("Project description"),
         p("The project uses Wine Quality Data Set from UCI Machine Learning
           repository (", 
           a(href="https://archive.ics.uci.edu/ml/datasets/Wine+Quality", "link"),
           ") to classify red and white wines from Portugal based on physiocochemical
           tests."),
         p("Random forest classification model is used without any data
           preprocessing. For the interactive usage of the tool, select wine 
           type and attributes in the side panel. As the output is generally
           not very variable, results of the prediction are given in terms of
           tree votes. You can also check the reasonability of attribute value
           setting by inspecting the scatterplot. Variables for the scatterplot
           can be chosen from drop-down lists in the side panel."),
         p(strong("Important!"), "After each attribute modification, use the
           Update View button to apply changes."),
         h2("Project outputs"),
         h3("Summary of the model:"),
         verbatimTextOutput("model"),
         h3("Prediction of wine quality (RF votes):"),
         p("As the classification results were not generally very variable, we
           show the tree voting in the random forest model. For every quality 
           class, the table contains number of votes it received in the model."),
         uiOutput("quality"),
         h3("Scatter plot of wine attributes distribution:"),
         p("This plot contains all the wines from the database that were 
           used to calibrate the model. You can use is to check reasonability
           of your attribute setting."),
         plotOutput("scatterplot")
    )
  )
))
