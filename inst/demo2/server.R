library(shiny)
library(ggplot2)
library(eeptools)

shinyServer(function(input,output){
  data(smalldata)
  
  output$distPlot<-reactivePlot(function(){
    a<-qplot(mathSS,readSS,data=df,alpha=I(0.7),group=eval(parse(text=paste(input$group))),
             color=eval(parse(text=paste(input$group))))+theme_dpi()
    print(a+geom_smooth(aes(alpha=I(1))))
  })
  
  
})