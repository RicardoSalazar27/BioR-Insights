

# Contenido del nuevo archivo R (por ejemplo, "sidebar.R")

sidebar <- dashboardSidebar(
  sidebarMenu(
    
    menuItem(
      text = "What is BioR Insghts?", tabName = "wbr", icon = icon("th")
    ),
    
    menuItem(text = "Relaciones Y Coorelacion", tabName = "ryc", icon = icon("dashboard"),
             menuSubItem("Heatmap", tabName = "htm", icon = icon("th")),
             menuSubItem("ScatterPlot", tabName = "sct", icon = icon("th")),
             menuSubItem("Venn diagram", tabName = "vd", icon = icon("th")),
             menuSubItem("Upset", tabName = "upt", icon = icon("th"))
    ),
    menuItem(text = "Clasificacion y ranking", tabName = "cry", icon = icon("th"),
             menuSubItem("Bar chart", tabName = "bc", icon = icon("th"))
    ),
    menuItem(text = "Parte De un todo", tabName = "pdt", icon = icon("th"),
             menuSubItem("Pie chart", tabName = "pc", icon = icon("th")),
             menuSubItem("Stacked barplot", tabName = "sb", icon = icon("th")),
             menuSubItem("Denograma", tabName = "den", icon = icon("th"))
    ),
    menuItem(text = "Evolucion en el tiempo", tabName = "evt", icon = icon("th"),
             menuSubItem("Grafico de lineas y puntos", tabName = "slp", icon = icon("th"))
    ),
    menuItem(text = "Mapas", tabName = "maps", icon = icon("th"),
             menuSubItem("Choropleth map", tabName = "cm", icon = icon("th")),
             menuSubItem("Bubble map", tabName = "bmp", icon = icon("th"))
    ),
    menuItem(text = "Basic Charts", tabName = "bsch",icon = icon("th"),
             menuSubItem("LinePlots", tabName = "lp", icon = icon("th")),
             menuSubItem("DotPlots", tabName = "dp", icon = icon("th"))
    ),
    menuItem(text = "Statistical Charts", tabName = "bsch",icon = icon("th"),
             menuSubItem("Histogram", tabName = "his", icon = icon("th")),
             menuSubItem("BoxPlot", tabName = "bp", icon = icon("th"))
    ),
    menuItem(text = "Tranform", tabName = "trans",icon = icon("th"),
             menuSubItem("GroupBy", tabName = "gb", icon = icon("th"))
  )
)
)