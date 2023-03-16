library(shiny)
library(babynames)

# Load the data
data("babynames")

# Define UI
ui <- fluidPage(
  titlePanel("Baby Name Generator"),
  sidebarLayout(
    sidebarPanel(
      selectInput("sex", "Select a sex:", c("M", "F"), selected = "F"),
      sliderInput("yearRange", "Select a year range:", min = 1880, max = 2020, value = c(1990, 2000)),
      actionButton("generate", "Generate Random Baby Name", class = "btn btn-primary mt-3")
    ),
    mainPanel(
      h3("Random Baby Name:"),
      uiOutput("nameOutput")
    )
  )
)

# Define server
server <- function(input, output) {
  # Generate random baby name based on selected sex and year range
  random_name <- eventReactive(input$generate, {
    subset(babynames, sex == input$sex & year >= input$yearRange[1] & year <= input$yearRange[2]) %>%
      sample_n(1) %>%
      pull(name)
  })
  
    
  # Output the random baby name
  output$nameOutput <- renderText({
    random_name()
  })
}

# Run the app
shinyApp(ui, server)
