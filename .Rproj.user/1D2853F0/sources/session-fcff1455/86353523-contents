# Archivo principal de Shiny
# billy

library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
library(ggplot2)
library(DT)

#agrego a la rama desarrollo
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
  
  # Función reactiva para cargar datos desde el archivo CSV
  data <- reactive({
    req(input$file)
    df <- read.csv(input$file$datapath, header = TRUE)
    return(df)
  })
  
  
  # Observador para actualizar las opciones de los selectInput cuando cambian los datos
  observeEvent(data(), {
    if (!is.null(data())) {
      updateSelectInput(session, "slitpx", choices = names(data()))
      updateSelectInput(session, "slitpy", choices = names(data()))
    }
  })
  
  
  # Renderizar el gráfico de dispersión usando ggplot2
  output$ScatterPlot <- renderPlot({
    x <- input$slitpx
    y <- input$slitpy
    
    if (!is.null(x) && !is.null(y)) {
      # Obtener el color seleccionado por el usuario para la línea
      line_color <- input$lineColor
      
      # Crear el gráfico de dispersión con ggplot2
      p <- ggplot(data(), aes_string(x = x, y = y)) +
        geom_point(color = line_color) +  # Aplicar el color a los puntos
        geom_smooth(method = "lm", se = FALSE, color = line_color) +  # Aplicar el color a la línea de tendencia
        labs(title = paste("Scatter Plot of", x, "vs", y), x = x, y = y) +
        theme_minimal()
      
      # Imprimir el gráfico
      print(p)
    }
  })
  
  
  # Renderizar la tabla interactiva usando la biblioteca DT
  output$dataTable <- renderDataTable({
    datatable(data(), 
              rownames = FALSE, #No muestra los nombres de las filas en la tabla.
              extensions = 'Buttons', #Habilita la extensión de botones para la tabla, lo que permite la exportación de datos.
              filter = "top", #Coloca la barra de filtrado en la parte superior de la tabla
              editable = TRUE, #Hace que la tabla sea editable.
              options = list( #Define opciones adicionales para la tabla, como la disposición del DOM, los botones habilitados, el menú de longitud, etc.
                dom = 'Blfrtip', # Controla la disposición de los elementos en la tabla. 'B' significa botones, 'l' significa longitud, 'f' significa búsqueda, 'r' significa procesamiento y 't' significa tabla.
                buttons = c('copy', 'csv', 'excel', 'pdf', 'print'), #Especifica los botones habilitados en la barra de herramientas de la tabla para copiar, exportar en CSV, Excel, PDF y imprimir.
                lengthMenu = list(c(10, 50, 100, -1), c(10, 50, 100, "All")), #Define las opciones de longitud del menú, permitiendo al usuario seleccionar el número de filas mostradas en la tabla.
                initComplete = JS( #Ejecuta una función de JavaScript después de que la tabla se ha inicializado. En este caso, oculta el cuerpo de la tabla al inicio.
                  "function(settings, json) {",
                  "$('.dataTables_scrollBody').hide();",  # Ocultar el cuerpo de la tabla al inicio
                  "}"
                )
              ))
  })
  
  # Manejar la descarga del gráfico como PNG
  output$downloadPlot <- downloadHandler(
    filename = function() {
      # Genera un nombre de archivo para el gráfico descargado
      paste("scatter_plot_", Sys.Date(), ".png", sep = "")
    },
    content = function(file) {
      # Guarda el último gráfico creado en un archivo PNG
      ggsave(file, plot = last_plot(), width = 8, height = 6, dpi = 300)
    }
  )
  
  
  
  ###############      HEATMAP      ##################
  #output$heatmap_plot <- renderPlot({
   # data <- iris[, 1:4]  # Utilizar solo las primeras cuatro columnas del conjunto de datos iris
    
    # Convertir las variables categóricas en variables numéricas
  #  data$Species <- as.numeric(factor(iris$Species))
    
    # Código para generar el heatmap
   # print(str(data))
    #heatmap(as.matrix(data),  # Convertir el marco de datos a matriz numérica
     #       Rowv = NA, Colv = NA, 
      #      col = cm.colors(256),
       #     scale = "column",
        #    margins = c(5, 10),
         #   xlab = "Species",
          #  ylab = "Features",
           # main = "Heatmap of Iris Dataset")
  #})
  
  #################     CATER PLOT CON ARCHIVO DE IRIS    ###########
  
  #output$scatter_plot <- renderPlot({
   # data <- iris[, 1:4]  # Utilizar solo las primeras cuatro columnas del conjunto de datos iris
    
    # Convertir las variables categóricas en variables numéricas
    #data$Species <- as.numeric(factor(iris$Species))
    
    # Modificar los nombres de las columnas si es necesario
    # colnames(data) <- make.names(colnames(data))
    
    # Código para generar el scatter plot
    #plot(data$Sepal.Length, data$Sepal.Width, #estos valores se cambian por el id
      #   col = data$Species, pch = 19,        #de los select inputs que van asociados a    
      #   main = "Scatter Plot of Iris Dataset",   #la grafica
     #    xlab = "Sepal Length", ylab = "Sepal Width")
    #legend("topright", legend = levels(iris$Species), col = 1:3, pch = 19)
  #})
  
  
  
  
  
  
  # Lógica para una tabla
  #output$venn_table <- renderTable({
   # req(input$data_file)  # Asegurarse de que se haya cargado un archivo
    #data <- read.csv(input$data_file$datapath)
    
    # Lógica específica para mostrar una tabla
    # Puedes realizar cualquier procesamiento necesario aquí
    # Por ejemplo, simplemente mostrar los datos leídos
    #data
  #})
  
  
  
  
  # # Lógica para el Scatter Plot
  # output$scatter_plot <- renderPlot({
  #   # Aquí utilizamos los datos leídos del archivo para generar el Scatter Plot
  #   plot(data()$x, data()$y, main = "Scatter Plot")
  # })
  # 
  # # Lógica para el Heatmap
  # output$heatmap_plot <- renderPlot({
  #   # Aquí utilizamos los datos leídos del archivo para generar el Heatmap
  #   heatmap(matrix(rnorm(200), nrow = 20), main = "Heatmap Example")
  # })
  
}




# Run the application 
shinyApp(ui = ui, server = server)
