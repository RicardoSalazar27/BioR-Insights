
# Contenido del nuevo archivo R (por ejemplo, "dashboardBody.R")

body <- dashboardBody(
  
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
<<<<<<< HEAD
      selectInput(inputId = "sctpx", label = "Eje x", choices = NULL),
      # Selector para el eje y
      selectInput(inputId = "sctpy", label = "Eje y", choices = NULL),
      # Selector para el color de la línea en el gráfico
      selectInput(inputId = "stclineColor", label = "Color de la línea",
                  choices = c("Rojo" = "red", "Azul" = "blue", "Verde" = "green")),
      
      downloadButton("sctDownloadPlot", "Descargar Gráfico"),
=======
      selectInput(inputId = "sctx", label = "Eje x", choices = NULL),
      # Selector para el eje y
      selectInput(inputId = "scty", label = "Eje y", choices = NULL),
      # Selector para el color de la línea en el gráfico
      selectInput(inputId = "sctLineColor", label = "Color de la línea",
                  choices = c("Rojo" = "red", "Azul" = "blue", "Verde" = "green")),
      
      downloadButton("sctDownloadPlot", "Descargar Gráfico"),
      
      fileInput(inputId = "sctFile",label =  "Cargar Archivo", accept = ".csv,.xlsx", placeholder ="DIEGO ES GAY"),
>>>>>>> desarrollo
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
      
      tabName = "bc",
      
      h1("Bar chart"),
      
    ),
    
    ##################################
    
    tabItem(
      tabName="glp",
      
      )
    
  )
)
