# Cargar el paquete UpSetR
library(UpSetR)
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
library(ggplot2)
library(plotly)
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

server <- function(input, output, session) {
  
  options(shiny.maxRequestSize = 500 * 1024^2)  # Establecer el límite de carga en 500 MB
  
  

  ######################       SCATTERPLOT        #########################
  sctdata <- reactive({
    req(input$sctFile)
    df <- read.csv(input$sctFile$datapath, header = TRUE)
    return(df)
  })
  
  # Observador para actualizar las opciones de los selectInput cuando cambian los datos
  observeEvent(sctdata(), {
    if (!is.null(sctdata())) {
      updateSelectInput(session, "slitpx", choices = names(sctdata()))
      updateSelectInput(session, "slitpy", choices = names(sctdata()))
      updateSelectInput(session, "sctcolorColumn", choices = names(sctdata()))
    }
  })
  
  # Renderizar el gráfico de dispersión usando plot_ly
  output$ScatterPlot <- renderPlotly({
    sctx <- input$slitpx
    scty <- input$slitpy
    sctcolor_column <- input$sctcolorColumn
    
    if (!is.null(sctx) && !is.null(scty) && !is.null(sctcolor_column)) {
      sctp <- plot_ly(sctdata(), x = ~get(sctx), y = ~get(scty), type = 'scatter', mode = 'markers',
                      color = ~get(sctcolor_column)) %>% config(scrollZoom = TRUE) %>%
        layout(title = paste("Scatter Plot of", sctx, "vs", scty),
               xaxis = list(title = sctx),
               yaxis = list(title = scty))
      
      sctp
    }
  }) 
  
  # Renderizar la tabla interactiva usando DT
  output$sctdataTable <- renderDataTable({
    sctdata()
  })
  
  
  ################      HEATMAP      #####################
  ################      VENNDIAGRAM        #####################
  ################      UPSET        #####################
  
  
  
  
  
  ################      BARCHART        #####################
  
  # Función para cargar y procesar el archivo CSV
  bc_data <- reactive({
    req(input$bc_file)
    read.csv(input$bc_file$datapath)
  })
  
  # Actualizar las opciones de las columnas cuando se carga un nuevo archivo
  observe({
    bc_data_subset <- bc_data()
    updateSelectInput(session, "bc_x_col", choices = names(bc_data_subset))
    updateSelectInput(session, "bc_y_col", choices = names(bc_data_subset))
    updateSelectInput(session, "bc_color_col", choices = names(bc_data_subset))
  })
  
  # Crear el gráfico de barras
  output$bc_bar_chart <- renderPlotly({
    bc_data_subset <- bc_data()
    
    # Verificar si se ha cargado el archivo CSV
    if (is.null(bc_data_subset)) {
      return(NULL)
    }
    
    # Crear el gráfico de barras con Plotly
    plot_ly(bc_data_subset, x = as.formula(paste0("~", input$bc_x_col)),
            y = as.formula(paste0("~", input$bc_y_col)),
            type = 'bar', color = as.formula(paste0("~", input$bc_color_col))) %>%
      config(scrollZoom = TRUE) %>%
      layout(title = "Bar Chart Interactivo",
             xaxis = list(title = input$bc_x_col),
             yaxis = list(title = input$bc_y_col))
  })
  output$bcdataTable <- renderDataTable({
    bc_data()
  })
  
  
  
  ################      PIECHART        #####################
  ################      STACKED BARPLOT        #####################
  ################      DENOGRAM        #####################
  ################      Scatter And Line Plot       #####################
  ################      choropleth map       #####################
  
  
  
  
  
  
  ################      BUBBLE MAP        #####################
  
  bbmdata <- reactive({
    req(input$bbm_file)
    read.csv(input$bbm_file$datapath)
  })
  
  # Actualizar opciones de variables para ejes y coloración basado en los datos cargados
  observe({
    bbmvar_options <- names(bbmdata())
    updateSelectInput(session, "bbmx_var", choices = bbmvar_options)
    updateSelectInput(session, "bbmy_var", choices = bbmvar_options)
    updateSelectInput(session, "bbmcolor_var", choices = bbmvar_options)
    updateSelectInput(session, "bbmsize_var", choices = bbmvar_options)
  })
  
  output$bubbleChart <- renderPlotly({
    req(input$bbmx_var, input$bbmy_var, input$bbmcolor_var, input$bbmsize_var)
    
    bbmfig <- plot_ly(bbmdata(), x = as.formula(paste("~", input$bbmx_var)),
                      y = as.formula(paste("~", input$bbmy_var)),
                      text = as.formula(paste("~", input$bbmcolor_var)),
                      type = 'scatter', mode = 'markers',
                      size = as.formula(paste("~", input$bbmsize_var)),
                      color = as.formula(paste("~", input$bbmcolor_var)),
                      marker = list(opacity = 0.5, sizemode = 'diameter')) %>% config(scrollZoom = TRUE)
    
    bbmfig <- bbmfig %>% layout(title = 'Bubble Chart Interactivo',
                                xaxis = list(showgrid = FALSE),
                                yaxis = list(showgrid = FALSE),
                                showlegend = FALSE)
    
    bbmfig
  })
  
  output$bubbledataTable <- renderDT({
    datatable(bbmdata())
  })
  
  
  
  
  
  
  ################      DOT PLOT        #####################
  # Cargar datos desde el archivo CSV
  dpdata <- reactiveVal(NULL)
  
  observeEvent(input$dpfile, {
    # Leer el archivo CSV y almacenar los datos en dpdata
    dpdata(read.csv(input$dpfile$datapath))
    
    # Obtener los nombres de las columnas para las opciones de selección
    col_names <- names(dpdata())
    updateSelectInput(session, "dpx_axis", choices = col_names)
    updateSelectInput(session, "dpy_axis", choices = col_names)
    updateSelectInput(session, "dpadditional_trace", choices = col_names)
    updateTextInput(session,"dptextinput")
  })
  
  observeEvent(input$dpupdate_plot, {
    # Crear el dot plot con plot_ly
    output$customDotPlot <- renderPlotly({
      if (!is.null(dpdata())) {
        dpfig <- plot_ly(dpdata(), x = ~get(input$dpx_axis), y = ~get(input$dpy_axis),
                         type = 'scatter', mode = "markers", name = input$dpx_axis) %>% config(scrollZoom = TRUE)
        
        if (input$dpadditional_trace != "") {
          dpfig <- dpfig %>% add_trace(
            x = ~get(input$dpadditional_trace),
            y = ~get(input$dpy_axis),
            type = 'scatter',
            mode = "markers",
            name = input$dpadditional_trace
          )
        }
        
        dpfig <- dpfig %>% layout(
          title = input$dptextinput,
          xaxis = list(title = input$dpx_axis),
          yaxis = list(title = input$dpy_axis)
        )
        dpfig %>% config(scrollZoom = TRUE)
      }
    })
  })
  output$dpdataTable <- renderDataTable({
    dpdata()
  })
  
  ################      LINE PLOT        #####################
  ################      HISTOGRAM        #####################
  
  
  
  
  
  
  ################      BOXPLOT        #####################
  # Cargar datos desde el archivo CSV
  bpdata <- reactive({
    req(input$bpfile)
    read.csv(input$bpfile$datapath)
  })
  
  observe({
    updateSelectInput(session, "bpbpx_axis", choices = names(bpdata()))
    updateSelectInput(session, "bpy_axis", choices = names(bpdata()))
    updateSelectInput(session, "bpcategory_var", choices = names(bpdata()))
    print(numeric_col_names(bpdata()))  # Imprimir columnas numéricas
  })
  
  # Renderizar el boxplot
  output$bpboxplot <- renderPlotly({
    req(input$bpbpx_axis, input$bpy_axis, input$bpcategory_var)
    
    # Crear el boxplot con plot_ly
    bpfig <- plot_ly(bpdata(), x = ~get(input$bpbpx_axis), y = ~get(input$bpy_axis), color = ~get(input$bpcategory_var), type = "box")
    bpfig <- bpfig %>% config(scrollZoom = TRUE)
  })
  
  # Renderizar la tabla
  output$bp_dataTable <- renderDT({
    datatable(bpdata(), options = list(pageLength = 5))
  })
  # Función para obtener solo los nombres de columnas numéricas
  numeric_col_names <- function(bpcategory_var) {
    numeric_cols <- sapply(bpcategory_var, is.numeric)
    names(bpcategory_var)[numeric_cols]
  }
  
  
  
  
  

  ################      GROUPBY       #####################

  # Cargar el archivo CSV cuando se seleccione
  gbdata <- reactive({
    req(input$gbfile)
    read.csv(input$gbfile$datapath)
  })
  
  # Actualizar las opciones de los selectInput basados en el archivo cargado
  observe({
    updateSelectInput(session, "gbx_axis", choices = names(gbdata()))
    updateSelectInput(session, "gby_axis", choices = names(gbdata()))
    updateSelectInput(session, "gbagrupar", choices = names(gbdata()))
  })
  
  output$group_vy <- renderPlotly({
    gbfig <- plot_ly(
      type = 'scatter',
      x = gbdata()[[input$gbx_axis]],
      y = gbdata()[[input$gby_axis]],
      text = paste("Make: ", rownames(gbdata()),
                   "<br>", input$gbx_axis, ": ", gbdata()[[input$gbx_axis]],
                   "<br>", input$gby_axis, ": ", gbdata()[[input$gby_axis]],
                   "<br>", input$gbagrupar, ": ", gbdata()[[input$gbagrupar]]),
      hoverinfo = 'text',
      mode = 'markers',
      transforms = list(
        list(
          type = 'groupby',
          groups = gbdata()[[input$gbagrupar]],
          styles = lapply(unique(gbdata()[[input$gbagrupar]]), function(group) {
            list(target = group, value = list(marker = list(color = sample(colors(), 1))))
          })
        )
      )
    )
    
    # Congbfigurar la leyenda
    gbfig <- gbfig %>%
      layout(
        showlegend = TRUE,
        legend = list(
          title = list(text = input$gbagrupar),
          bgcolor = "#FFFFFF",
          bordercolor = "#FFFFFF",
          borderwidth = 2
        )
      ) %>% config(scrollZoom = TRUE)
    
    gbfig
  })
  
  output$gbdataTable <- renderDataTable({
    gbdata()
  })
  

  
  
    
}

# Run the application 
shinyApp(ui = ui, server = server)
