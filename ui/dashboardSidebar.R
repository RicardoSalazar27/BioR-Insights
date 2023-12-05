

# Contenido del nuevo archivo R (por ejemplo, "sidebar.R")

sidebar <- dashboardSidebar(
  
  sidebarMenu(
    
    menuItem(
      text = "What is BioR Insghts?", tabName = "wbr", icon = icon("th")
    ),
    
    menuItem(text = "Relaciones Y Coorelacion", tabName = "ryc", icon = icon("dashboard"),
             menuSubItem("HeatMap", tabName = "hm", icon = icon("th")),
             menuSubItem("ScatterPlot", tabName = "sct", icon = tags$img(src='scatter-chart.png',height=15)),
             menuSubItem("2D Venn Diagram", tabName = "vd2", icon = tags$img(src='VennDiagram.png',height=15)),
             menuSubItem("3D Venn Diagram", tabName = "vd3", icon = tags$img(src='VennDiagram.png',height=15)),
             menuSubItem("4D Venn Diagram", tabName = "vd4", icon = tags$img(src='VennDiagram.png',height=15)),
             menuSubItem("5D Venn Diagram", tabName = "vd5", icon = tags$img(src='VennDiagram.png',height=15)),
             menuSubItem("Upset", tabName = "upt", icon = icon("th"))
    ),
    menuItem(text = "Clasificacion y ranking", tabName = "cry", icon = icon("th"),
             menuSubItem("Bar chart", tabName = "bc", icon = tags$img(src='bar-chart.png',height=15))
    ),
    menuItem(text = "Part Of a Whole", tabName = "pdt", icon = icon("th"),
             menuSubItem("Pie Chart", tabName = "pc", icon = tags$img(src='pie-chart.png',height =15)),
             menuSubItem("Stacked Bar Chart", tabName = "sbc", icon = icon("th")),
             menuSubItem("HeatMap & Dendrogram", tabName = "hmdgm", icon = tags$img(src='denograma.png',height=15)),
             menuSubItem("Dendrogram", tabName = "ddg", icon = tags$img(src='denograma.png',height=15))
    ),
    menuItem(text = "Evolution In The Time", tabName = "evt", icon = icon("th"),
             menuSubItem("Scatter And Line Plot", tabName = "slp", icon = tags$img(src='linea-puntos.png',height=15))
    ),
    menuItem(text = "Mapas", tabName = "maps", icon = icon("th"),
             menuSubItem("Choropleth map", tabName = "cm", icon = icon("th")),
             menuSubItem("Bubble map", tabName = "bmp", icon = icon("th"))
    ),
    menuItem(text = "Basic Charts", tabName = "bsch",icon = icon("th"),
             menuSubItem("LinePlots", tabName = "lp", icon = tags$img(src='linea-puntos.png',height=15)),
             menuSubItem("DotPlots", tabName = "dp", icon = tags$img(src='dotplot.png',height=15))
    ),
    menuItem(text = "Statistical Charts", tabName = "bsch",icon = icon("th"),
             menuSubItem("Histogram", tabName = "his", icon = tags$img(src='histograma.png',height=15)),
             menuSubItem("BoxPlot", tabName = "bp", icon = tags$img(src='boxplot.png',height=15))
    ),
    menuItem(text = "Tranform", tabName = "trans",icon = icon("th"),
             menuSubItem("GroupBy", tabName = "gb", icon = tags$img(src='groupby.png',height=15))
  ),
  tags$br(),
  menuItem(text = "About Us", tabName = "abu",icon = icon("th"))
)
)