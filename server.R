# Developing Data Products Shiny Project

#' In server.R, I perform the random draws from the stated distribution
#' (assuming) the parameters like mu and sigma (normal), min and max (for unif),
#' and lambda (for poisson and exponential).
#' 
#' It plots two graphs.
#' 
#' Deployed! https://medvoter.shinyapps.io/shiny/

library(shiny)

shinyServer(function(input, output) {

    output$text1 <- renderText(paste("Distribution of", input$numSamples, "draws"))
    output$plot1 <- renderPlot({
        require(ggplot2)
        set.seed(8675309)
        
        if(as.character(input$dist) == "pois") {
            draws <- rpois(input$numSamples, lambda = 1)
        }
        else {
            dist <- switch(input$dist, norm = rnorm, unif = runif, pois = rpois,
                           exp = rexp, rnorm)
            draws <- dist(input$numSamples)
        }
        ggplot(data.frame(draws), aes(x = draws)) +
            geom_histogram(aes(fill = I("grey"), y = ..density..), bins = 50)
    })
    
    output$text2 <- renderText(paste("Distribution of", input$numSamples, 
                                     "means of samples of size", input$sampleSize))
    output$plot2 <- renderPlot({
        require(ggplot2)
        set.seed(8675309)
        
        if(as.character(input$dist) == "pois") {
            vals <- NULL
            for(i in 1:input$numSamples) {
                vals <- rbind(vals, rpois(input$sampleSize, lambda = 1))
            }
        }
        else {
            vals <- NULL
            dist <- switch(input$dist, norm = rnorm, unif = runif, pois = rpois, exp = rexp, rnorm)
            for(i in 1:input$numSamples) {
                vals <- rbind(vals, dist(input$sampleSize))
            }
        }
        means <- rowMeans(vals)
        
        ggplot(data.frame(means), aes(x = means)) + 
            geom_histogram(aes(fill = I("grey"), y = ..density..), bins = 50)
    })
})
