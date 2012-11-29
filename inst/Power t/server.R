library(shiny)

t2_power = function(alpha, delta, sigma, n) {
  m = delta/sqrt(2*sigma^2/n)
  cl = qnorm(alpha/2); cu = -cl # z_{1-alpha/2}
  pnorm(cl, m) + pnorm(cu, m, lower.tail = FALSE)
}
shinyServer(function(input, output) {

  output$pwrPlot = reactivePlot(function() {
    n = input$n; s = input$sd; alpha = input$alpha; delta = input$delta
    x0 = qnorm(.005, sd = s); x1 = qnorm(1 - .005, mean = delta, sd = s)
    x = seq(x0, x1, .1)
    par(mar = c(4, 4, .1, .1), mgp = c(2.2, .8, 0), mfrow = c(2, 1), las = 1)
    plot(x, dnorm(x, sd = s), type = 'l', ylab = 'density')
    abline(v = delta, col = 'red')
    lines(x, dnorm(x, mean = delta, sd = s), col = 'blue')
    usr = par('usr')
    rect(usr[2] - .05*(usr[2] - usr[1]), usr[3], usr[2], usr[4], border = 'gray')
    p = t2_power(alpha, delta, s, n)
    rect(usr[2] - .05*(usr[2] - usr[1]), usr[3], usr[2],
         usr[3] + p * (usr[4] - usr[3]), border = NA, col = 'red')
    text(usr[2], (usr[3] + usr[4])/2, sprintf('power = %.02f', p), pos = 2)

    # power curve of delta
    d = seq(0, 10, .1)
    plot(d, 1 - sapply(d, t2_power, alpha = alpha, sigma = s, n = n), type = 'l',
         xlab = 'delta', ylab = 'Probability of accept H0')
    abline(v = delta, col = 'red')
  }, width = 600, height = 550)

})