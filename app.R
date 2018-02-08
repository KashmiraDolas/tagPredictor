require(shiny)

source("Prediction.R")

#for the user input
ui<-fluidPage(
  titlePanel("Please Enter the Question"),
  

  sidebarLayout(
    sidebarPanel(
    textInput("a","Question Title"),
    textAreaInput("b","Question Body","",height=200),
    actionButton("submit","Submit")
    
    )
    ,
  mainPanel(
    textOutput("tag"),
    textOutput("simques")
  )
))

#serve the output variable in main panel
server <- function(input,output){
fetchtag <-eventReactive(input$submit,prediction(input$a,input$b))
output$tag<-renderText({input$submit
  pos <- fetchtag()
  if (typeof(pos) == "character")
  {
    paste(pos)
  }
  else
  {
    paste("Tag Predicted:",TopFrequencies[pos, 1])
  }
  })
getsimilarques <-eventReactive(input$submit,fetch_sim(TopFrequencies[fetchtag(), 1]))
output$simques<-renderText({input$submit
  result<-getsimilarques()
  if (typeof(result)=="list")
  {
    temp<-""
    for (i in 1:5){
      temp<-paste(temp, i,")",result$title[i], ".",sep  ='    ')
    }
    paste("Similar Questions: ",temp)
  }
  else
  {  
  paste("Similar Questions: No similar Questions Found")
  }
})
}

shinyApp(ui,server)