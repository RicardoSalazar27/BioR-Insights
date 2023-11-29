
# Contenido del nuevo archivo R (por ejemplo, "dashboardBody.R")

body <- dashboardBody(
  
  tabItems(
    
    tabItem(
      tabName = "wbr",
      h1("")
    ),
    
    
    #################   Relaciones y Correlación  ####################
    
    tabItem(
      
      tabName = "htm",
      
      h1("Heat Map"),
      plotOutput("heatmap_plot")
      
    ),
    
    #--------------------------------------------------------------------------#
    
    tabItem(
      
      tabName = "sct",
      
      fluidRow(
        column(width = 3,
               fileInput(inputId = "sctFile", label = "Cargar Archivo", accept = ".csv,.xlsx", placeholder = "DIEGO ES GAY")
        ),
        column(width = 3,
               selectInput(inputId = "sctcolorColumn", label = "Columna para Colores", choices = NULL)
        ),
        column(width = 3,
               selectInput(inputId = "slitpx", label = "Eje x", choices = NULL)
        ),
        column(width = 3,
               selectInput(inputId = "slitpy", label = "Eje y", choices = NULL)
        )
      )
      ,
      
      # Salida para el gráfico de dispersión
      plotlyOutput("ScatterPlot"),
      # Salida para la tabla interactiva
      dataTableOutput("sctdataTable")
    ),
    
    #--------------------------------------------------------------------------#
    tabItem(
      
      tabName = "vd",
      
      h1("Venn Diagram"), tableOutput("venn_table")
      
    ),
    
    #--------------------------------------------------------------------------#
    tabItem(
      
      tabName = "upt",
      
      plotlyOutput("UpSetPlot")
      
    ),
    
    
    
    
    #################   Clasificación, rango (ranking)  ####################
    
    tabItem(
      
      tabName = "bc",
      
      fluidRow(
        column(width = 3,
               fileInput(inputId = "bc_file", label = "Cargar archivo CSV", accept = ".csv")
        ),
        column(width = 3,
               selectInput(inputId = "bc_x_col", label = "Seleccionar columna para el eje X", choices = NULL)
        ),
        column(width = 3,
               selectInput(inputId = "bc_y_col", label = "Seleccionar columna para el eje Y", choices = NULL)
        ),
        column(width = 3,
               selectInput(inputId = "bc_color_col", label = "Seleccionar columna para la coloración", "")
        )
      ),
      plotlyOutput("bc_bar_chart"),
      dataTableOutput("bcdataTable")
    ),
    
    
    
    
    
    
    ####################       Parte de un todo    ##########################
    #################   Evolucion y cambios en el tiempo     #####################
    
    
    
    
    
    #############################     Mapas       #############################
    tabItem(
      tabName = "bmp",
      fluidRow(
        column(width = 3,
               selectInput("bbmx_var", "Seleccionar variable para el eje X", "")
        ),
        column(width = 3,
               selectInput("bbmy_var", "Seleccionar variable para el eje Y", "")
        ),
        column(width = 3,
               selectInput("bbmcolor_var", "Seleccionar variable para la coloración", "")
        ),
        column(width = 3,
               selectInput("bbmsize_var", "Seleccionar variable para el tamaño de las burbujas", "")
        )
      ),
      fileInput("bbm_file", "Cargar archivo CSV"),
      plotlyOutput("bubbleChart"),
      DTOutput("bubbledataTable")
    ),
    #--------------------------------------------------------------------------#
    
    
    
    
    
    
    #####################       BASIC CHARTS        ##################
    tabItem(
      tabName = "lp",
      fluidRow(
        column(width = 3,
               fileInput("lp_file", "Subir archivo CSV")
        ),
        column(width = 3,
               checkboxInput("lp_header", "¿El archivo tiene encabezados?", TRUE)
        ),
        column(width = 3,
               selectInput("lpx_column", "Seleccionar columna para el eje X", "")
        ),
        column(width = 3,
               selectInput("lpy_column", "Seleccionar columna para el eje Y", "")
        )
      ),
      plotlyOutput("lp_plot"),
      DTOutput("lp_table")
    ),
    #--------------------------------------------------------------------------#
    tabItem(
      tabName = "dp",
      fluidRow(
        column(width = 3,
               fileInput("dpfile", "Subir archivo CSV")
        ),
        column(width = 3,
               selectInput("dpx_axis", "Seleccionar eje x", "")
        ),
        column(width = 3,
               selectInput("dpy_axis", "Seleccionar eje y", "")
        ),
        column(width = 3,
               selectInput("dpadditional_trace", "Agregar traza adicional", "")
        )
      ),
      fluidRow(
        column(width = 3,
               textInput("dptextinput","ingresa el titulo de tu grafica",placeholder = "titulo")
        ),
        column(width = 3,
               actionButton("dpupdate_plot", "Actualizar gráfico")
        )
      ),
      plotlyOutput("customDotPlot"),
      dataTableOutput("dpdataTable")
    ),
    
    
    
    
    
    
    
    #####################     Statistical Charts      ##################
    tabItem(
      tabName = "his",
      fluidRow(
        column(width = 4,fileInput("hisfile", "Selecciona un archivo CSV")),
        column(width = 4,selectInput("hiscolumna", "Selecciona una columna", "")),
        column(width = 4,helpText("Nota: Asegúrate de que el archivo tenga una columna numérica para el histograma."))
      ),
      plotlyOutput("histograma"),
      dataTableOutput("hisdataTable")
    ),
    
    #--------------------------------------------------------------------------#
    tabItem(
      tabName = "bp",
      fluidRow(
        column(width = 3,fileInput("bpfile", "Seleccionar archivo CSV", accept = ".csv")),
        column(width = 3,selectInput("bpbpx_axis", "Seleccionar eje X:", "")),
        column(width = 3,selectInput("bpy_axis", "Seleccionar eje Y:", "")),
        column(width = 3,selectInput("bpcategory_var", "Seleccionar variable categórica:", ""))
      ),
      plotlyOutput("bpboxplot"),
      DTOutput("bp_dataTable")
    ),
    
    
    
    
    #####################     TRANSFORM      ####################
    tabItem(
      tabName = "gb",
      fluidRow(
        column(width = 3,fileInput("gbfile", "Subir archivo CSV")),
        column(width = 3,selectInput("gbx_axis", "Selecciona el eje X:", "")),
        column(width = 3,selectInput("gby_axis", "Selecciona el eje Y:", "")),
        column(width = 3,selectInput("gbagrupar", "Agrupar por:", ""))
      ),
      plotlyOutput("group_vy"),
      dataTableOutput("gbdataTable")
    )
    
    
    )
  )
