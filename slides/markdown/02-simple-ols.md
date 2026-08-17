# ECON 8300

## Simple Linear Regression

Jessica Perrigan

University of Nebraska at Omaha

Notes:
Opening remarks.

---

## Topic 2

<ol>
  <li class="fragment">Definition of the simple regression model</li>
  <li class="fragment">Deriving the OLS estimators</li>
  <li class="fragment">Properties of OLS on any data sample</li>
  <li class="fragment">Units of measurement and functional form</li>
  <li class="fragment">Expected values and variances of the OLS estimators</li>
  <li class="fragment">Regression on a binary explanatory variable</li>
</ol>

---

<!-- .slide: class="section-title" data-background-color="#f2f2f2" -->

## Definition of the simple regression model

---

## Taking correlation to the next level

<div class="fragment">
Correlation indicates that changes in one variable are associated with changes in another variable.</li>
</div>

<br>

<div class="fragment">
$$
r_{xy}
=
\frac{\sum_{i=1}^{n}(x_i-\bar{x})(y_i-\bar{y})}
{\sqrt{\sum_{i=1}^{n}(x_i-\bar{x})^2}
 \sqrt{\sum_{i=1}^{n}(y_i-\bar{y})^2}}
$$
</div>

<br>

<div class="fragment">
But what if we want to "explain $x$ in terms of $y$?"
</div>

Notes:
- Understanding correlation is a good place to start learning regression, Many of the practices and concepts surrounding correlation also apply to regression analysis
- Correlation indicates that changes in one variable are associated with changes in the other variable
The greater the absolute value of the coefficient, the stronger the relationship
- The extreme values of -1 and 1 indicate a perfectly linear relationship, where a change in one variable is accompanied by a perfectly consistent change in the other
- A coefficient of zero represents no linear relationship. As one variable increases, there’s no tendency in the other variable to either increase or decrease
- When the value is in between 0 and 1, there is a relationship
- The coefficient sign represents the direction of the relationship
- Positive correlation coefficients mean that when the value of one variable increases, the value of the other also tends to increase
- Negative correlation coefficients represent cases when the value of one variable increases, the value of the other variable tends to decrease
- Correlation tells us something about the strength and direction of the relationship, It doesn’t mean that changes in one variable actually cause the changes in another variable 

---

## The simple linear regression model

<div class="fragment">
$$
y = 
\beta_0 + \beta_1 x + u
$$
</div>

<div class="fragment">
If the other factors in $u$ are held fixed:
</div>

<div class="fragment">
$$
\Delta y =
\beta_1 \Delta x \text{ if } \Delta u = 0
$$
</div>

Notes:
Useful to think of u as standing for "unobserved."

When is it realistic to imply that a one-unit change in x has the same effect on y, regardless of the initial value of x?

When is this unrealistic?

Does this model really allow us to draw ceteris paribus conclusions about how x affects y?

---

<!-- .slide: class="section-title" data-background-color="#f2f2f2" -->

## Deriving the OLS estimators

---

## Expected value of $u$

<div class="fragment">
$$
E(u) = 0
$$
</div>

<div class="fragment small-text">
In a model with an intercept, we can always redefine the intercept this make this true. Split the error into its mean and a zero-mean remainder:
</div>

<div class="fragment small-text">
$$
u = \mu_u + v \text{,}
\qquad
E(v) = 0
$$
</div>

<div class="fragment small-text">
Substitute:
</div>

<div class="fragment small-text">
$$
\begin{aligned}
y &= \beta_0 + \beta_1 x + u \\
  &= (\beta_0 + \mu_u) + \beta_1 x + v \\
  &= \alpha + \beta_1 x + v\text{,}
  \qquad
  E(v) = 0
\end{aligned}
$$

</div>



---

## Zero conditional mean assumption

<div class="fragment">
$$
E(u|x) = E(u)
$$
</div>

<div class="fragment">
Given any values of the explanatory variables, the expected value of the error equals zero; gives us a causal interpretation.
</div>

<br>

<div class="fragment">
Let's take a look at a simple equation. Do we think this assumption holds?
</div>

<div class="fragment">
$$
wage = \beta_0 + \beta_1 educ + u
$$
</div>

---

## The population regression function

<div class="two-column-slide">

<div class="column-text">

<div class="fragment medium-text">
Taking the expected value of our regression equation and using the zero conditional mean assumption gives:
</div>

<div class="fragment medium-text">
$$
E(y|x) = \beta_0 + \beta_1 x
$$
</div>

