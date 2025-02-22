pacman::p_load(shiny, tidyverse, rsconnect)
library(shiny)
library(tidyverse)
library(rsconnect)
exam <- read_csv("data/Exam_data.csv")

ui <- fluidPage(
  titlePanel("Pupil Exam Results Dashboard"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "variable",
                  label = "Subject:",
                  choices = c("English" = "ENGLISH",
                              "Maths" = "MATHS",
                              "Science" = "SCIENCE"),
                  selected = "ENGLISH"),
      sliderInput(inputId = "bins",
                  label = "Number of Bins",
                  min = 5,
                  max = 20,
                  value = 10)
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

server <- function(input, output){
  output$distPlot <- renderPlot({
    ggplot(exam,
           aes_string(x = input$variable)) +
      geom_histogram(bins = input$bins,
                     color = "black",
                     fill = "lightblue")
  })
}

shinyApp(ui = ui, server = server)
