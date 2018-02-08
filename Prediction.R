require(RTextTools)

require(sqldf)

fetch_sim<-function(tag)
{
  tag<-toString(tag)
  titles<-paste0("SELECT title FROM training_data_set where tag1='",tag,"' FETCH FIRST 5 ROWS ONLY")
  result<-sqldf(titles,dbname='training_data',user="CASH",password="1992")
  return(result)
}



prediction <- function(Title, Body){
  tryCatch({
    documents <- Body
    
    documents <- Corpus(VectorSource(documents))
    documents = tm_map(documents, content_transformer(tolower))
    documents = tm_map(documents, removeWords, stopwords("english"))
    
    predSize = 1
    predMatrix <- create_matrix(documents[[1]]$content, originalMatrix=dtMatrix)
    predictionContainer <- create_container(predMatrix, labels=rep(0,predSize), testSize=1:predSize, virgin=FALSE)
    result <- classify_model(predictionContainer, model)
    return(as.numeric(as.character(result$SVM_LABEL)))
  },  error = function(e) {
    return("Body is too short to predict a tag")
  })
  
}