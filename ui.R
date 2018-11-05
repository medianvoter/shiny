# Developing Data Products Shiny Project

# This shiny app demostrates the central limit theorem by allowing the user to 
# select the distribution type, sample size, and number of samples. It then 
# plots the corresponding histogram for the number of random draws or number of
# means. 
# 
# In ui.R, we set up sliders for sample size and number of samples, and radio
# buttons that will allow the user to choose the type of distribution. The 
# available distribution types are those that have been mentioned in the class, 
# normal, uniform, poisson, and exponential. This also includes a "submit"
# button because performing 10,000 draws takes a little time.

library(shiny)

shinyUI(fluidPage(
    titlePanel("Demonstrating the Central Limit Theorem"),
  
    sidebarLayout(
        sidebarPanel(
            h4("Pick sample size"),
            # Sample size slider input
            sliderInput("sampleSize", "Sample size", value = 50, min = 10, max = 100),
            # Number of samples slider input
            h4("Pick number of samples"),
            sliderInput("numSamples", "Number of Samples", value = 1000, 
                        min = 10, max = 10000),
            # Distribution type radio button
            h4("Pick distribution"),
            radioButtons("dist", "Distribution type:",
                         c("Standard Normal" = "norm",
                           "Uniform [0, 1]" = "unif",
                           "Poisson, lambda = 1" = "pois",
                           "Exponential, lambda = 1" = "exp")),
             submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        h2("Site documentation"),
        p("This shiny app demostrates the Central Limit Theorem by allowing the user to select the sample size, number of samples, and distribution type. It then plots the corresponding histogram for the number of random draws or number of means, and allows the user to compare the distribution of the random draws to the distribution of means."),
        h2(textOutput("text1")),
        plotOutput("plot1"),
        h2(textOutput("text2")),
        plotOutput("plot2")
    )
  )
))
