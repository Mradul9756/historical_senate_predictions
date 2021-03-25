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
        Describe your data here:

    ```
2. Create a cost matrix for your data set. These do not have to be "actual" costs, they could be "weights" or importances that you assign to False Positives, True Positives etc, put the values you choose into your cost matrix here.  Note: I would think of a $ cost that's proportional to the "importance" of the records (i.e. what you gain or lose by the particular FP, TP, etc...)

|   |  0  |  1  |
|---|-----|-----|
| 0 | CostTN =  | CostFP =  |
| 1 | CostFN =  | CostTP =  |


3. Use the evaluation function given in Session 12, and the cost matrix, in order to evaluate your model that was generated from Cart5 without using a cost matrix, AND, a model generated from Cart5 that used the cost matrix you defined in step 2.  Write up the results of your evaluation below in the section "Discussion of Model Evaluation". Use markdown to make this readable. Also include images in your discussion 

## What I will Look For:
* Correct evaluation of both models
* Discussion of Sensitivity and Precision and model cost values. 
* NOTE: See pages 107 through 109 for examples of the type of analysis I want to see.

## Discussion of Model Evaluation (compare and contrast models)
