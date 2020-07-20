#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Linear Model Prediction for MTCARS Dataset"),

    # Sidebar displaying the slope and intercept values
    sidebarLayout(
        sidebarPanel(
            numericInput("box1",
                         "Input minimum number of required data points (2 to 10):",
                         value = 2, min = 2, max = 10, step = 1),
            em(strong("Select data points with your mouse on the graph.")),
            br(),
            br(),
            h5("Slope"),
            textOutput("slopeOut"),
            h5("Intercept"),
            textOutput("intOut")
        ),

        # Show a plot of the data points
        mainPanel(
            plotOutput("plot1",
                       brush = brushOpts(id = "brush1"))
        )
    )
))
