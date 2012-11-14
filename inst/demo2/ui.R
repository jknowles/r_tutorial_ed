library(shiny)
library(ggplot2)
library(eeptools)
shinyUI(pageWithSidebar(
  
  # Title
  headerPanel("Student Test Scores"),
  
  sidebarPanel(
    selectInput("grade", "Choose a grade:", 
                choices = c(3,4,5,6,7,8,"all")),
    br(),
    radioButtons("group", "Factor Variable:",
                   list("Race" = "race",
                        "Gender" = "female",
                        "SwD" = "disab",
                        "ELL" = "ell"))
  ),
  
  mainPanel(
    plotOutput("distPlot")
  )
  
  
  
))