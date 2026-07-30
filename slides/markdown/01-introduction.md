
# ECON 8300

## Econometrics

Jessica Perrigan

University of Nebraska at Omaha

Notes:
Opening remarks.

---

## Week 1

<ol>
  <li class="fragment">Course structure</li>
  <li class="fragment">Expectations</li>
  <li class="fragment">Econometrics and Econometric Data</li>
  <li class="fragment">Introduction to R</li>
</ol>

---

## Course structure

<ul>
  <li class = "fragment">Problem sets</li>
  <li class = "fragment">Exams</li>
  <li class = "fragment">Research project</li>
</ul>

---

## Expectations

<ul>
  <li class = "fragment">Engagement and collaboration </li>
  <li class = "fragment">Cameras</li>
  <li class = "fragment">Workload</li>
</li>

---

## A definition of econometrics

<div class="fragment">
The development of statistical methods for estimating economic relationships, testing economic theories, and evaluating and implementing government and business policy.
</div>

Notes:
A common application of econometrics is the forecasting of macro variables like interest rates, inflation rates, and GDP but a) I'm not as interested and b) there's a whole forecasting class!

---

## Econometric models

<ol>
  <li class = "fragment">Question of interest</li>
  <li class = "fragment">Economic model construction</li>
  <li class = "fragment">Conversion to econometric model</li>
    <ul>
      <li class = "fragment">Parameters</li>
      <li class = "fragment">Functional form</li>
    </ul>
  <li class = "fragment">Hypotheses of interest</li>
  <li class = "fragment">Data collection</li>
</ol>

Notes:

Question of interest: need to be careful in its formulation. Might be testing ecoomic theory, might test effects of a government policy. 

Economic model: this consists of equations that describe various relationships. Could be utility maximization (individuals make choices to maximize their well-being subject to resource constraints). In consumption decisions, utility maximization leads to a set of demand equations.

Econometric model: after specifying an economic model, we turn it into an econometric model. This is an equation/ set of equation relating the dependent variable to a set of explanatory variables/ unobserved disturbances, where unknown population parameters determine the ceteris paribus effect of each explanatory variable. 

Choice of variables is determined by economic theory and data considerations. 

Hypotheses: Once an econometric model has been specified, various hypotheses of interest can be stated in terms of the unknown parameters.

Data: An empirical analysis requires data, by definition. We;ll talk more about this in a minute. 

---

## Econometric data

<ul>
  <li class = "fragment"><strong>Nonexperimental data:</strong> not accumulated through controlled experiments on individuals, firms, or setments of the economy (also called observational data)</li>
  <li class = "fragment"><strong>Experimental data:</strong> collected in lab environments, more difficult to get in the social sciences</li>
</ul>

Notes:
Econometrics has evolved as a separate discipline from mathematical stats because econometrics focuses on the problems inherent in collecint and analyzing nonexperimental economic data.

While some social experiments can be devised, it's often impossible, prohibitively expensive, or morally repubnant to conduct the kinds of controlled experiments that would be needed to address economic issues.

Econometricians borrow from mathematical statisticans whenever possible, but focus/ interpretation are different. Also economists have devised new techniques to deal with the complexities of economic data/ test predictions of economic theories.

Chapter 1 has some descriptions of different data structions (cross sectional, time series, panels, etc.) that I recommend you review.

---

## Hume on causality

<ul>
<li class = "fragment">Hume defined causation as:</li>
<div class="fragment small-text">
  <ul>
    <li class = "fragment">(D1) An object precedent and contiguous to another, and where all the objects resembling the former are placed in like relations of precedency and contiguity to those objects that resemble the latter.</li>
    <li class = "fragment">(D2) An object precedent and contiguous to another, and so united with it, that the idea of the one determined the mind to form the idea of the other, and the impression of the one to form a more lively idea of the other.</li>
  </ul>
  </div>
<li class = "fragment">What do these two definitions mean? Are they the same?</li>

</ul>

Notes:
Hume thinks we can get a handle on the question of causality by considering two different propositions:
1. I’ve found that headache relief has always followed my taking aspirin; and
2. Taking aspirin similar to the ones I’ve taken in the past will relieve my present headache.

