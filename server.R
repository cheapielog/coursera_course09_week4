#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic
shinyServer(function(input, output) {

    # Generate linear model
    model <- reactive({
        min_pts <- input$box1
        brushed_data <- brushedPoints(mtcars,
                                      input$brush1,
                                      xvar = "wt",
                                      yvar = "mpg")
        if(nrow(brushed_data) < min_pts) {
            return(NULL)
            # No fitting for when the data points selected is fewer than min
        }

        lm(mpg ~ wt, data = brushed_data) # Linear model fit
    })

    # Slope display
    output$slopeOut <- renderText({
        if(is.null(model())){
            "No model found. Please ensure the minimum number of data points
            have been selected."
        } else {
            model()[[1]][2]
        }
    })

    # Intercept display
    output$intOut <- renderText({
        if(is.null(model())){
            "No model found. Please ensure the minimum number of data points
            have been selected."
        } else {
            model()[[1]][1]
        }
    })

    # Actual plot of the dataset with linear fitted line
    output$plot1 <- renderPlot({
        plot(mtcars$wt,
             mtcars$mpg,
             xlab = "Weight (1000 lbs)",
             ylab = "MPG (Miles/(US) Gallon)",
             main = "MPG vs Weight",
             cex = 1.5,
             pch = 16,
             bty = "n")
        if(!is.null(model())){
            abline(model(), col = "blue", lwd = 2)
        }
    })
})
