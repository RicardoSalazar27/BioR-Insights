# Contenido del archivo serverLogic.R

# Esta línea debe estar presente al inicio de tu serverLogic.R
# para asegurarte de que se está ejecutando en el contexto correcto
shinyServer(function(input, output, session) {
  
  # Lógica del servidor para el heatmap
  output$heatmap_plot <- renderPlot({
    req(input$file)  # Asegurarse de que el archivo esté cargado
    
    if (input$sidebarItemExpanded == "htm") {
      # Cargar y procesar el archivo de datos (ajustar según tu estructura de datos)
      data <- read.csv(input$file$datapath)
      
      # Código para generar el heatmap
      heatmap(data, 
              Rowv = NA, Colv = NA, 
              col = cm.colors(256),
              scale = "column",
              margins = c(5, 10),
              xlab = "X-axis label",
              ylab = "Y-axis label",
              main = "Heatmap Title")
    }
  })
  
})
