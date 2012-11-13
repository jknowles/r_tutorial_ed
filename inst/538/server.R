library(shiny)
# data from : http://is-r.tumblr.com/post/35266021903/five-thirty-hate
#election.data <- read.csv("http://www.oberlin.edu/faculty/cdesante/assets/downloads/election2012.csv")
election.data <- read.csv("electiondata.csv")

shinyServer(function(input,output){
  
  output$voteplot<-reactivePlot(function(){
    
    Mode <- function(X) {
      
      XX <- table(as.vector(X))
      names(XX)[XX == max(XX)]
      
    }
    election.data$ERROR<-election.data$ERROR+input$error
    Electoral.Votes <- c()
    for ( i in 1:input$sims)  {
      Election.Draw <- ddply(election.data,
                             .(STATE, OBAMA, ERROR), summarise,
                             P = rnorm(1, OBAMA, ERROR/1.96)
      )
      
      Election.Draw$Win <-  ifelse(Election.Draw$P > 50 , 1, 0)
      Electoral.Votes[i] <- sum(Election.Draw$Win * election.data$COLLEGE)
    }
    
    Winner <- ifelse(Electoral.Votes>=270, "Obama", "Romney")
    P.Obama <- ifelse(Electoral.Votes>=270, 1, 0)
    mean(P.Obama)
    table(Winner)
    Title.Text <- bquote("Probability that Obama Wins the Election:" * " " * .(round(mean(P.Obama), 3)))
    Fill.Title <- c("Projected Winner: \n")
    X.Title <-  bquote("\n \n Electoral College Votes for Obama in" * " " * .(input$sims) * " " * "Simulations")
    Plot1 <- qplot(Electoral.Votes, geom="histogram", binwidth=.5, fill=factor(Winner), alpha=mean(as.numeric(Mode(Electoral.Votes)))) + theme_bw()  + scale_fill_manual(values=c("dodgerblue4", "red"))
    Plot2 <- Plot1    + labs(fill = Fill.Title , title = Title.Text, alpha="Mode of Obama's \n Electoral Votes: \n") + xlab(X.Title)  + ylab("Count \n")
    Plot3 <- Plot2  + guides(alpha = guide_legend("Mode of Obama's \n Electoral Votes: \n",
                                                  override.aes = list(alpha = 0,
                                                                      colour = "white"),
                                                  keywidth = unit(0, "cm")))
    Plot3 <- Plot3 + scale_y_continuous(expand = c(0, 0))
    print(Plot3)
  })
  
  
})