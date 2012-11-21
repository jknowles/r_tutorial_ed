library(shiny)
library(ggplot2)
library(eeptools)
library(reshape)
shinyUI(pageWithSidebar(
  
  # Title
  headerPanel("Field Goal Kicking"),
  
  sidebarPanel(
    sliderInput("obs","Number of tries:",
                min=1,max=60,value=10,step=5),
    selectInput("length", "Length in yards:",
                list("all" = "all",
                     "0-19" = "under20", 
                     "20-29" = "twenties", 
                     "30-39" = "thirties",
                     "40-49" = "forties",
                     "50+" = "over50"))),
  
  mainPanel(
    plotOutput("simkicks"),
    tableOutput("summary")
  )
  
  
  
))