require(RTextTools)
require(tm)

TopFrequencies <- data.frame(Tag = c("c#", "java","php","javascript","android"))

#Import the Data

colnames(TopFrequencies)[1] <- "Tag"
colnames(TrainingSet)[5] <- "BodyMarkdown"
colnames(TrainingSet)[6] <- "Tag1"

# Sort out the instances which contain the top 5 tags.
train_set = NULL
target <- NULL
for (i in 1:5)
{
  temp = TrainingSet[which(TrainingSet$Tag1 == TopFrequencies$Tag[i]), ]
  for (j in 1:1000)
  {
    target <- rbind(target, i)
  }
  train_set <- rbind(train_set, temp[1:1000,])
}
train_set <- cbind(train_set, target)

# Prepare the data. Remove Stop words and convert all words to lower case.
documents <- train_set$BodyMarkdown

documents <- Corpus(VectorSource(documents))
documents = tm_map(documents, content_transformer(tolower))
#documents = tm_map(documents, removePunctuation)
documents = tm_map(documents, removeWords, stopwords("english"))

temp = NULL
for (i in 1:length(train_set$BodyMarkdown))
{
  temp = rbind(temp, documents[[i]]$content)
}

train_set <- cbind(train_set, temp)
colnames(train_set)[length(train_set)] <- "BodyMarkdown_cleaned"

Data <- train_set

# Split Data into Training and Testing
smp_size <- floor(0.70 * nrow(Data))
set.seed(1)
train_ind <- sample(seq_len(nrow(Data)), size = smp_size, replace = FALSE)

train_set <- Data[train_ind, ]
test_set <- Data[-train_ind, ]

train_ind <- sample(seq_len(nrow(test_set)), size = 1000, replace = FALSE)
test_set <- test_set[train_ind,]

# Create the tf-idf frequency
dtMatrix <- create_matrix(train_set$BodyMarkdown_cleaned, language = "english", stemWords = TRUE, removeSparseTerms = .998)

# Configure the training data
container <- create_container(dtMatrix, train_set$target, trainSize=1:length(train_set$BodyMarkdown_cleaned), virgin=FALSE)

# train a SVM Model
model <- train_model(container, "SVM", kernel="linear", cost=1)

# Predict the tags for testing set.
predictionData <- test_set$BodyMarkdown_cleaned
predictiontarget <- test_set$target
predMatrix <- create_matrix(predictionData, originalMatrix=dtMatrix)

predSize = length(predictionData);
predictionContainer <- create_container(predMatrix, labels=rep(0,predSize), testSize=1:predSize, virgin=FALSE)

results <- classify_model(predictionContainer, model)

# Create the Confusion Matrix
tab = table (results$SVM_LABEL, predictiontarget)
print(tab)