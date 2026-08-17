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
  <li class="fragment">Units of measurement and functional form</li>
  <li class="fragment">Regression through the origin and regression on a constant</li>
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
Given any values of the explanatory variables, the expected value of the error equals zero.
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
\sum_{i=1}^{n} \hat{u_i}^2 = 
\sum_{i=1}^{n} (y_i  - \hat{\beta_0} - \hat{\beta_1}x_i)^2
$$
</div>


</div>

<div class="column-image">
<img src="images/resid_plot.png" alt="Plot of residuals and regression line.">
</div>

</div>

---

## The OLS estimator formulas

<div class="two-column-slide">

<div class="column-text">
<div class="fragment">
$$
\hat{\beta_1} = 
\frac{\sum_{i=1}^{n}(x_i - \bar{x})(y_i - \bar{y})}{\sum_{i=1}^{n}(x_i - \bar{x})^2}
$$
</div>
</div>

<div class="column-text">
<div class="fragment">
$$
\hat{\beta_0} = 
\bar{y} - \hat{\beta_1}\bar{x}
$$
</div>
</div>

---

<!-- .slide: class="section-title" data-background-color="#f2f2f2" -->

## Properties of OLS on any data sample

---

## Properties of OLS on any data sample

<ul>
<li class="fragment">
$\sum_{i=1}^{n} \hat{u_i} = 0$
</li>

<li class="fragment">
$\sum_{i=1}^{n} x_i \hat{u_i} = 0$
</li>

<li class="fragment">
$\text{Total Sum of Squares (SST)} \equiv \sum_{i=1}^{n} (y_i - \bar{y})^2$
</li>

<li class="fragment">
$\text{Explained Sum of Squares (SSE)} \equiv \sum_{i=1}^{n}(\hat{y_i} - \bar{y})^2$
</li>

<li class="fragment">
$\text{Residual Sum of Squares (SSR)} \equiv \sum_{i=1}^{n} \hat{u_i}^2$
</li>

<li class="fragment">
$\text{SST = SSE + SSR}$
</li>

</ul>

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
Note: using the $R^2$ as the <strong>main</strong> gause of success for an econometric analysis can lead to trouble.
</div>


<!-- .slide: class="section-title" data-background-color="#f2f2f2" -->

## Units of measurement and functional form

---