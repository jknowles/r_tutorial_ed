library(shiny)
library(scales)

shinyServer(function(input,output){
  trialInput<-reactive(function(){
    bias<-input$coin
    sims<-input$obs
    reps<-input$reps
    trials<-rbinom(reps,sims,0.5+bias)
  })
  
  
  output$payoffplot<-reactivePlot(function(){
    trials<-trialInput()

    df<-data.frame(actor=rep(c("You","Friend"),
                             each=input$reps),
                   payout=c(trials*input$value,(input$obs-trials)*input$bet))
    p<-qplot(payout,data=df,geom='bar')+facet_wrap(~actor)+coord_flip()+theme_dpi()+
      scale_x_continuous(label=dollar)
    print(p)
  })
  
  output$netplot<-reactivePlot(function(){
    trials<-trialInput()
    df2<-data.frame(wins=trials,you=trials*input$value,friend=(input$obs-trials)*input$bet)
    df2$net<-df2$you-df2$friend
    p<-qplot(net,data=df2)+theme_dpi()
    print(p)
  })
  
})

# reps<-500
# bias<-0
# payoff<-50
# cost<-45
# sims<-500
# trials<-rbinom(reps,sims,0.5+bias)
# 
# df<-data.frame(actor=rep(c("You","Friend"),each=reps),payout=c(trials*payoff,(sims-trials)*cost))
# 
# qplot(payout,data=df,geom='bar')+facet_wrap(~actor)+coord_flip()+theme_dpi()+
#   scale_x_continuous(label=dollar)
# 
# df2<-data.frame(wins=trials,you=trials*payoff,friend=(sims-trials)*cost)
# df2$net<-df2$you-df2$friend
# 
# qplot(net,data=df2)
# 
# p<-qplot(dist,binwidth=0.1)+geom_vline(xintercept=mean(dist))+theme_dpi()
# p<-p+coord_cartesian(xlim=c(-4,4))+geom_vline(xintercept=median(dist),color=I("red"))
# print(p)