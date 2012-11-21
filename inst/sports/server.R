library(shiny)
library(scales)

# obs
# length
dat<-data.frame(dist=c("all","under20","twenties","thirties","forties","over50"),
                att=c(266,6,79,74,85,22),      
                made=c(230,6,76,67,66,15))
dat$per<-dat$made/dat$att
dat$distprob<-dat$att/266


dat2<-data.frame(dist=c("all","under20","twenties","thirties","forties","over50"),
                 att=c(585,10,127,163,169,87),      
                 made=c(481,10,124,152,124,50))

dat2$per<-dat$made/dat$att
dat2$distprob<-dat$att/585



shinyServer(function(input,output){
  groupInput<-reactive(function(){
    switch(input$length,
           "all" = "all",
           "under20" = "under20", 
           "twenties" = "twenties", 
           "thirties" = "thirties",
           "forties" = "forties",
           "over50" = "over50")
    })
  
  trialInput<-reactive(function(){
    prob<-dat$per[dat$dist==groupInput()]
    reps<-input$obs
    trials<-rbinom(500,reps,prob)
  })
  
  
  output$simkicks<-reactivePlot(function(){
    trials<-trialInput()
    reps<-input$obs
    p<-qplot(trials)+theme_dpi()
    print(p)
  })
  
  output$summary <- reactiveTable(function() {
    dat
  })
  
})