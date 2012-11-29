library(shiny)

shinyServer(function(input, output) {

  N = 30; B0 = runif(1, -5, 5); B1 = runif(1, -5, 5)
  df = local({
    x = seq(-3, 3, length = N)
    data.frame(x = x, y = B0 + B1*x + rnorm(N))
  })

  output$olsPlot = reactivePlot(function() {
    b0 = input$b0; b1 = input$b1
    par(mar = c(4, 4.3, .1, .1))
    plot(y ~ x, data = df, col = 'darkgray', pch = 19)
    abline(b0, b1, col = 'red')
    fit = lm(y ~ x, data = df)
    if (input$showFit) abline(fit)
    usr = par('usr'); y0 = usr[3]; y1 = usr[4]; x0 = usr[1]; x1 = usr[2]
    x2 = x1 - .05 * (x1 - x0)
    rect(x2, y0, x1, y1, border = 'darkgray')
    with(df, {
      res = y - (b0 + b1 * x)  # residuals (not really OLS residuals)
      sst = sum((y - mean(y))^2)
      sse = sum(res^2)
      rect(x2, y0, x1, y0 + sse/sst * (y1 - y0), col = rgb(1, 0, 0, .5), border = NA)
      if (input$showSSE) {
        rect(x2, y0, x1, y0 + sum(resid(fit)^2)/sst * (y1 - y0),
             col = rgb(0, 0, 1, .5), border = NA)
      }
      text(x2, (y0 + y1)/2, sprintf('SSE = %.02f', sse), pos = 2)
      if (input$showResid) {
        segments(x, y, x, y - res, col = 'red', lty = 2)
      }
    })
    }, width = 700, height = 500)

})