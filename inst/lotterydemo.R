################################################################################
# Run a simple lottery in class
################################################################################
library(data.table)
"%w/o%" <- function(x, y) x[!x %in% y] #--  x without y

class <- data.frame(name=c("Joe", "Judy", "John", "Jeff"), 
                    ball1 = c(2, 5, 4, 3), ball2 = c(3, 4, 3, 2), 
                    ball3 = c(1, 5, 1, 3), powerball = c(1, 3, 2, 1))

N <- 300


sim <- data.frame(trial = c(1:N), ball1 = sample(1:6, N, replace=TRUE))
sim <- as.data.table(sim)
sim <- sim[, ball2:=sample(1:6 %w/o% ball1, 1, replace=FALSE), by="trial"]
sim <- sim[, ball3:=sample(1:6 %w/o% ball1 %w/o% ball2, 1, replace=FALSE), by="trial"]
sim <- sim[, powerball:=sample(1:4, 1, replace=FALSE), by="trial"]
sim <- as.data.frame(sim)

ball1 <- 3
ball2 <- 5
ball3 <- 2
sim$test <- ball1 == sim$ball1 | ball1 ==sim$ball2 |
  ball1 ==sim$ball3

sim$test2 <- ball2 == sim$ball1 | ball2 ==sim$ball2 |
  ball2 ==sim$ball3

sim$test3 <- ball3 == sim$ball1 | ball3 ==sim$ball2 |
  ball3 ==sim$ball3

sim$chance <- FALSE
sim$chance[sim$test==TRUE & sim$test2==TRUE & sim$test3==TRUE] <- TRUE

powerball <- 1
sim$win <- FALSE
sim$win[sim$chance==TRUE & sim$powerball==powerball] <- TRUE

checkWin <- function(name, N, lookup, sim){
  ball1 <- lookup$ball1[lookup$name==name]
  ball2 <- lookup$ball2[lookup$name==name]
  ball3 <- lookup$ball3[lookup$name==name]
  powerball <- lookup$powerball[lookup$name==name]
  
  if(missing(sim)){
    sim <- data.frame(trial = c(1:N), ball1 = sample(1:6, N, replace=TRUE))
    sim <- as.data.table(sim)
    sim <- sim[, ball2:=sample(1:6 %w/o% ball1, 1, replace=FALSE), by="trial"]
    sim <- sim[, ball3:=sample(1:6 %w/o% ball1 %w/o% ball2, 1, replace=FALSE), by="trial"]
    sim <- sim[, powerball:=sample(1:4, 1, replace=FALSE), by="trial"]
    sim <- as.data.frame(sim)
  }
  
  test <- paste(ball1 , ball2, ball3)
  sim$match <- match(test, paste(sim$ball1, sim$ball2, sim$ball3))
  
  sim$test <- ball1 == sim$ball1 | ball1 ==sim$ball2 |
    ball1 ==sim$ball3
  
  sim$test2 <- ball2 == sim$ball1 | ball2 ==sim$ball2 |
    ball2 ==sim$ball3
  
  sim$test3 <- ball3 == sim$ball1 | ball3 ==sim$ball2 |
    ball3 ==sim$ball3
  
  sim$chance <- FALSE
  sim$chance[sim$test==TRUE & sim$test2==TRUE & sim$test3==TRUE] <- TRUE
  
  sim$win <- FALSE
  sim$win[sim$chance==TRUE & sim$powerball==powerball] <- TRUE
  
  if(!missing(sim)){
    N <- nrow(sim)
  }
  
  return(list(Wins = sum(sim$win), Proportion = sum(sim$win)/N, 
              "Wins Without PowerBall" = sum(sim$chance), 
              "Prop. Without PowerBall" = sum(sim$chance)/N,
         "First Win" = min(sim$trial[sim$win==TRUE])))
}


checkWin("John", 10000, lookup=class)

# Expected probability
length(unique(sim$ball1))
length(unique(sim$ball2))
length(unique(sim$ball3))



N <- length(unique(sim$ball1))
K <- 3
P <- length(unique(sim$powerball))

# n = number to draw from (e.g. pick 1-6)
# k = number of draws user takes
# p = number of choices in the bonus ball pool
# b = number of balls that will be matched

lottoExp <- function(n, k, p, b){
  ((1/p) * choose(k, b) * choose(n-k, k-b)) / choose(n, k)
}


lottoExp(6, 3, 4, 3)



