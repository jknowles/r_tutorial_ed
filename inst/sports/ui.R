library(shiny)
library(ggplot2)
library(eeptools)
library(reshape)
shinyUI(pageWithSidebar(
  
  # Title
  headerPanel("Field Goal Kicking"),
  
  sidebarPanel(
    sliderInput("obs","Number of tries:",
                min=20,max=200,value=100,step=20),
    selectInput("length", "Length in yards:",
                list("all" = "all",
                     "0-19" = "under20", 
                     "20-29" = "twenties", 
                     "30-39" = "thirties",
                     "40-49" = "forties",
                     "50+" = "over50"))),
  
  mainPanel(
    plotOutput("simkicks"),
    plotOutput("simkicks2"),
    tableOutput("summary"),
    tableOutput("summary2")
  )
  
  
  
))