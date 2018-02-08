# Tag Predictor

# Overview
The simplest way to organize web content is Tagging. Tags help search engines to understand what the content is about and it helps in ranking those pages. The user specify- ing apt subject/meta-data tags is vital for efficient searching and indexing. But allowing users to manually tag their own question might not always be the best option as a newbie might find it difficult to specify tags which are relevant to his/her question’s domain since proper selection of tags give proper ranking in query results while performing search. So, it feels really important to select correct keywords to the query asked.
Hence, proposed system is designed to predict fitting tags that help optimize the search and in turn assists user to receive most appropriate answers.
This repository provides code for Data Mining techniques such as Support Vector Machines and Naive Bayes for tag prediction purpose.
All code is written in R and PSQL. 

# README
This file contains information about how to configure and run the files for predicting the Tag for questions from the StackOverflow dataset.
# 1.	Configuration instructions

## 1.1.	Downloading the Dataset
The data set has been included in this zip file by the name of TrainingSet.csv .

## 1.2.	Setting up R
Installation of RStudio GUI is highly recommended to run this project as it will significantly reduce the work needed to follow the steps below.
 
 To run this project the packages required are: RPostgreSQL, RTextTools, Shiny, TM, sqldf.
Please ensure that these packages are installed for error free execution.

# 2.	Operating instructions

## 2.1.	Loading the data in the Postgres SQL server.

Please make sure you have a running version of Postgres SQL server before proceding to the next steps. Download and install PSequel (For Mac) or any similar GUI (For other operating systems).  Now open the trainingdata.sql file and copy the lines over to the Query window of the respective interface. Make sure that the proper path is given for loading the dataset into the server.

## 2.2.	Establishing connection between R and Postgres

Load the con_db.R file into R. Before running this file, make sure to give the proper values “dbname”= “Your database name” , port= Port on which the server runs,user=”Your username for Postgres server”, password= “Postgres server password”. Take extra care to ensure the quotes(“”) are given at necessary locations.
Example syntax is given below:
dbConnect(drv,dbname="training_data",host="localhost", port=5432,user="JOHN", password="PASS")

## 2.3.	Training

Please make sure to follow all the steps from the previous sections to ensure error free execution.
Now that the data has been prepared, we can begin training. First, we run the SVM.R file inside R. Make sure the server is up and running so that the connection can be established properly. It will first fetch the data, clean it, prepare it and train a model on it. Also, it will use the test set to test out the model and build a confusion matrix accordingly and display the results in the console. 

In the training, if an error pops up which has the following message:

“Error in if (attr(weighting, "Acronym") == "tf-idf") weight <- 1e-09 : 
      argument is of length zero”

follow the following steps to fix this error:
Run this command in the R console: “trace("create_matrix",edit=T)”
After running this a window should pop up. At line 42 there will be a line which has "Acronym” inside an if statement. Change the “A” to “a” and click on Save. This should fix the error. This error is from the developers of the RTextTools package and may pop up in your system while execution.

## 2.4.	GUI

Before starting this make sure to follow all the steps in the previous sections so that the model is built and ready for prediction.
For starting the GUI, load app.R and prediction.R file into the R environment. First run the prediction.R file so that all the required functions are present for using the app. Now simply run the application using the Run app button located at the top of the app.R script. Simply input the Title of the question and Body of the question and press submit to see the results.

## 3.	A file manifest (list of files included)
This repository contains 7 files:

SVM.R

prediction.R

app.R

con_db.R

trainingdata.sql

TrainingSet.csv



