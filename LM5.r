# Program: LM5 (Model Evaluation)
# Class: CS251-1 – Introduction to Data Science
# Date: 03/31/2021
# Written by - Mradul Mourya
# References - Prof. Jones and Textbook by Lacorose
####################################
# install the packages for C50
install.packages("C50")
library('C50')

# Create an evaluation function
# Make a function to evaluate a crosstab table
# * cross_tab is the confusion matrix with actual response values on the rows, predicted on cols
# * costs is the actual cost matrix in same arrangement as cross_tab
# * beta is the weighting of recal and precision beta > 1 recall higher weight than precision
# * model_name is the name of the model
# Returns: A data frame with rows of measures
model_eval <- function( cross_tab, costs, beta, model_name ) {
  TN <- cross_tab["0","0"] # True Negatives
  FP <- cross_tab["0","1"] # False Positives
  FN <- cross_tab["1","0"] # False Negatives
  TP <- cross_tab["1","1"] # True Positives
  
  CostTN <- costs["0","0"] # Cost of True Negatives
  CostFP <- costs["0","1"] # Cost of False Positives
  CostFN <- costs["1","0"] # Cost of False Negatives
  CostTP <- costs["1","1"] # Cost of True Positives
  
  TAN <- TN + FP # Total Actually Negative
  TAP <- FN + TP # Total Actually Positive
  TPN <- TN + FN # Total Predicted Negative
  TPP <- TP + FP # Total Predicted Positive
  GT <- TN + FN + TP + FP # Grand Total of Responses
  
  # Evaluation Metrics
  Accuracy <-  (TN + TP) / GT # Percentage predicted correctly overall
  ErrorRate <- (FN + FP) / GT # Error Rate = 1 - Accuracy
  Sensitivity <- (TP/TAP)     # Sensitivity is ability to classify positively
  Recall <- (TN/TAN)          # Recall is % negative prediction accuracy 
  Specificity <- Recall       # Specificity is ability to classify negatively                 
  Precision <- (TP/TPP)       # Precision is % of positive predictions that were accurate
  F_Beta <- ((1+beta*beta)*Precision*Recall) / ((beta*beta*Precision) + Recall )
  F_1 <- ((2)*Precision*Recall) / ((Precision) + Recall )
  F_2 <- ((5)*Precision*Recall) / ((4*Precision) + Recall )
  F_p5 <- ((1.25)*Precision*Recall) / ((0.25*Precision) + Recall )
  
  # Cost Metrics
  Overall_Model_Cost = TN * CostTN + FP*CostFP + FN*CostFN + TP*CostTP
  Model_Cost_Per_Record = Overall_Model_Cost / GT
  Model_Profit_Per_Record = -Model_Cost_Per_Record
  
  metrics <- c( round(Accuracy,4), round(ErrorRate,4), round(Sensitivity,4), 
                round(Specificity,4), round(Precision,4), 
                round(beta,4), round(F_Beta,4), round(F_1,4), round(F_2,4), round(F_p5,4),
                round(Overall_Model_Cost,4), round(Model_Cost_Per_Record,4), round(Model_Profit_Per_Record,4) )
  
  eval_data <- data.frame(metrics)
  # Set the column name to the model name
  colnames(eval_data) <- c(model_name)
  rownames(eval_data) <- c('Accuracy', 'Error Rate', 'Sensitivity', 
                           'Specificity/Recall', 'Precision', 
                           'Beta', 'F_Beta', 'F_1', 'F_2', 'F_0.5',
                           'Overall Model Cost', 'Model Cost per Record', 'Model Profit per Record')
  
  return(eval_data)
}    


# Set the context to the current file's folder
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

senate_data <- read.csv("/Users/mmourya23/Documents/Intro to Data Science/LM5/historical-senate-predictions.csv")

# set the seed for the random number generator for later use
set.seed(7)

# to determine the no. of records in the data set
n <- dim(senate_data)[1]

# todetermine which records will be in the training data set via a random number generator.
train_ind <- runif(n) < 0.50

