library(shiny)
library(ggplot2)

selectInput("x_var", "Variable X", "")
selectInput("y_var", "Variable Y", "")
selectInput("color_var", "Color variable", "")
actionButton("update_plot", "Actualizar Plot")

plotOutput("scatter_plot")
