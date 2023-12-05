

# Contenido del nuevo archivo R (por ejemplo, "sidebar.R")

sidebar <- dashboardSidebar(
  
  sidebarMenu(
    
    menuItem(
      text = "What is BioR Insghts?", tabName = "wbr", icon = icon("info")
    ),
    
    menuItem(text = "Connections and correlation", tabName = "ryc", icon = icon("barcode"),
             menuSubItem("HeatMap", tabName = "hm", icon = icon("th")),
             menuSubItem("ScatterPlot", tabName = "sct", icon = tags$img(src='scatter-chart.png',height=15)),
             menuSubItem("Venn Diagram", tabName = "vd", icon = tags$img(src='VennDiagram.png',height=15)),
             menuSubItem("Upset", tabName = "upt", icon = icon("th"))
    ),
    menuItem(text = "Clasificacion y ranking", tabName = "cry", icon = icon("eject"),
             menuSubItem("Bar chart", tabName = "bc", icon = tags$img(src='bar-chart.png',height=15))
    ),
    menuItem(text = "Part Of a Whole", tabName = "pdt", icon = icon("adjust"),
             menuSubItem("Pie Chart", tabName = "pc", icon = tags$img(src='pie-chart.png',height =15)),
             menuSubItem("Stacked Bar Chart", tabName = "sbc", icon = icon("th")),
             menuSubItem("HeatMap & Dendrogram", tabName = "hmdgm", icon = tags$img(src='denograma.png',height=15)),
             menuSubItem("Dendrogram", tabName = "ddg", icon = tags$img(src='denograma.png',height=15))
    ),
    menuItem(text = "Evolution In The Time", tabName = "evt", icon = icon("hourglass"),
             menuSubItem("Scatter And Line Plot", tabName = "slp", icon = tags$img(src='linea-puntos.png',height=15))
    ),
    menuItem(text = "Mapas", tabName = "maps", icon = icon("map"),
             menuSubItem("Choropleth map", tabName = "cm", icon = icon("th")),
             menuSubItem("Bubble map", tabName = "bmp", icon = icon("th"))
    ),
    menuItem(text = "Basic Charts", tabName = "bsch",icon = icon("th"),
             menuSubItem("LinePlots", tabName = "lp", icon = tags$img(src='linea-puntos.png',height=15)),
             menuSubItem("DotPlots", tabName = "dp", icon = tags$img(src='dotplot.png',height=15))
    ),
    menuItem(text = "Statistical Charts", tabName = "bsch",icon = icon("signal"),
             menuSubItem("Histogram", tabName = "his", icon = tags$img(src='histograma.png',height=15)),
             menuSubItem("BoxPlot", tabName = "bp", icon = tags$img(src='boxplot.png',height=15))
    ),
    menuItem(text = "Transform", tabName = "trans",icon = icon("random"),
             menuSubItem("GroupBy", tabName = "gb", icon = tags$img(src='groupby.png',height=15))
    ),
    menuItem(text = "Maching Learning",tabName = "iaml",icon = icon("random"),
             menuSubItem("PCA Visualization",tabName = "pca",icon = tags$img(src='VennDiagram.png',height=15))
    ),
    menuItem(text = "About Us", tabName = "abu",icon = icon("user"))
  )
)