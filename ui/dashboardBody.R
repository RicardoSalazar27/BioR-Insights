
# Contenido del nuevo archivo R (por ejemplo, "dashboardBody.R")

body <- dashboardBody(
  
  tabItems(
  
    tabItem(
      tabName = "wbr",
      tags$div(
        class = "page-container",
        tags$div(
          class = "custom-header",
          tags$img(src = "logo2.png", class ="logop"),
          tags$div(
            tags$div("BioR Insights", class = "custom-h1"),
            tags$div("Transformando el Análisis Bioinformático", class = "custom-sub")
          , class = "titulosimg"),
        ),
        
        tags$div(
          class = "custom-section",
          tags$div(
            class = "custom-p",
            "Bienvenido a ",
            tags$span("BioR Insights", class = "highlight-text"),
            ", la plataforma que simplifica y democratiza el análisis de datos biológicos. 
        En un mundo donde la bioinformática desempeña un papel crucial, hemos creado una herramienta 
        potente pero fácil de usar para que tanto expertos como principiantes exploren el vasto mundo de la 
        información genómica."
          ),
          
          tags$div(
            class = "custom-p",
            "Enfrentamos el desafío de hacer que la bioinformática sea ",
            tags$span("accesible", class = "highlight-text"),
            " para todos. Nuestra interfaz intuitiva te permite cargar conjuntos de datos biológicos con facilidad 
        y configurar análisis de manera sencilla, sin necesidad de conocimientos especializados."
          ),
          
          tags$div(
            class = "custom-p",
            "¿Qué te ofrece ",
            tags$span("BioR Insights", class = "highlight-text"),
            "?"
          ),
          
          tags$ul(
            class = "custom-list",
            tags$li(
              tags$span("Análisis de Expresión Génica:", class = "highlight-text"),
              " Comprende la actividad de los genes de manera fácil y efectiva."
            ),
            tags$li(
              tags$span("Agrupamiento Jerárquico:", class = "highlight-text"),
              " Explora patrones y relaciones en tus datos biológicos."
            ),
            tags$li(
              tags$span("Visualizaciones Impactantes:", class = "highlight-text"),
              " Gráficos y representaciones visuales para interpretar resultados de manera rápida."
            ),
            tags$li(
              tags$span("Exportación Versátil:", class = "highlight-text"),
              " Exporta resultados en formatos como CSV, imágenes y documentos PDF."
            )
          ),
          tags$div(
            class = "custom-p",
            "En ",
            tags$span("BioR Insights", class = "highlight-text"),
            ", nos apasiona acelerar la ",
            tags$span("investigación científica", class = "highlight-text"),
            " al hacer que las herramientas de análisis sean más accesibles. Nuestro enfoque no solo ahorra tiempo, 
        sino que también optimiza los recursos, permitiendo decisiones más rápidas y fundamentadas en la investigación biológica y médica."
          )
        ),
        
        tags$style(HTML("
      .page-container {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
        color: black;
      }

      .custom-header {
        color: black;
        margin-left: 4%;
        display: flex;
        font-size: 200%;
      }

      .logop {
        max-width: 120px;
        margin-right: 10px;
      }
      
      .titulosimg{
        align-self : center;
      }

      .custom-section {
            max-width: 90%;
            margin: 2% auto;
            pading : 2%
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
      }

      .custom-h1 {
        color: rgb(26, 188, 156);
        margin-bottom: 1%;
        font-size : 90%;
      }
      
      .custom-p {
        line-height: 1.6;
        font-size: 110%;
      }

      .highlight-text {
        color: #222d32;
        font-weight: bold;
      }
      .highlight-text2{
        color: white;
        font-weight : bold;
      }
      
      .custom-list li {
         margin :1%;
         font-size : 105%;
      }
      .custom-footer {
          background-color: #222d32;
          color: white;
          padding: 1em 0;
          text-align: center;
          position: fixed;
          bottom: 0;
          width: 100%;
          padding-right:8%
      }
.content {
    min-height: 250px;
    padding: 15px;
    margin-right: auto;
    margin-left: auto;
    padding-left: 0px;
    padding-right: 15px;
}
.row{
margin-left: 0;
}
    " )
     )
    )
   ),
    
    
    #################   Relaciones y Correlación  ####################
   # heatmap 
   tabItem(
      
      tabName = "hm",
      
      fluidRow(
        column(width = 2,
      fileInput(
        "hm_file",
        label = "Select a CSV file",
        accept = (".csv")
      )),
      
      column(width = 2, 
      selectInput(
        inputId = "hm_column_x",
        label = "Select X Axis Column",
        choices = NULL
      )),
      
      column(width = 2, 
      selectInput(
        inputId = "hm_column_y",
        label = "Select Y Axis Column",
        choices = NULL
      )),
      column(width = 2, 
      selectInput(
        inputId = "hm_column_z",
        label = "Select Z Axis Column",
        choices = NULL
      )),
      column(width = 2, 
      selectInput(
        inputId = "hm_color_palette",
        label = "Select Color Palette",
        choices = c(
          "Viridis", "YlOrRd", "Blues", "Reds", "Greens",
          "Purples", "Oranges", "BuGn", "YlGnBu", "RdPu"
      ))
      )
      ),
        plotlyOutput("heatmap"),
        DTOutput("hm_dt")
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
   # 2D VENN DIAGRAM
   tabItem(
     tabName = "vd",
     tabsetPanel(
       tabPanel("2 Dimensions", 
                fluidRow(
                  column(width = 2,
                         fileInput("vd2_file", "Upload a CSV file")
                  ),
                  
                  column(width = 2,
                         selectInput("vd2_colA", "Column A", "")
                  ),
                  
                  column(width = 2,
                         selectInput("vd2_colB", "Column B", "")
                  ),
                ),
                plotOutput("vd2_plot"),
                DTOutput("vd2_dt")
                
       ),
       tabPanel("3 Dimensions",
                  fluidRow(
                    column(width = 2,
                           fileInput("vd3_file", "Upload a CSV file")
                    ),

                    column(width = 2,
                           selectInput("vd3_colA", "Column A", "")
                    ),

                    column(width = 2,
                           selectInput("vd3_colB", "Column B", "")
                    ),

                    column(width = 2,
                           selectInput("vd3_colC", "Column C", "")
                    ),
                  ),
                  plotOutput("vd3vennPlot"),
                  DTOutput("vd3dtable")
                ),
       tabPanel("4 Dimensions",
                fluidRow(
                       column(width = 2,
                              fileInput(inputId = "vd4_file", "Upload a CSV file")
                       ),
                       column(width = 2,
                              selectInput(inputId = "vd4_colA", "Column A", "")
                       ),
                       column(width = 2,
                              selectInput(inputId = "vd4_colB", "Column B", "")
                       ),
                       column(width = 2,
                              selectInput(inputId = "vd4_colC", "Column C", "")
                       ),
                       column(width = 2,
                              selectInput(inputId = "vd4_colD", "Column D", "")
                     )),
                     plotOutput("vd4vennPlot"),
                     DTOutput("vd4dtable")
                ),
       tabPanel("5 Dimensions",
                fluidRow(
                      column(width = 2,
                             fileInput("vd5_file", "Upload a CSV file")
                      ),

                      column(width = 2,
                             selectInput("vd5_colA", "Column A", "")
                      ),

                      column(width = 2,
                             selectInput("vd5_colB", "Column B", "")
                      ),

                      column(width = 2,
                             selectInput("vd5_colC", "Column C", "")
                      ),

                      column(width = 2,
                             selectInput("vd5_colD", "Column D", "")
                      ),

                      column(width = 2,
                             selectInput("vd5_colF", "Column F", "")
                      ),
                    ),
                    plotOutput("vd5_vennPlot"),
                    DTOutput("vd5_dt")
                )
       
     )
   ),
   
    #--------------------------------------------------------------------------#
    tabItem(
      
      tabName = "upt",
      fluidRow(
        column(width = 4,fileInput("usfile", "Seleccione un archivo CSV")
        ),
        column(width = 4,selectInput("usvar_set", "Seleccione las variables para el UpSet", choices = NULL, multiple = TRUE)
        ),
        column(width = 4,actionButton("update_plot", "Actualizar Gráfico"))
      ),
      #downloadButton("download_plot", "Descargar Gráfico"),
      
      plotOutput("upsetPlot"),
      DTOutput("upsetTable")
      
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
    
    
    
    
    
    
    ####################       Parte de un todo    ###########################
   # PieChart
   tabItem(
     tabName = "pc",
     fluidRow(
     column(width = 2,
            fileInput(
              "pc_file",
              label = "Select a CSV file",
              accept = c(".csv")
            )
     ),
     
     column(width = 2,
            selectInput(
              inputId = "pc_column1",
              label = "Column 1",
              choices = NULL
            )
     ),
     
     column(width = 2,
            selectInput(
              inputId = "pc_column2",
              label = "Column 2",
              choices = NULL
            )
     ),

     mainPanel(
       plotlyOutput("pc_plot"),
       DTOutput("pc_dt")
     )
   )),
   
   
   # ---------------------------------------------------------------------------
   # Stacked Bar Chart
   
   tabItem(
     tabName = "sbc",
     fluidRow(
       column(width = 2,
              fileInput("sbc_file", "Upload CSV file")
       ),
       
       column(width = 2,
              selectInput("sbc_column1", "Select fist data column", "")
       ),
       
       column(width = 2,
              selectInput("sbc_column2", "Select second data column", "")
       ),
       
       column(width = 2,
              selectInput("sbc_xlabel", "X Data Labels", "")
       ),
       
       column(width = 2,
              checkboxInput("header", "Does file have letters?", TRUE)
       ),
       
       mainPanel(
         plotlyOutput("sbc_plot"),
         DTOutput("sbc_dt")
     )
   )),
   
   # --------------------------------------------------------------------------
   # Heatmap & Dendrogram
   tabItem(
     tabName = "hmdgm",
     fluidRow(
       column(width = 2,
              fileInput("hmdgm_file", "Upload CSV file", accept = ".csv"),
              helpText("Be sure your file has the correct format.")
       ),
       
         column(width = 2,
                selectInput("hmdgm_palette", "Select color palette:",
                            choices = c("Viridis", "Rocket", "Inferno", "Magma", "Cividis", "Turbo"),
                            selected = "Viridis")
         )),
                plotlyOutput("hmdgm_plot"),
                DTOutput("hmdgm_dt")
         ),
   
   # ----------------------------------------------------------------------------
   # Dendrogram
   tabItem(
     tabName = "ddg",
     fluidRow(
       column(width = 2,
              fileInput("ddg_file", "Select CSV file", accept = ".csv")
       ),
       
       column(width = 2,
              selectInput("ddg_y_axis", "Select column for Y axis", "")
       ),
       
       column(width = 2,
              selectInput("ddg_x_axis", "Select column for X axis", "")
       ),
     ),
     plotlyOutput("ddg_plot")
   ),
   
   # -----------------------------------------------------------------------------
    #################   Evolucion y cambios en el tiempo     #################
   
   # scatter and line plot
   tabItem(
     
     tabName = "slp",
     fluidRow(
       column(width = 2,
              fileInput("slp_file", "Select a CSV file", accept = (".csv"))),
       
       column(width = 2,
              selectInput("slp_column_y","Select a Column", choices = NULL)),
     ),
     plotlyOutput("slp_plot"),
     DTOutput("slp_table")
   ),
    
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
    ),
    
   ##########################################################################
    tabItem(
      tabName = "pca",
      fluidRow(
        column(width = 2,
               fileInput("pca_file", "Choose a CSV file")
        ),
        
        column(width = 2,
               selectInput("pca_x_axis", "Choose X-axis:", "")
        ),
        
        column(width = 2,
               selectInput("pca_y_axis", "Choose Y-axis:", "")
        ),
      ),
      plotlyOutput("pcaPlot"),
      DTOutput("pca_dt")
      ),
   #########################################################################
    tabItem(
      tabName = "abu",
      tags$div(
        tags$h1("Who are involved is BioR Insights?", class = "titulo-principal"),
        tags$style(HTML("
      .titulo-principal {
        font-size: 2rem;
        text-align: center;
        font-weight: bold;
      }

      html {
        box-sizing: border-box;
      }

      *,
      *:before,
      *:after {
        box-sizing: inherit;
      }

      .imgperfil {
        max-width: 30%;
      }

      .subtitulo {
        font-size: 1.5rem;
      }

      .contenedor {
        max-width: 1200px;
        width: 95%;
        margin: 0 auto;
        text-align: center;
      }

      .entrada-blog a {
        display: inline-block;
        background-color: aliceblue;
        color: black;
        padding: 10px 20px;
        text-decoration: none;
        font-weight: bold;
        text-transform: uppercase;
        font-size: 1rem;
      }

      @media (min-width: 768px) {
        .dos-columnas {
          display: grid;
          grid-template-columns: 50% 50%;
          column-gap: 2rem;
          padding: 3%;
          padding-top: 0;
          width: 80%;
          height: 40%;
        }

        .entrada-blog {
          padding-bottom: 5%;
        }
      }
    ")),
        tags$div(
          class = "contenedor dos-columnas",
          tags$article(
            class = "entrada-blog",
            tags$img(src = "RicardoSalazar.png", class = "imgperfil"),
            tags$h2("Ing.Edgar Ricardo Salazar Sesenes", class = "subtitulo"),
            tags$p("Maecenas maximus urna vitae nisl semper, id volutpat ipsum scelerisque. Aenean nec ipsum finibus,
          eleifend dolor at, venenatis risus. Quisque varius orci et augue scelerisque luctus.", class = "parrafo"),
            tags$a(href = "https://github.com/RicardoSalazar27", "Leer más", class = "enlace")
          ),
          tags$article(
            class = "entrada-blog",
            tags$img(src = "GaelVillalobos.png", class = "imgperfil"),
            tags$h2("Ing.Cristian Gael Guerrero Villalobos", class = "subtitulo"),
            tags$p("Maecenas maximus urna vitae nisl semper, id volutpat ipsum scelerisque. Aenean nec ipsum finibus,
          eleifend dolor at, venenatis risus. Quisque varius orci et augue scelerisque luctus.", class = "parrafo"),
            tags$a(href = "https://github.com/xtiangro", "Leer más", class = "enlace")
          ),
          tags$article(
            class = "entrada-blog",
            tags$img(src = "MiguelVillalobos.png", class = "imgperfil"),
            tags$h2("Dr.Miguel Angel Villalobos", class = "subtitulo"),
            tags$p("Maecenas maximus urna vitae nisl semper, id volutpat ipsum scelerisque. Aenean nec ipsum finibus,
          eleifend dolor at, venenatis risus. Quisque varius orci et augue scelerisque luctus.", class = "parrafo"),
            tags$a("#", "Leer más", class = "enlace")
          ),
          tags$article(
            class = "entrada-blog",
            tags$img(src = "ValentinGordillo.png", class = "imgperfil"),
            tags$h2("Dr.Santiago Valentin Galvan Gordillo", class = "subtitulo"),
            tags$p("Maecenas maximus urna vitae nisl semper, id volutpat ipsum scelerisque. Aenean nec ipsum finibus,
          eleifend dolor at, venenatis risus. Quisque varius orci et augue scelerisque luctus.", class = "parrafo"),
            tags$a("#", "Leer más", class = "enlace")
          )
        )
      )
    )
  ),
  tags$div(
    class = "custom-footer",
    tags$p(
      "&copy; 2023 ",
      tags$span("BioR Insights", class = "highlight-text2"),
      " - Plataforma de Análisis Bioinformático"
    )
  )
)
