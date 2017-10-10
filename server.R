library(shiny)
library(deSolve) 
library(ggplot2)

# Define server logic required to plot various variables
shinyServer(function(input, output) {
  
  solveLorenz <- function(pars, times=tout) {
    derivs <- function(t, state, pars) { # returns rate of change
      with(as.list(c(state, pars)), {
        dX <- R*X - K*X*Y
        dY <- P*(X/(1+X^2)) + S*((Y^3)/(1+Y^3)) - D*Y
        dZ <- -FF*Y*Z - G*Z - J*X
        return(list(c(dX, dY, dZ)))
      }
      )
    }
    state <- c(X = 1, Y = 0, Z = 0) #  originally X = 1, Y = 1, Z = 1
    ## ode solves the model by integration...
    return(ode(y = state, times = times, func = derivs, parms = pars))
  }
  
  output$guessPlot <- reactivePlot(function() {
    tout<-seq(0, input$tmax, by = .01)
    guess_pars<-c(R = input$R/100, K = input$K/100, P = input$P/100, 
                  S = input$S/100, D = input$D/100, FF = input$FF/100,
                  G = input$G/100, J = input$J/100)
    #     alpha<-input$alpha
    guess <- as.data.frame(solveLorenz(guess_pars, tout))
    printer <- ggplot(as.data.frame(guess)) + geom_path(aes(X, Z), alpha=1, lwd=.3)
    printer + geom_path(aes(x="Pathogen Level"))
    print(printer)
    #     plot(guess$X, guess$Y)
  })
  
})