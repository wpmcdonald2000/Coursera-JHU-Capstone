CapstoneFinalPresentation
N-Gram Word Predictor: JHU Capstone
========================================================
title: "Coursera N-Gram Word Predictor"
author: William McDonald
date: 4/19/2015
transition: rotate

Overview
========================================================
The capstone project was an exploration into the difficulties of creating a text prediction App on  the Shiny.io server.

My predictive app can be found here: 
(http://wpmcdonald.shinyapps.io/Shiny_app)

The interface is straightforward, as you type text in the "Input Section" Text Box, the application will display the predicted next word in the display area. 

The prediction is based on a frequency analysis of sample phrases in a supplied text data set. More in depth information about the methodology, trials and pitfalls can be found on the "Methods" tab of the app.

Method and Madness
========================================================
Underlying the app is an analysis of an available corpus of text. 

* Sample texts from three sources (Blogs, News Feeds, and Twitter Text) were provided in 4 languages. 
* Cumulatively, the English body of text alone amounted to over 4 million lines, 109 million words and  close to 600 thousand unique words (before cleaning)!
* These texts were initially cleaned by changing all text to lowercase, removing punctuation, numbers, hashtags, special and unicode characters, and profanity [as defined here](http://www.bannedwordlist.com/lists/swearWords.txt). The resulting cleaned text was then sampled and broken into n-grams of length 2, 3, and 4 words using the RWeka package in R.


Model and Implementation
========================================================
The app runs on code that stores the top 3 n-grams and their frequencies in a single hash table. The hash table slices the n-grams into a "predictor" phrase of 1 to 3 words and the "predicted word" result (the last word of the n-gram). As text is entered into the text box, predicted word matches are fetched from those tables based on the predictor phrase.

Using a "Stupid" backoff model [(as proposed here)](http://www.cs.columbia.edu/~smaskey/CS6998-0412/supportmaterial/langmodel_mapreduce.pdf) the first 3 words of the a 4 word phrase is checked for matches. If no match is found, the process continues, checking the first 2 words of 3 word phrases, then finally the first word is checked against the predictors in a two word phrase. In all cases, matches halt the program until new or additional text is entered. If no text is entered the program asks for input.

Further Work
========================================================
<small>Okay, I admit it. This project kicked me in the ... (expletive deleted)
The process was very humbling and showed all my weaknesses in both coding in R as well as working out methods to incorporate ideas that I thought might be beneficial to the resutling app. For Example:
 1. A "fuzzy" spelling checker that would allow near matches to be included in the predictions. Any analysis of n-grams from supplied texts only work if they have something to match. Mispellings throw all predictions, regardless of how they are determined, out the window.
 2. My feeble skills were not up to the task of creating an app that adjusted to the user, learning from their own idiosyncratic usage of language. 
 3. Exploration of some modeling techniques designed to take into account parts of speech or sentence structure! I briefly explored some of the work [Google Books Ngram Viewer](http://storage.googleapis.com/books/ngrams/books/datasetsv2.html) has been doing developing an n-gram corpus but quickly got overwhelmed. I do not know if "diagramming sentences" can work efficently in a predictive environment.</small>