<div class="fragment medium-text">
A one-unit increase in $x$ changes the <em>expected value</em> of $y$ by the amount $\beta_1$.
</div>

</div>

<div class="column-image">
<img src="images/dist_plot.png" alt="Conditional distributions of y around the population regression function">
</div>

</div>

Notes:

Regression analysis mathematically describes relationship between independent variables and a dependent variable

Use regression for two primary goals

To understand the relationships between (an) independent variable(s) and a dependent variable. How do changes in the independent variable or variables relate to changes in the dependent variable?

To predict the dependent variable by entering values for the independent variable(s) into the regression equation

Let’s say we’re studying the relationship between wattage and the output from a light bulb. Regression analysis will let us understand the nature of the relationship between these two variables. Is this relationship statistically significant? What effect does wattage have on light output? For a given wattage, how much light output does our model predict?
---



## Deriving the OLS parameters

<div class="two-column-slide">

<div class="column-text">

<div class="fragment medium-text">
Let ${(x_i, y_i) : i = 1, \dots, n}$ denote a random sample of size $n$ from the population, letting us write:
</div>

<div class="fragment medium-text">
$$
y_i = \beta_0 + \beta_1 x_i + u_i
$$
</div>

<div class="fragment medium-text">
With the goal to minimize:
</div>

<div class="fragment medium-text">
$$
\sum_{i=1}^{n} \hat{u}_i^2 = 
\sum_{i=1}^{n} (y_i  - \hat{\beta}0 - \hat{\beta}_1 x_i)^2
$$
</div>


</div>

<div class="column-image">
<img src="images/resid_plot.png" alt="Plot of residuals and regression line.">
</div>

</div>

Notes:

That's why *that* line. Imagine drawing a different line. Why wouldn't that fit as well?

Could we sum the residual?
We can’t merely sum the residuals because the positive and negative values will cancel each other out even when they’re relatively big
Maybe the average residual value?
If the model has a lot of residuals with values near 10 and -10, that averages to approximately zero distance
But another model with many residuals near +1 and -1 also averages out to be nearly zero
But using the average doesn’t distinguish between these models
What about the absolute value of the residuals?
Now we don’t have to worry about the negative and positive residuals cancelling each other out
One reason why not is uniquenes.
When minimizing the sum of the absolute value of the residuals it is possible that there may be an infinite number of lines that all have the same sum of absolute residuals (the minimum). Which of those line should be used?



Observed values of the dependent variable are the values that you record during your study or experiment, along with the values of the independent variable.

Fitted values are the values that your model predicts for the dependent variable using the independent variables. 

If you input values for the independent variables into your regression equation, you obtain the fitted value.

Predicted values and fitted values are synonyms

An observed value is the one that exists in the real world, while your model generates the fitted value for that observation. 

Standard notation uses y hat to denote fitted values to indicate that they’re a model’s estimate for the corresponding non-hatted values (the observed values)

Regression analysis predicts the dependent variable

For every observed value of the dependent variable, the model will calculate a corresponding fitted variable

To understand how well the model fits the data, we have to assess the difference between the observed values and the fitted values

These differences represent the error in the model


Residual is the difference between the observed value and the fitted value
No model is perfect! The observed and fitted values will never exactly match, but they can be good enough to be useful



---

## The OLS estimator formulas

<div class="two-column-slide">

<div class="column-text">
<div class="fragment">
$$
\hat{\beta}_1 = 
\frac{\sum_{i=1}^{n}(x_i - \bar{x})(y_i - \bar{y})}{\sum_{i=1}^{n}(x_i - \bar{x})^2}
$$
</div>
</div>

<div class="column-text">
<div class="fragment">
$$
\hat{\beta}_0 = 
\bar{y} - \hat{\beta}_1 \bar{x}
$$
</div>
</div>

Notes:



But if we look at the equations, we see that they are functions of our data only. We have to kep this im mind.


---

<!-- .slide: class="section-title" data-background-color="#f2f2f2" -->

## Properties of OLS on any data sample

---

## Properties of OLS on any data sample

<ul>
<li class="fragment">
$\sum_{i=1}^{n} \hat{u}_i = 0$
</li>

<li class="fragment">
$\sum_{i=1}^{n} x_i \hat{u}_i = 0$
</li>

<li class="fragment">
$\text{Total Sum of Squares (SST)} \equiv \sum_{i=1}^{n} (y_i - \bar{y})^2$
</li>

