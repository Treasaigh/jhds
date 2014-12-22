Data Science Capstone
========================================================
author: Frank D. Evans
Johns Hopkins University


App Description
========================================================

Given an open entry text box, a user inputs a string of 
any length they wish and receives back a prediction of 
the next word in the phrase.
  
__Reactivity__  
The app is designed to be directly reactive, requiring no
submit button. As new words are entered, the new input 
automatically updates the models and make new predictions.
  
[Link to App on shinyapps.io](https://frankdevans.shinyapps.io/sk0-2)

Cleaning & Pre-Processing
========================================================

Using a combination of tools from the stringr package and
general REGEX coding, approximately 4.5 million corpus documents
comprising news articles, blog entries, and tweets were 
cleaned to remove:
- letter case
- punctuation, non-alpha characters
- erroneous spacing

[Link to Initial Analysis of Corpus Data](http://rpubs.com/frankdevans/jhds_capstone_milestone)

Prediction Model
========================================================

The prediction model behind the app is an R object of 4
different pre-processing models. Three of the models are 
based on n-Tokens, one based on word frequency.
  
Given an input string, the model waterfalls across the 
models in this order, giving preference to predictions
made from higher token models for higher accuracy.

***
__Model Layer Order__
- 4 Token: 3 key, 1 value
- 3 Token: 2 key, 1 value
- 2 Token: 1 key, 1 value
- Selection from most common tokens

App Function
========================================================

__Potentially Offensive Words__  
No curse or otherwise offensive words were removed from the
corpus at the time of cleaning to preserve sentence flow. 
Instead, all token records with offensive words or n-grams 
were removed from the model data frames before the data was
uploaded into the model.

__Lightweight__  
To keep the model lightweight, key values were compressed 
with integers. Additionlly, although n-Token models were 
produced for all shingle tokens that appearned more than 
once, only the top 500,000 predictions across each token 
model (1.5 million total) were loaded into the object data 
of the background function. During testing, this preserved 
sub-second response time from the shiny server to make the 
user experience as good as possible.