Aspirin proposition 1 summarizes my past experience, while proposition 2 predicts what will happen in the immediate future. 

The chain of reasoning I need must show me how my past experience is relevant to my future experience. 

I need some further proposition or propositions that will establish an appropriate link or connection between past and future, and take me from (1) to (2) using either demonstrative reasoning, concerning relations of ideas, or probable reasoning, concerning matters of fact.

For Hume, causality, as it is in the world, is a regular succession of event-types: one thing invariably following another. 

Basically: Hume's theory of causation states that cause and effect relationships are not a product of natural law or universal truth, but are based on the necessity that we associate events based on experience. 

So when we observe A happening before B, we assume A caused B, and this assumption is based on past experience and *not* on an inherent connection between events. 

His far-reaching observation was that the alleged necessity of causal connection cannot be proved empirically either. 

As Hume said: "For all inferences from experience suppose, as their foundation, that the future will resemble the past …. If there be any suspicion, that the course of nature may change, and that the past may be no rule for the future, all experience becomes useless, and can give rise to no inference or conclusion."

It will presuppose a principle of uniformity of nature--that things will continue as they have. But this principle cannot be proved empirically without circularity. 

Any attempt to prove it empirically will have to assume what needs to be proved: namely, that since nature has been uniform in the past it will or must continue to be uniform in the future. 


---

## Kant on causality

<div class="fragment">

> Appearances certainly provide cases from which a rule is possible in accordance with which something usually happens, but never that the succession is necessary; therefore, a dignity pertains to the synthesis of cause and effect that cannot be empirically expressed at all, namely, that the effect does not merely follow upon the cause but is posited through it and follows from it.

</div>

Notes:
“Appearances” are things as we experience them—the events and objects available to perception, rather than things as they might exist independently of human experience.

Individual observations give us particular cases:
A happened and then B happened.

“…from which a rule is possible in accordance with which something usually happens…”

