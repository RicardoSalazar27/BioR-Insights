
# Contenido del nuevo archivo R (por ejemplo, "dashboardBody.R")

body <- dashboardBody(
  
  #selectInput("x_var", "Variable X", ""),
  #selectInput("y_var", "Variable Y", ""),
  #selectInput("color_var", "Color variable", ""),
  #actionButton("update_plot", "Actualizar Plot")
  # 
  # h1("ESTE ES EL DASHBOARD BODY"),
  tabItems(
    
    tabItem(
      tabName = "wbr",
      h1("")
    ),
    
    tabItem(
      
      tabName = "htm",
      
      h1("Heat Map"),
      plotOutput("heatmap_plot")
      
    ),
    
    tabItem(
      
      tabName = "stp",
      
      # Selector para el eje x
      selectInput(inputId = "slitpx", label = "Eje x", choices = NULL),
      # Selector para el eje y
      selectInput(inputId = "slitpy", label = "Eje y", choices = NULL),
      # Selector para el color de la línea en el gráfico
      selectInput(inputId = "lineColor", label = "Color de la línea",
                  choices = c("Rojo" = "red", "Azul" = "blue", "Verde" = "green")),
      
      downloadButton("downloadPlot", "Descargar Gráfico"),
      # Salida para el gráfico de dispersión
      plotOutput("ScatterPlot"),
      # Salida para la tabla interactiva
      dataTableOutput("dataTable")
    ),
    
    
    tabItem(
      
      tabName = "vd",
      
      h1("Venn Diagram"), tableOutput("venn_table")
      
    ),
    
    ####################################
    tabItem(
      
      tabName = "upt",
      
      h1("UpSet")
      
    ),
    
    ###################################
    tabItem(
      
      tabName = "bp",
      
      h1("Bar plot")
      
      
    )
    
  )
)
