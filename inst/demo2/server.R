library(shiny)
library(ggplot2)
library(eeptools)


load("../../data/smalldata.rda")
shinyServer(function(input,output){

  groupInput<-reactive(function(){
    switch(input$group,
           "race"= 'race',
           "female"= 'factor(female)',
           "disab"= 'factor(disab)',
           "ELL" = 'factor(ell)')
    
  })
  
  dataInput<-reactive(function(){
    if(input$grade=="all"){
      return(df)
    }
    else if (input$grade!="all"){
      df<-subset(df,grade==input$grade)
      return(df)
    }
  })
  
  output$distPlot<-reactivePlot(function(){
    a<-ggplot(dataInput())+geom_point(aes_string(x="readSS",y="mathSS",
                                        group=groupInput(),
                                        color=groupInput()),
                                        alpha=I(0.7))
    a<-a+theme_dpi()+geom_smooth(aes_string(x="readSS",y="mathSS",
                                            group=groupInput(),
                                            color=groupInput()),
                                 se=FALSE,size=I(1.1))
    print(a)#+geom_smooth(aes(alpha=I(1))))
  })
  
  
})