# Animations

# Need to generate animations seperately to embed into R

#########################
# 
# http://animation.yihui.name/start
#########################

# Part 1, the mean


# Law of large numbers
library(animation)
saveHTML({
  ani.options(interval = 0.1, nmax = 100)
  par(mar = c(3, 3, 2, 1.5), mgp = c(1.5, 0.5, 0))
  lln.ani(cex = 0.6)
}, img.name = "lln_ani", htmlfile = "lln.ani.html", ani.height = 500, 
         ani.width = 600, title = "Demonstration of the Law of Large Numbers", 
         description = c("The sample mean approaches to the population mean as\nthe sample size n grows."))


# Coin Flip
library(animation)
saveHTML({
  ani.options(interval = 0.2, nmax = 50)
  par(mar = c(2, 3, 2, 1.5), mgp = c(1.5, 0.5, 0))
  flip.coin(faces = c("Head", "Stand", "Tail"), type = "n", 
            prob = c(0.45, 0.1, 0.45), col = c(1, 2, 4))
}, img.name = "flip_coin", htmlfile = "flip.coin.html", ani.height = 500, 
         ani.width = 600, title = "Probability in flipping coins", 
         description = c("This animation has provided a simulation of flipping coins", 
                         "which might be helpful in understanding the concept of probability."))

# CLT
saveHTML({
  ani.options(nmax = 100, interval = 0.1)
  par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0), tcl = -0.3)
  clt.ani(type = "h")
}, img.name = "clt_ani", htmlfile = "clt_ani.html", ani.height = 600, 
         ani.width = 600, outdir = getwd(), title = "Demonstration of the Central Limit Theorem", 
         description = c("This animation shows the distribution of the sample\nmean as the sample size grows."))


# Confidence interval
saveHTML({
  ani.options(nmax = 100, interval = 0.15)
  par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0), tcl = -0.3)
  conf.int()
}, img.name = "conf_int", htmlfile = "conf_int.html", ani.height = 500, 
         ani.width = 600, outdir = getwd(), title = "Demonstration of Confidence Intervals", 
         description = ("This animation shows the concept of the confidence\ninterval which depends on the observations: if the samples change,\nthe interval changes too. At last we can see that the coverage rate\nwill be approximate to the confidence level."))





