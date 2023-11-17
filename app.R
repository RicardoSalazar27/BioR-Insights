# Cargar el paquete UpSetR
library(UpSetR)
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
library(ggplot2)
library(plotly)
library(DT)

# Cargar el código del servidor desde scatterplot.r
# source("Graficos/Clasificacion Y Rango/scatterplot.R")
# source("Graficos/Clasificacion Y Rango/upset.R")
# source("Graficos/Evolucion Y Cambios en el tiempo/GraficoDeLineasYPuntos.R")

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

server <- function(input, output, session) {
  
  
  
  
  ######################       SCATTERPLOT        #########################
  sctData <- reactive({
    req(input$sctFile)
    sctDf <- read.csv(input$sctFile$datapath, header = TRUE)
    return(sctDf)
  })
  
  # Observador para actualizar las opciones de los selectInput cuando cambian los datos
  observeEvent(sctData(), {
    if (!is.null(sctData())) {
      updateSelectInput(session, "sctx", choices = names(sctData()))
      updateSelectInput(session, "scty", choices = names(sctData()))
    }
  })
  
  output$ScatterPlot <- renderPlotly({
    sctX <- input$sctx
    sctY <- input$scty
    
    # Mensajes de depuración
    cat("sctX:", sctX, "\n")
    cat("sctY:", sctY, "\n")
    
    if (!is.null(sctX) && !is.null(sctY)) {
      # Obtener el color seleccionado por el usuario para la línea
      sctLine_color <- input$sctLineColor
      
      # Crear el gráfico de dispersión con ggplot2
      sctP <- ggplot(sctData(), aes_string(x = sctX, y = sctY)) +
        geom_point(color = sctLine_color) +  # Aplicar el color a los puntos
        geom_smooth(method = "lm", se = FALSE, color = sctLine_color) +  # Aplicar el color a la línea de tendencia
        labs(title = paste("Scatter Plot of", sctX, "vs", sctY), x = sctX, y = sctY) +
        theme_minimal()
      
      # Convertir ggplot a plotly
      sctP <- ggplotly(sctP)
      
      # Imprimir el gráfico
      print(sctP)
    }
  })
  
  # Renderizar la tabla interactiva usando la biblioteca DT
  output$sctDataTable <- renderDataTable({
    datatable(sctData(),
              rownames = FALSE,
              extensions = 'Buttons',
              filter = "top",
              editable = TRUE,
              options = list(
                dom = 'Blfrtip',
                buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
                lengthMenu = list(c(10, 50, 100, -1), c(10, 50, 100, "All")),
                initComplete = JS(
                  "function(settings, json) {",
                  "$('.dataTables_scrollBody').hide();",
                  "}"
                )
              ))
  })
  
  
  ################      HEATMAP      #####################
  ################      UPSET        #####################
}

# Run the application 
shinyApp(ui = ui, server = server)
