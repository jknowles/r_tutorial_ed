library(shiny)

shinyServer(function(input,output){
  
  output$distPlot<-reactivePlot(function(){
    dist<-rnorm(input$obs)
    p<-qplot(dist,binwidth=0.1)+geom_vline(xintercept=mean(dist))+theme_dpi()
    p<-p+coord_cartesian(xlim=c(-4,4))+geom_vline(xintercept=median(dist),color=I("red"))
    print(p)
  })
  
    
})