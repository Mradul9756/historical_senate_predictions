# LM5 Model Evaluation
Class: CS251-1 – Introduction to Data Science 
Last Modified: 3/11/2021
Whitworth University

For this module you are going to build your skills of building decision tree models.

### Grade Break Down
| Part   |                    | Points |
|--------|--------------------|--------| 
| 15 pts | Model 1 (CART5 trained without costs, evaluated with costs) | |
| 15 pts | Model 2 (CART5 trained with costs, evaluated with costs)| |
| 10 pts | Evaluation parameters for both models | |
| 10 pts | Discussion of results | |



### Code Requirements
- Only use R for this assignment
- Header comments with your name and data
- Good and proper comments
- Proper spacing and neat coding

-----
## Model Evaluation using R, CART (and possibly Costs)

Either use your data set from LM4 OR pick a new data set you are interested in. (It can be from the book or online)
Complete the following analysis in R. Save your .r in this folder and submit to whitgit. 

1. If you changed your data set, describe why and what you changed it to here. Or leave this blank if you did not.

    ```
        Describe your data here: I’ve picked the other data set for this learning module. The data set is about historical senate predictions based on   forecast methodology. 
    I’ve chosen this for the following reasons:
    1. Target variable was clear (which is actual win/loss)
    2. Target variable has two classes: 1 and 0. 1 is for win and 0 is for lose.
    3. Predictor variable was also make sense which is forecast probability (between 0.0 to 1.0)
    4. I’ve also chosen year as another predictor variable for the better model. 

I got this data from here: https://github.com/fivethirtyeight/data/blob/master/forecast-methodology/historical-senate-predictions.csv

    ```
2. Create a cost matrix for your data set. These do not have to be "actual" costs, they could be "weights" or importances that you assign to False Positives, True Positives etc, put the values you choose into your cost matrix here.  Note: I would think of a $ cost that's proportional to the "importance" of the records (i.e. what you gain or lose by the particular FP, TP, etc...)

|   |       0       |       1       |
|---|---------------|---------------|
| 0 | CostTN = 1000 | CostFP = 1000 |
| 1 | CostFN = 0    | CostTP = 0    |


3. Use the evaluation function given in Session 12, and the cost matrix, in order to evaluate your model that was generated from Cart5 without using a cost matrix, AND, a model generated from Cart5 that used the cost matrix you defined in step 2.  Write up the results of your evaluation below in the section "Discussion of Model Evaluation". Use markdown to make this readable. Also include images in your discussion 

## What I will Look For:
* Correct evaluation of both models
* Discussion of Sensitivity and Precision and model cost values. 
* NOTE: See pages 107 through 109 for examples of the type of analysis I want to see.

## Discussion of Model Evaluation (compare and contrast models)

Explanation of the Data:

The data is about the historical democratic senate candidates predictions. The data frame has the variables:
1. state: Prospective candidate from the State in US
2. Year: Year on which they’ve fought the elections
3. Forecast_prob: Future probability of each candidates winning the elections.
4. Result: Actual results of the elections (Win/Lose)
5. Winflag: conversion of results in 1 or 0. (1 for win and 0 for lose).

I’ve chosen win flag as a target variable and forecast_prob and year as the predictor variables. Goal was to check how effective forecasts are when predicting winners. 

Training data set: 
TAN = 55, TAP = 43, TPN = 52, TPP = 46

Test data set:
TAN = 49, TAP = 60, TPN = 50, TPP = 59

To keep cost matrix simple, I’ve modeled a situation where prediction makers would earn $1000 on each candidate if they have prediction goes right and would lose $1000 if prediction goes wrong.

All of my models have the same accuracy, error rate, sensitivity, specificity, precision, beta, f beta, f1, f2, f5.0. 

However, Model 3 is most profitable with profit per record of -$246.