# partitioning the data sets
# one is training data set and other is test data set
senate_train <- senate_data[train_ind,]
senate_test <- senate_data[!train_ind,]

# Convert the Gender column to a factor
senate_train$winflag <- factor(senate_train$winflag)
senate_test$winflag <- factor(senate_test$winflag)

#senate_train$forecast_prob <- factor(senate_train$forecast_prob)
#senate_test$forecast_prob <- factor(senate_test$forecast_prob)

#senate_train$year <- factor(senate_train$year)
#senate_test$year <- factor(senate_test$year)

##################################### Building Model 1 ##############################################

# Run the C50 Algorithm in R and build model 1
C5_model_1 <- C5.0(formula = winflag ~ year + forecast_prob, data = senate_train) 

senate_train$C5_predicted <- predict(object = C5_model_1, newdata = senate_train)

crosstab_10 <- table( senate_train$winflag, senate_train$C5_predicted ) # 74 - total actually negative
crosstab_10 # 75 - total actually positive 

# accuracy - 69 + 73) / (75 + 74)

senate_test$XT <- subset(x=senate_test, select = c("year", "forecast_prob"))

senate_test$YTP <- predict( object = C5_model_1, newdata = senate_test$XT )

# Make the contingency table
crosstab_11 <- table( senate_test$winflag, senate_test$YTP )

crosstab_11

# Make Costs Matrix to Evaluate Model 1 with unequal costs
costs <- matrix( c(1000, 1000, 0, 0), byrow = TRUE, ncol=2 )
dimnames(costs) <- list( c("0","1"), c("0","1") )

evals <- model_eval( cross_tab=crosstab_11, costs=costs, beta=1, model_name="C5_model_1_costs")

############################################ Model 2 #####################################################

# predicted to lose - spend cost
# Create our cost matrix for C5.0 (requires rows be predicted and columns be actual)
cost.C5 <- t( (costs / 1000) )

# Run the C50 Algorithm in R and build model 2
C5_model_2_costs <- C5.0(formula = winflag ~ year + forecast_prob,data = senate_train, costs = cost.C5 )

# Compare predictions to actual for training data
senate_train$C5_predicted_w_costs <- predict(object = C5_model_2_costs, newdata = senate_train)

# Obtain dependent variable predictions on test data (with cost included)
senate_test$YTP_cost <- predict( object = C5_model_2_costs, newdata = senate_test$XT )

# Make the contingency table
crosstab_2_costs <- table( senate_test$winflag, senate_test$YTP_cost )

# Add a new column to evals table that shows evaluation of new model with costs
evals <- cbind(evals,model_eval( cross_tab=crosstab_2_costs, costs=costs, beta=1, model_name="C5_model_2_costs"))

######################################## Model 3 #######################################

# Make Costs3 Matrix to Evaluate Model 1 with unequal costs
cost_TP <- (1 - mean(senate_train$forecast_prob)) * 1000
costs3 <- matrix( c(cost_TP, cost_TP, 0, 0), byrow = TRUE, ncol=2 )
dimnames(costs3) <- list( c("0","1"), c("0","1") )

# Create our cost matrix for C5.0 (requires rows be predicted and columns be actual)
cost.C53 <- (t( (costs3) ) / cost_TP)

# Run the C50 Algorithm in R and build model 2
C5_model_3_costs <- C5.0(formula = winflag ~ year + forecast_prob, data = senate_train, costs = cost.C53 ) 

# Compare predictions to actual for training data
senate_train$C5_predicted_w_costs <- predict(object = C5_model_3_costs, newdata = senate_train)

# Obtain dependent variable predictions on test data (with cost included)
senate_test$YTP_cost <- predict( object = C5_model_3_costs, newdata = senate_test$XT )

# Make the contingency table
crosstab_11_costs3 <- table( senate_test$winflag, senate_test$YTP_cost )

# Add a new column to evals table that shows evaluation of new model with costs
evals <- cbind(evals,model_eval( cross_tab=crosstab_11_costs3, costs=costs3, beta=1, model_name="C5_model_3_costs"))

