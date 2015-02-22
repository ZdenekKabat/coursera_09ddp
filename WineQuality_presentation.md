Wine Quality Prediction
========================================================
author: Zdenek Kabat
date: 22 February 2015
transition: rotate

Project goal
========================================================

This is a course project for Coursera Developing Data Product class as a part
of Data Science specialization. The project comprises two parts:
- `shiny` application - see [shinyapps.io](http://zkabat.shinyapps.io/WineQualityPrediction/)
- RStudio Presenter presenation (this file)

The goal of this project is to create a simple interactive `shiny` application
with included predictive model and deliver its description in a presentation.


Data source description
========================================================

<small>The project uses Wine Quality Data Set from UCI Machine Learning repository ([link](https://archive.ics.uci.edu/ml/datasets/Wine+Quality)) to classify red and white wines from Portugal based on physiocochemical tests. The attributes are:

- Fixed / volatile acidity
- Citric acid
- Residual sugar
- Chlorides
- Free / total sulfur dioxide
- Density
- pH
- Sulphates
- Alcohol

</small>

Application details
========================================================

The `shiny` application contains:

- **Interactive inputs:** 
    - radio button for red/white wine selection,
    - sliders for attribute value settings,
    - roll-down menus for plot axes setting.
- **Interactive outputs:** 
    - summary of a predictive model,
    - prediction of wine quality in terms of RF voting, 
    - scatterplot of wine attributes.

Technical details
========================================================

<small>
Wine quality data were used to calibrate a random forest classification model. 
Here we show an example of white wine model:




```r
modRF.white <- randomForest(quality ~ ., data = wineWhite, ntree = 200, importance = TRUE)
```

The model accuracy and confusion matrix are the following:


```
[1] "29.07 %"
```

```
  3  4    5    6   7  8 9 class.error
3 0  0   10   10   0  0 0   1.0000000
4 0 36   78   48   1  0 0   0.7791411
5 0  7 1040  398  11  1 0   0.2862045
6 0  3  259 1807 126  3 0   0.1778890
7 0  0   20  343 510  7 0   0.4204545
8 0  0    2   46  46 81 0   0.5371429
9 0  0    0    2   3  0 0   1.0000000
```
</small>
