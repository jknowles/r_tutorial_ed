library(shiny)
library(ggplot2)
library(eeptools)
shinyUI(pageWithSidebar(
  
  # Title
  headerPanel("Normality"),
  
  sidebarPanel(
    sliderInput("obs","Number of observations:",
                min=0,max=1000,value=100),
    br(),
    radioButtons("group", "Factor Variable:",
                   list("Race" = "race",
                        "Gender" = "factor(female)",
                        "SwD" = "factor(disab)",
                        "ELL" = "factor(ell)"))
  ),
  
  mainPanel(
    plotOutput("distPlot")
  )
  
  
  
))