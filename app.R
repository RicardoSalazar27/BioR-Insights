# Cargar el paquete UpSetR
library(UpSetR)
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
library(ggplot2)
library(ggVennDiagram)
library(heatmaply)
library(dendextend)
library(viridisLite)
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
  
  hm_data <- reactive({
    req(input$hm_file)
    read.csv(input$hm_file$datapath)
  })
  
  observe({
    
    print(names(hm_data()))
    updateSelectInput(session, "hm_column_x", choices = names(hm_data()))
    updateSelectInput(session, "hm_column_y", choices = names(hm_data()))
    updateSelectInput(session, "hm_column_z", choices = names(hm_data()))
    
  })
  
  output$heatmap <- renderPlotly({
    req(input$hm_column_x %in% names(hm_data()))
    req(input$hm_column_y %in% names(hm_data()))
    req(input$hm_column_z %in% names(hm_data()))
    
    hm_fig <- plot_ly(
      x = ~hm_data()[, input$hm_column_x],
      y = ~hm_data()[, input$hm_column_y],
      z = ~hm_data()[, input$hm_column_z],
      type = "heatmap",
      colorscale = input$hm_color_palette
    )
    
    hm_fig <- hm_fig %>% layout(
      title = paste("Heatmap of", input$hm_column_z),
      xaxis = list(title = input$hm_column_x),
      yaxis = list(title = input$hm_column_y)
    )
    
    return(hm_fig)
    
  })
  
  output$hm_dt <- renderDT({
    datatable(hm_data())
    
  })
  
  ################      VENN DIAGRAM  4D      #####################
 
    vd4_data <- reactive({
      req(input$vd4_file) 
      read.csv(input$vd4_file$datapath)
    })
    
    observe({
      updateSelectInput(session, "vd4_colA", choices = colnames(vd4_data()))
      updateSelectInput(session, "vd4_colB", choices = colnames(vd4_data()))
      updateSelectInput(session, "vd4_colC", choices = colnames(vd4_data()))
      updateSelectInput(session, "vd4_colD", choices = colnames(vd4_data()))
    })
    
    output$vd4vennPlot <- renderPlot({
      vd4_col_names <- c(
        input$vd4_colA,
        input$vd4_colB,
        input$vd4_colC,
        input$vd4_colD
      )
      
      vd4venn_plot <- ggVennDiagram(
        x = list(
          A = vd4_data()[, vd4_col_names[1]],
          B = vd4_data()[, vd4_col_names[2]],
          C = vd4_data()[, vd4_col_names[3]],
          D = vd4_data()[, vd4_col_names[4]]
        ),
        category.names = vd4_col_names
      )
      
      vd4venn_plot + scale_fill_distiller(palette = "Set1")
    })
    output$vd4dtable <- renderDT({
      datatable(vd4_data())
    })
  
  
  ################      UPSET        #####################
  
  # Almacenar los datos cargados
  usdata <- reactive({
    req(input$usfile)
    read.csv(input$usfile$datapath)
  })
  
  # Actualizar las opciones de las variables para el gráfico UpSet
  observe({
    usvar_choices <- names(usdata())
    updateSelectInput(session, "usvar_set", choices = usvar_choices)
  })
  
  # Crear el gráfico UpSet
  output$upsetPlot <- renderPlot({
    req(input$update_plot)
    
    if (is.null(input$usvar_set) || length(input$usvar_set) < 2) {
      return(NULL)
    }
    
    # Seleccionar las variables elegidas por el usuario
    selected_vars <- usdata() %>% select(input$usvar_set)
    
    # Crear el gráfico UpSetR y ordenar "intersection size" de manera decreciente
    upset(selected_vars, main.bar.color = "gray30", matrix.color = "lightgray", order.by = "freq", decreasing = TRUE)
  })
  
  # Crear la tabla interactiva para visualizar el contenido del archivo cargado
  output$upsetTable <- renderDT({
    datatable(usdata())  # Puedes ajustar el número de filas por página según sea necesario
  })
  
  # # Descargar el gráfico al hacer clic en el botón
  # output$download_plot <- downloadHandler(
  #   filename = function() {
  #     paste("upset_plot", Sys.Date(), ".png", sep = "")
  #   },
  #   content = function(file) {
  #     # Guardar el gráfico en formato png
  #     g <- renderPlot({
  #       plot_ly(
  #         type = "bar",
  #         x = ~`Var1`,
  #         y = ~`n`,
  #         data = upset_plot_data$plot,
  #         color = ~`Var1`
  #       )
  #     })
  #     ggsave(file, plot = g(), device = "png", width = 8, height = 6, units = "in")
  #   }
  # )
  
  
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
  
  pc_data <- reactive({
    req(input$pc_file)
    read.csv(input$pc_file$datapath)
  })
  
  observe({
    print(names(pc_data()))
    
    updateSelectInput(session, "pc_column1", choices = names(pc_data()))
    updateSelectInput(session, "pc_column2", choices = names(pc_data()))
    
  })
  
  output$pc_plot <- renderPlotly({
    
    req(input$pc_column1 %in% names(pc_data()))
    req(input$pc_column2 %in% names(pc_data()))
    
    pc_fig <- plot_ly(
      pc_data(),
      labels = ~get(input$pc_column1),
      values = ~get(input$pc_column2),
      type = "pie"
    )
    
    pc_fig <- pc_fig %>% layout(
      title = paste("Pie Chart by", input$pc_column1, "and", input$pc_column2)
    )
    
    return(pc_fig)
    
  })
  
  output$pc_dt <- renderDT({
    datatable(pc_data())
  })
  
  ################      STACKED BAR CHART        #####################
  
  sbc_data <- reactive({
    req(input$sbc_file)
    read.csv(input$sbc_file$datapath, header = input$header, stringsAsFactors = FALSE)
  })
  
  observe({
    updateSelectInput(session, "sbc_column1", choices = names(sbc_data()))
    updateSelectInput(session, "sbc_column2", choices = names(sbc_data()))
    updateSelectInput(session, "sbc_xlabel", choices = names(sbc_data()))
  })
  
  output$sbc_plot <- renderPlotly({
    req(sbc_data(), input$sbc_column1, input$sbc_column2, input$sbc_xlabel)
    
    sbc_fig <- plot_ly(sbc_data(), x = ~get(input$sbc_xlabel), y = ~get(input$sbc_column1),
                       type = 'bar', name = input$sbc_column1, marker = list(color = 'rgba(255, 100, 100, 0.7)'),
                       text = ~paste(input$sbc_column1, ": ", get(input$sbc_column1)))
    sbc_fig <- sbc_fig %>% add_trace(y = ~get(input$sbc_column2), name = input$sbc_column2, marker = list(color = 'rgba(100, 255, 100, 0.7)'),
                                     text = ~paste(input$sbc_column2, ": ", get(input$sbc_column2)))
    sbc_fig <- sbc_fig %>% layout(yaxis = list(title = 'Count'), barmode = 'stack')
    sbc_fig
  })
  output$sbc_dt <- renderDT({
    datatable(sbc_data())
  })
  
  ################      DENOGRAM        #####################
  
  hmdgm_data <- reactive({
    req(input$hmdgm_file)
    read.csv(input$hmdgm_file$datapath, header = TRUE, row.names = 1)
  })
  
  output$hmdgm_plot <- renderPlotly({
    
    row_dend <- as.dendrogram(hclust(dist(hmdgm_data())))
    col_dend <- as.dendrogram(hclust(dist(t(hmdgm_data()))))
    
    hmdgm_selected_palette <- switch(input$hmdgm_palette,
                               "Viridis" = viridisLite::viridis(100),
                               "Rocket" = viridisLite::rocket(100),
                               "Inferno" = viridisLite::inferno(100),
                               "Magma" = viridisLite::magma(100),
                               "Cividis" = viridisLite::cividis(100),
                               "Turbo" =  viridisLite::turbo(100),
                               "Viridis")
    heatmaply(
      hmdgm_data(),
      Rowv = row_dend,
      Colv = col_dend,
      dendrogram = "both",
      width = 600,
      height = 500,
      colors = hmdgm_selected_palette
    )
  })
  output$hmdgm_dt <- renderDT({
    datatable(hmdgm_data())
  })
  
  ################      Scatter And Line Plot       #####################
  
  slp_data <- reactive({
    req(input$slp_file)
    read.csv(input$slp_file$datapath)
  })
  
  observe({
    print(names(slp_data()))
    updateSelectInput(session, "slp_column_y", choices = names(slp_data()))
  })
  
  output$slp_plot <- renderPlotly({
    req(input$slp_column_y %in% names(slp_data()))
    
    slp_x <- seq_len(nrow(slp_data()))
    slp_trace_0 <- rnorm(nrow(slp_data()), mean = 5)
    slp_trace_1 <- rnorm(nrow(slp_data()), mean = 0)
    slp_trace_2 <- rnorm(nrow(slp_data()), mean = -5)
    
    slp_fig <- plot_ly(x = ~slp_x, y = ~slp_data()[, input$slp_column_y], mode = 'lines', name = input$column_y)
    slp_fig <- slp_fig %>% add_trace(x = ~slp_x, y = ~slp_trace_0, name = 'Lines', mode = 'lines')
    slp_fig <- slp_fig %>% add_trace(x = ~slp_x, y = ~slp_trace_1, name = 'Lines+Markers', mode = 'lines+markers')
    slp_fig <- slp_fig %>% add_trace(x = ~slp_x, y = ~slp_trace_2, name = 'Markers', mode = 'markers')
    
    slp_fig <- slp_fig %>% layout(
      title = paste("Scatter Plot of", input$slp_column_y),
      xaxis = list(title = "Index"),
      yaxis = list(title = input$slp_column_y)
    )
    return(slp_fig)
  })
  
  output$slp_table <- renderDT({
    datatable(slp_data())
  })

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
  observe({
    req(input$lp_file)
    
    # Lee el archivo CSV
    lp_data <- read.csv(input$lp_file$datapath, header = input$lp_header)
    
    # Actualiza las opciones de las columnas
    updateSelectInput(session, "lpx_column", choices = colnames(lp_data))
    updateSelectInput(session, "lpy_column", choices = colnames(lp_data))
  })
  
  output$lp_plot <- renderPlotly({
    req(input$lp_file, input$lpx_column, input$lpy_column)
    
    # Lee el archivo CSV
    lp_data <- read.csv(input$lp_file$datapath, header = input$lp_header)
    
    # Crea el gráfico de líneas
    lpfig <- plot_ly(lp_data, x = ~lp_data[[input$lpx_column]], y = ~lp_data[[input$lpy_column]], type = 'scatter', mode = 'lines') %>%
      layout(
        xaxis = list(title = input$lpx_column),
        yaxis = list(title = input$lpy_column),
        title = ""
      ) %>%
      add_lines(line = list(color = 'blue', width = 2, dash = 'solid'))
    
    lpfig <- lpfig %>% config(scrollZoom = TRUE)
  })
  
  output$lp_table <- renderDT({
    req(input$lp_file)
    
    # Lee el archivo CSV
    lp_data <- read.csv(input$lp_file$datapath, header = input$lp_header)
    
    # Muestra la tabla de datos
    datatable(lp_data)
  })
  
  
  
  
  
  ################      HISTOGRAM        #####################
  # Lee el archivo CSV y actualiza las opciones de columna
  hisdatos <- reactive({
    req(input$hisfile)
    read.csv(input$hisfile$datapath)
  })
  
  observe({
    col_options <- names(hisdatos())
    updateSelectInput(session, "hiscolumna", choices = col_options)
  })
  
  # Crea el histograma
  output$histograma <- renderPlotly({
    req(input$hiscolumna)
    
    # Use `req` para asegurarse de que la columna seleccionada esté presente
    
    hisfig <- plot_ly(hisdatos(), x = ~get(input$hiscolumna), type = "histogram") %>%
      layout(xaxis = list(title = input$hiscolumna)) %>%
      config(scrollZoom = TRUE)
    
    hisfig
  })
  
  output$hisdataTable <- renderDataTable({
    hisdatos()
  })
  
  
  
  
  
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
