# Script to demonstrate distributions
library(VGAM)
library(eeptools)
library(shiny)
library(ggplot2)




shinyServer(function(input,output){
  mydat <- reactive(function() {
    mydat<-rsnorm(input$obs, location = input$mean, scale =input$variance,
                  shape = input$skew)
    if(input$mode==input$mean){
      return(mydat)
    }
    else if(input$mode!=input$mean){
      a<-table(as.vector(round(mydat)))
      m<-names(a)[a==max(a)]
      v<-max(a)
      mydat2<-mydat[round(mydat)!=as.numeric(m)]
      samp<-sample(mydat[round(mydat)==as.numeric(m)],v*0.8)
      mydat2<-c(mydat2,samp)
      fill<-rep(input$mode,(v-length(samp)))
      mydat<-c(mydat2,fill)
      return(mydat)
    }
  })
  
    output$distPlot<-reactivePlot(function(){
      p <-qplot(mydat(), geom = 'blank') +   
      geom_line(aes(y = ..density.., colour = 'Empirical'), stat = 'density') +  
      stat_function(fun = dnorm, aes(colour = 'Normal')) +                       
      geom_histogram(aes(y = ..density..), alpha = 0.4,binwidth=0.2) +                        
      scale_colour_manual(name = 'Density', values = c('red', 'blue'))+
      theme_dpi()+theme(legend.position = c(0.85, 0.85))
    p<-p+xlim(c(-10,10))+labs(x="data",y="density",title="Distribution of Data")
    print(p)
    
  })
})


