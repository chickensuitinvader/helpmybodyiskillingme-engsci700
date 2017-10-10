library(shiny)

# Define UI
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Play with the Model"),
  
  # Sidebar with controls
  sidebarPanel(
    numericInput("tmax", "Time:", 25),
    numericInput("R", "Pathogen Growth Rate:", 30),
    numericInput("K", "Pathogen Clearance Rate:", 100),
    numericInput("P", "Immune System Response to Pathogen:", 70),
    numericInput("S", "Immune System Response to Itself:", 200),
    numericInput("D", "Immune Deactivation:", 100),
    numericInput("FF", "Sensitivity of Health to Immune System:", 60),
    numericInput("G", "Health Recovery:", 100),
    numericInput("J", "Pathogen Damage to Health:", 100)
  ),
  
  # Show the plot of the requested variable against mpg
  mainPanel(
    plotOutput("guessPlot")
  )
))