<li class="fragment">
$\text{Explained Sum of Squares (SSE)} \equiv \sum_{i=1}^{n}(\hat{y}_i - \bar{y})^2$
</li>

<li class="fragment">
$\text{Residual Sum of Squares (SSR)} \equiv \sum_{i=1}^{n} \hat{u}_i^2$
</li>

<li class="fragment">
$\text{SST = SSE + SSR}$
</li>

</ul>

Notes:

The first property doesn't need a proof, it just follows from the OLS first order condition (the betas are chosen to make the residuals add up to zero)

Regression Sum of Squares: the amount of added variability your model explains compared to a model that contains no variables. It is equal to the sum of the squared difference between the fitted values of y and the mean of y
Total Sum of Squares: overall variability of the dependent variable around its mean. It is equal to the sum of the squared difference between the observed values of y and the mean of y
SSE + RSS = TSS -> explained variability + unexplained variability = total variability




---

## Goodness of Fit

<div class="fragment">
The $R^2$ is the ratio of explained variation compared to the total variation, or the fraction of the sample variation that is explained by $x$.
</div>

<br>

<div class="fragment">
$$
R^2 \equiv \text{SSE / SST} = 1 - \text{SSR / SST}
$$
</div>

<br>

<div class="fragment">
<strong>Caution:</strong> using the $R^2$ as the <strong>main</strong> gauge of success for an econometric analysis can lead to trouble.
</div>

Notes:

Zero indicates that the model accounts for none of the variability in the dependent variable around its mean. 
1 signifies that the model explains all of the variability
We’ll talk a lot more about R-squared as we discuss more about determining how well your model fits your data. Here I’m talking about it more from the conceptual standpoint


---

<!-- .slide: class="section-title" data-background-color="#f2f2f2" -->

## Units of measurement and functional form

---


## Incorporating Nonlinearities 

<div class="fragment">
Regression of log wages on years of education: 
</div>


<div class="fragment">
$$
log(wage)
=
\beta_0 + \beta_1 educ + u
$$
</div>


<div class="fragment">
This changes the interpretation of the regression coefficient:
</div>

<div class="fragment">
$$
log(wage)
=
\beta_0 + \beta_1 educ + u
$$
</div>


<div class="fragment">
$$
\beta_1 = \frac{\Delta log(wage)}{\Delta educ} 
= \frac{1}{wage} \cdot \frac {\Delta wage}{\Delta educ} 
= \frac{\frac{\Delta wage}{wage}}{\Delta educ}
$$
</div>

Notes:

This changes the interpreation of the regression coefficient

We use logs a lot, lets us use percentages

---

## So What Does "Linear" Mean?

<ul>
<li class="fragment">Linear regression means <em>linear in parameters</em>.</li>
<li class="fragment">The mechanics don't matter, but the interpretation of the coefficients does depend on their definitions</li>
</ul>

---

<!-- .slide: class="section-title" data-background-color="#f2f2f2" -->

## Expected Values and Variances of the OLS Estimators

---

## Unbiasedness of OLS

<div class="medium-text">
<ol>
<li class="fragment">Linear in Parameters: $y$ is related to $x$ and $u$ as $y = \beta_0 + \beta_1x + u$</li>
<li class="fragment">Random sampling: we have a random sample of size $n, {(x_i, y_i): i = 1, 2, \dots, n}$, following the population model above, letting us write the equation as $y_i = \beta_0 + \beta_1 x_i +u_i, i = 1, 2, \cdots, n$. </li>
<li class="fragment">Sample variation in $x$: the sample outcomes on $x$ are not all the same value</li>
<li class="fragment">Zero conditional mean: the error term $u$ has an expected value of zero given any value of $x$ such that $E(u|x) = 0$</li>
</ol>
</div>

Notes:

Linear in parameters: Y, x, an du are random variables that state the population model. since it's a linear model, has to be linear in parameters. The population relationship is linear in the unknown coefficients, The betas. X itself doesn't need to  enter the model linearly.
Random sampling: The observations are randomly drawn from the same population and each follows the population model. This allows us to use the sample to learn about population parameters.
Sample variation in x: x must take at least two different values. Otherwise, we cannot estimate how y changes with x.
Zero conditional mean: At every value of x, the average of all unobserved factors in u is zero. Equivalently, x is unrelated to factors in u that affect y—the key assumption for unbiased OLS estimates.

