# Archivo principal de Shiny

library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
library(ggplot2)
library(DT)


# Cargar el código de los nuevos archivos
source("ui/dashboardHeader.R")
source("ui/dashboardSidebar.R")
source("ui/dashboardBody.R")

# Define UI for application
ui <- dashboardPage(
  skin = "black",
  header,   # Incluye el dashboardHeader desde el nuevo archivo
  sidebar,  # Incluye el dashboardSidebar desde el nuevo archivo
  body      # Incluye el dashboardBody desde el nuevo archivo
)

# Define server logic required to draw a heatmap
server <- function(input, output, session) {
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)
