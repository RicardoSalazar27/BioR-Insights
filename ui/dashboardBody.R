
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
      
      tabName = "sct",
      
      # Selector para el eje x
      selectInput(inputId = "sctx", label = "Eje x", choices = NULL),
      # Selector para el eje y
      selectInput(inputId = "scty", label = "Eje y", choices = NULL),
      # Selector para el color de la línea en el gráfico
      selectInput(inputId = "sctLineColor", label = "Color de la línea",
                  choices = c("Rojo" = "red", "Azul" = "blue", "Verde" = "green")),
      
      downloadButton("sctDownloadPlot", "Descargar Gráfico"),
      
      fileInput(inputId = "sctFile",label =  "Cargar Archivo", accept = ".csv,.xlsx", placeholder ="DIEGO ES GAY"),
      # Salida para el gráfico de dispersión
      plotlyOutput("ScatterPlot"),
      # Salida para la tabla interactiva
      dataTableOutput("sctDataTable")
    ),
    
    
    tabItem(
      
      tabName = "vd",
      
      h1("Venn Diagram"), tableOutput("venn_table")
      
    ),
    
    ####################################
    tabItem(
      
      tabName = "upt",
      
      plotlyOutput("UpSetPlot")
      
    ),
    
    ###################################
    tabItem(
      
      tabName = "bp",
      
      h1("Bar plot")
      
      
    ),
    
    ##################################
    
    tabItem(
      tabName="glp",
      
      )
    
  )
)