From many such cases we can formulate an empirical regularity. But the key word here is usually, it's a pattern, it doesn't establish what MUST happen. It doesn't show that B HAD to follow A. Even perfect regularity doesn't logically guarantee that the sequence will continue (this is Kant's agreement with Hume).

“Dignity” here means a special status or authority, not personal worth.

“Synthesis” means the act of combining or relating different representations. In this case, the understanding combines the representation of A and the representation of B under the relation of cause and effect.

So Kant is saying:

A causal judgment has a stronger status than an empirical report about which events usually occur together.

Compare:

Empirical regularity: “A has usually been followed by B.”
Causal judgment: “A brings about B according to a necessary rule.”

Experience can show us repeated patterns from which we infer that one event usually follows another. But it can never show us that the second event must follow the first. A genuinely causal judgment therefore has a kind of necessity that observation alone cannot supply: the effect does not merely happen after the cause; the cause determines the effect, so that the effect follows from it according to a rule.

Kant wants us to compare:

Conceptual truth: A square has four sides.
You can know this by analyzing the concept square.
Causal rule: Heating metal makes it expand.
You cannot establish this just by analyzing the concept heat. You need empirical evidence.

Kant therefore separates two claims:

A priori causal principle: Every event must have some cause and occur according to a rule.
Particular causal rule: Heating this kind of metal under these conditions causes it to expand by a particular amount.

---

## A hypothetical coffee study

<ul>
<li class = "fragment">Suppose a study finds that, on average, coffee drinkers live longer than people who don’t drink coffee.</li>
<li class = "fragment">The ensuing headlines proclaim that “coffee drinkers live longer,” which would be a true statement.</li>
<li class = "fragment">But someone who hears about this study might say, “I should start drinking coffee so that I’ll live longer”</li> 
<li class = "fragment">This conclusion has great appeal, but it is founded on two related misunderstandings. <strong>What are they?</strong></li>
</ul>

Notes:
- Suppose a study finds that, on average, coffee drinkers live longer than people who don’t drink coffee. 
- The ensuing headlines proclaim that “coffee drinkers live longer,” which would be a true statement. 
- But someone who hears about this study might say, “I should start drinking coffee so that I’ll live longer.” 
- This conclusion has great appeal, but it is founded on two related misunderstandings. What are they?
- First, there is an implicit assumption that you only have to start drinking coffee to be just like the coffee drinkers in the study. 
- The coffee drinkers in the study were likely different from the people who were not coffee drinkers in various ways (diet, exercise, wealth, etc.). 
- Some of these characteristics may indeed be consequences of drinking coffee, but some may be pre-existing characteristics. 
- Simply starting to drink coffee may not make you similar to the coffee drinkers in the study.
- The second misunderstanding turns on an ambiguity in the expression “live longer.” 
- What comparison is being made here? 
- The study found that, on average, members of one group (coffee drinkers) live longer than members of another group (people who don’t drink coffee). 
- But when people say that doing something will make you live longer, they generally mean that it will make you live longer than if you didn’t do it. 
- In other words, the relevant comparison is not between the results experienced by people who take one course of action and people who take another, but between the results of two alternative courses of action that an individual may take.
- So if a person starts drinking coffee, then to determine the effect of coffee drinking on the length of her life, you’d need to know not only her actual lifespan but also her lifespan if she hadn’t started drinking coffee. 
- This is known as a “counterfactual” because it requires considering something other than what in fact happened. 

---

## Obstacles to causal inference

<ul>
<li class = "fragment">Cofounding (alternate reasoning)</li>
<li class = "fragment">Selection bias</li>
<li class = "fragment">Spurious correlation</li>
<li class = "fragment">Reverse causality</li>
</ul>


Notes:
Cofounding: One reason why two factors may be correlated even though there is no cause-and-effect relationship is that they have a common cause. 
- Suppose we review hospital records and compare the outcomes of patients with a certain disease who did and did not receive a new drug. 
- This might sound like a good way to determine how well the drug works. 
- However, it can easily result in what is called “confounding by indication”: certain biases may have influenced which patients received the new drug. 
- For example, if the patients who got the new drug were the sicker ones, then even if the drug helps, the outcomes of the patients who received it may be worse than the outcomes of those who did not.

Selection bias: Misleading correlations may also arise due to the way subjects are selected to be part of a study. 

- For example, there is evidence that certain studies of an association between breast implants and connective tissue disease may have suffered from selection bias. 
- Suppose participation in a study was greater for women with implants and also for women with connective tissue disease (perhaps these two groups were more likely to respond to a questionnaire than women from neither group)
- The study would then include a disproportionately large number of women with both implants and connective tissue disease, leading to an association even if there were no causation at all. 

Spurious correlation: With the emergence of big data — enormous data sets collected automatically, combed for patterns by powerful computing systems — correlations can be mass-produced. 
- The trouble is that many of them will be meaningless. 
- This is known as the problem of “false discovery”: A small number of meaningful associations is easily drowned in a sea of chance findings. 
- Sheer volume of data does not warrant a claim about causation

Reverse causality: Even if there is indeed a causal relationship between two factors, there is still the question of which is the cause and which is the effect 
- In other words, what is the direction of causation? By itself, a correlation tells us nothing about this. 
- FLEA EXAMPLE

---

## Do we need causality with big data?

<div class="fragment small-text">

> This is a world where massive amounts of data and applied mathematics replace every other tool that might be brought to bear. Out with every theory of human behavior, from linguistics to sociology. Forget taxonomy, ontology, and psychology. Who knows why people do what they do? The point is they do it, and we can track and measure it with unprecedented fidelity. 

> With enough data, the numbers speak for themselves….Correlation supersedes causation, and science can advance even without coherent models, unified theories, or really any mechanistic explanation at all.

<em>Chris Anderson, “The End of Theory: The Data Deluge Makes the Scientific Method Obsolete”, 2008</em>

</div>

Notes:

Anderson suggests that correlations, easily computed from huge quantities of data, are more important and valuable than attempts to develop explanatory frameworks. 
It is true that correlations can be valuable, especially to obtain predictions — provided, of course, that the correlations are not simply due to chance. 

---

## What are the limits?

<ul>
<li class = "fragment">But what they cannot do is tell us what will happen if we intervene.</li>

<li class = "fragment">For this, we need to know if we have enough evidence to assert that a causal relationship truly exists.</li>
</ul>

---

## Introduction to R

<div class="fragment">
To do our analyses in this class, we'll be using R. So let's dive in!
</div>


