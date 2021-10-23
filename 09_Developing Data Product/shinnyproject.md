Shiny Application & Reproducible Pitch
========================================================
author: Guimiao Zhang
date: 10/22/2021
autosize: true


Overview
========================================================

This is the reproducible pitch presentation for the final course project of Coursera Course: Developing Data Products.

This document will go over the basics of developing the Shiny app.

Full details please go through via the app page.

- The Growth of Orange Trees Data can be accessed with data(Orange) in R.
- The GitHub repository containing the R codes required to build the Shiny App can be accessed via
    [server.R](https://github.com/guimiaozhang/R_datasciencecoursera/blob/main/09_Developing%20Data%20Product/server.R)
    & [ui.R](https://github.com/guimiaozhang/R_datasciencecoursera/blob/c01382be31eb08ca49520f9b7e8a8fe71988862a/09_Developing%20Data%20Product/ui.R).
- The Shiny app can be accessed [here](https://rpubs.com/guimiao/shinnyapp).

Dataset
========================================================

The dataset contains 35 records. Each record contains 3 entries: Tree, age and circumference.


```r
data(Orange)
nrow(Orange)
```

```
[1] 35
```

```r
head(Orange)
```

```
  Tree  age circumference
1    1  118            30
2    1  484            58
3    1  664            87
4    1 1004           115
5    1 1231           120
6    1 1372           142
```

Example codes for conditioning plots
========================================================


```r
require(graphics)
coplot(circumference ~ age | Tree, data = Orange, rows = 1, 
       xlab = 'age (days)', ylab = 'circumference (mm)')
```

![plot of chunk unnamed-chunk-2](shinnyproject-figure/unnamed-chunk-2-1.png)


Example codes for scatter plot and fitted model
========================================================

```r
require(stats)
sub <- subset(Orange, Tree == 1)
fit <- nls(circumference ~ SSlogis(age, Asym, xmid, scal), data = sub)
plot(circumference ~ age, data = sub, xlab = "age (days since 12/31/1968)",
     ylab = "circumference (mm)", las = 1, 
     main = sprintf("Orange tree data and fitted model (Tree %s only)", 1))
                age <- seq(0, 1600, length.out = 101)
                lines(age, predict(fit, list(age = age)), col = 'red', lty = 2)
```

![plot of chunk unnamed-chunk-3](shinnyproject-figure/unnamed-chunk-3-1.png)