If assumption 4 holds, the estimators are unbiased. If it fails, the estimators will be biased (we'll come back to this).

---


## Variances of the OLS Estimators

<div class="medium-text">
<ul>
<li class="fragment">Since we are using a sample to learn about the population, we need to be able to know how $\hat{\beta_1}$ describes $\beta_1$</li>
<li class="fragment">With unbiasedness, we know that the sampling distribution of $\hat{\beta}_1$ is centered around $\beta_1$</li>
<li class="fragment">We also want to know how far away we can expect $\hat{\beta_1}$ to be from $\beta_1$ on average</li>
<li class="fragment">Homoskedasticity assumption: the error $u$ has the same variance given any value of the explanatory variable, or $\operatorname{Var}(u|x) = \sigma^2$</li>
<li class="fragment">Since $E(y|x) = \beta_0 + \beta_1x$, then $\operatorname{Var}(y|x) = \operatorname{Var}(u|x) = \sigma^2$</li>
</ul>
</div>

Notes:
We use beta1_hat
 to estimate the unknown population slope, beta_1
Unbiasedness tells us that the sampling distribution of beta1_hat 
 is centered at beta_1
Variance tells us how spread out that sampling distribution is—how much beta_1 would vary across repeated random samples.
Lower variance means a more precise estimator; higher variance means a less precise estimator.
Homoskedasticity: The variance of the unobserved factors is constant at every value of x.

Since y = beta_0 + beta_1 x + u, the only variation in y condition on x comes from u.


---

## Sampline Variances of the OLS Estimators

<div class="fragment">
Under our assumptions:
</div>

<div class="fragment">
$$
\operatorname{Var}(\hat{\beta}_1) 
= \frac{\sigma^2}{\sum_{i=1}^{n}(x_i - \bar{x})^2}
= \sigma^2 / SST_x
$$
</div>

<div class="fragment">
and
</div>

<div class="fragment">
$$
Var(\hat{\beta}_0) = 
\frac{\sigma^2 n^{-1} \sum_{i=1}^{n} x_i^{2}}{\sum_{i=1}^{n}(x_i - \bar{x})^2}
$$
</div>

Notes:

The variance measures how much each OLS estimate would vary across repeated samples with the same x-values.

More variation in x—a larger SST —reduces the variance of beta hat 1
A wider range of x-values gives us a more precise slope estimate.

Greater error variance, sigma squared, increases the variance of both estimators. More unexplained variation in y makes estimation less precise.

Larger samples generally increase SST_x, reducing the variance of the slope estimator.

The precision of the intercept also depends on where the x-values are located relative to zero. The intercept is estimated more precisely when the sample contains observations near x=0.

---

## Estimating the Error Variance

<div class="fragment">
We don't directly observe the errors, so we use our estimated equations to write the residuals as a function of the errors:
</div>

<div class="fragment medium-text">
$$
\hat{u}_i 
= y_i - \hat{\beta}_0 - \hat{\beta}_1 x_i
= (\beta_0 + \beta_1 x_i - u_i) - \hat{\beta}_0 - \hat{\beta}_1 x_i
$$
</div>

<div class="fragment">
or
</div>

<div class="fragment medium-text">
$$
\hat{u}_i
= u_i - (\hat{\beta}_0 - \beta_0) - (\hat{\beta}_1 - \beta_1) x_i
$$
</div>


Notes: 
We ant to isolate the factors that contribute to the variance of the betas.

But these formulas are unknown, unless we also know sigma squared (rare).

But we can estimate sigma squared, which then allows us to eestimate the variances of the estimators.

We don't know the errors, but we can compute the residuals from the data.

The difference between them does have an *expected value* of zero, but u hat is not the same as u.

---

## Estimating the Error Variance

<div class="fragment small-text">
Since $\sigma^2 = E(u^2)$, an unbiased "esimator" of $\sigma^2$ is:
</div>

<div class="fragment small-text">
$$
n^{-1}\sum_{i=1}^{n}u_i^2
$$
</div>

<div class="fragment small-text">
If we replace the errors with the OLS residuals, we get:
</div>

<div class="fragment small-text">
$$
n^{-1}\sum_{i=1}^{n}\hat{u}_i^2
= SSR / n
$$
</div>

<div class="fragment small-text">
With the degrees of freedom adjustment:
</div>

<div class="fragment small-text">
$$
\hat{\sigma}^2 = 
\frac{1}{n - 2} \sum_{i=1}^{n}\hat{u}_i^2 = SSR / (n-2)
$$
</div>

Notes:

If the population errors were observable, we could estimate their variance by averaging their squared values. But the errors are unobservable, so we use the OLS residuals instead.

Simply dividing SSR by \(n\) produces a downward-biased estimator because OLS chooses the residuals after estimating two parameters: the intercept and slope.

The OLS residuals must satisfy two restrictions: they sum to zero, and their products with \(x\) sum to zero. Therefore, only \(n-2\) residuals are free to vary.

Dividing SSR by \(n-2\) accounts for these two lost degrees of freedom and gives us an unbiased estimator of \(\sigma^2\).
---

<!-- .slide: class="section-title" data-background-color="#f2f2f2" -->

## Regression with a Binary Explanatory Variable

---

## Regression with a Binary Explanatory Variable

<div class="fragment medium-text">
A binary, or dummy, variable takes only two values:
</div>

<div class="fragment medium-text">
$$
x =
\begin{cases}
1 & \text{if an observation belongs to Group 1} \\
0 & \text{if an observation belongs to Group 0}
\end{cases}
$$
</div>


<div class="fragment medium-text">
Used when $x$ has quantitative meanings.
</div>

Notes:
They turn categorical or yes/no attributes (like male/female, married/single, or employed/unemployed) into numbers that a regression model can process


---

## Regression with a Binary Explanatory Variable

<div class="fragment medium-text">
Consider the simple regression model:
</div>

<div class="fragment medium-text">
$$
y = \beta_0 + \beta_1x + u
$$
</div>

<div class="fragment medium-text">
Under the zero conditional mean assumption:
</div>

<div class="fragment medium-text">
$$
E(y\mid x) = \beta_0 + \beta_1x
$$
</div>

<div class="fragment medium-text">
Therefore:
</div>

<div class="fragment small-text">
$$
E(y\mid x=0)=\beta_0
\qquad\text{and}\qquad
E(y\mid x=1)=\beta_0+\beta_1
$$
</div>

<div class="fragment small-text">
$$
\beta_1=E(y\mid x=1)-E(y\mid x=0)
$$
</div>

Notes:

A binary variable divides the population into two groups. The value zero identifies the reference or baseline group, while one identifies the comparison group.

When \(x=0\), the conditional mean of \(y\) is simply \(\beta_0\). Therefore, the intercept is the average outcome for the reference group.

When \(x=1\), the conditional mean is \(\beta_0+\beta_1\). It follows that \(\beta_1\) is the difference in average outcomes between Group 1 and Group 0.

The usual interpretation of a one-unit increase in \(x\) still works, but here that increase means moving from the reference group to the comparison group.

---

## Binary Explanatory Variables in the Sample

<div class="fragment small-text">
For a sample, let:
</div>

<div class="fragment small-text">
$$
\bar{y}_0
=
\text{average of } y_i \text{ among observations with } x_i=0
$$
</div>

<div class="fragment small-text">
$$
\bar{y}_1
=
\text{average of } y_i \text{ among observations with } x_i=1
$$
</div>

<div class="fragment small-text">
The OLS estimates are:
</div>

<div class="fragment small-text">
$$
\hat{\beta}_0=\bar{y}_0, \text{  }  \hat{\beta}_1=\bar{y}_1-\bar{y}_0
$$
</div>


<div class="fragment small-text">
<ul>
<li class="fragment">Thus, a regression with one binary explanatory variable is equivalent to comparing two sample means.</li>

<li class="fragment">A difference in means is not necessarily a causal effect: $E(u\mid x)=0$ requires group membership to be unrelated to other factors affecting $y$.</li>
</div>


Notes:

The mechanics and statistical properties of OLS do not change when the explanatory variable is binary.

The estimated intercept is the sample mean for the group coded zero. The estimated slope is the difference between the sample means for the groups coded one and zero.

We need observations in both groups; otherwise, there is no sample variation in \(x\) and we cannot estimate the difference.

The order of subtraction depends entirely on the coding. If we reverse which group is coded one, the sign of the slope reverses, but the underlying difference between the groups does not change.

The slope always describes the difference in average outcomes, but it is not automatically causal. For example, students who choose to attend tutoring may differ from nonattendees in motivation, preparation, or prior performance. Those factors enter the error term and may violate zero conditional mean.

Without a credible reason to believe the groups are otherwise comparable, interpret \(\hat{\beta}_1\) as a descriptive difference in means rather than the causal effect of \(x\).