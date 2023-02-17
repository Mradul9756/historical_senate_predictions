# Predicting senators from historical data


### Data description

    I’ve picked the other data set for this learning module. The data set is about historical senate predictions based on forecast methodology. 
    I’ve chosen this for the following reasons:
    1. Target variable was clear (which is actual win/loss)
    2. Target variable has two classes: 1 and 0. 1 is for win and 0 is for lose.
    3. Predictor variable was also make sense which is forecast probability (between 0.0 to 1.0)
    4. I’ve also chosen year as another predictor variable for the better model. 
    I got this data from here: https://github.com/fivethirtyeight/data/blob/master/forecast-methodology/historical-senate-predictions.csv

### Cost matrix 

|   |       0       |       1       |
|---|---------------|---------------|
| 0 | CostTN = 1000 | CostFP = 1000 |
| 1 | CostFN = 0    | CostTP = 0    |

## Discussion of Model Evaluation (compare and contrast models)

### Explanation of the Data:

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
