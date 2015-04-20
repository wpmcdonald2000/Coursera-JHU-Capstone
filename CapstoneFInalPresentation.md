CapstoneFinalPresentation
N-Gram Word Predictor: JHU Capstone
========================================================
title: "Coursera N-Gram Word Predictor"
author: William McDonald
date: 4/19/2015
transition: rotate

Overview
========================================================
An exploration into the difficulties of creating a text prediction App.

My predictive app can be found at the following shinyapps.io URL: [Text Predictor](https://www.shinyapps.io/admin/#/application/22724)

The interface is straightforward, as you type text in the "Predict Word" Text Box
The application will display the predicted next word in the display area. 

The prediction is based on a frequency analysis of sample phrases in a supplied text data set

Method and Madness
========================================================
Underlying the app is an analysis of an available corpus of text. 

* Sample texts from three sources (Blogs, News Feeds, and Twitter Text) were provided in 4 languages. 
* Cumulatively, the English body of text alone amounted to over 4 million lines, 109 million words and  close to 600 thousand unique words (before cleaning)!
* These texts were initially cleaned by changing all text to lowercase, removing punctuation, numbers, hashtags, special and unicode characters, and profanity [as defined here](http://www.bannedwordlist.com/lists/swearWords.txt). The resulting cleaned text was then sampled and broken into n-grams of length 2, 3, and 4 words using the RWeka package in R.


Model and Implementation
========================================================
The app runs on code that stores the n-grams and their frequencies as hash tables. As text is entered into the text box, predicted text matches are fetched from those tables .

Using a "Stupid" backoff model [(as proposed here)](http://www.cs.columbia.edu/~smaskey/CS6998-0412/supportmaterial/langmodel_mapreduce.pdf) the last 3 words of the phrase is checked for matches in a 4-gram table. If no match is found, the process continues, checking the last 2 words against a 3-gram table, then finally the last word is checked against the predictors in the 2-gram table. In all cases, matches halt the program until new or additional text is entered. If no match is found, the word "the" is returned as the most commonly used word.

Further Work
========================================================
<small>Okay, I admit it. This project kicked me in the ... (expletive deleted)
The process was very humbling and showed all my weaknesses in both coding in R as well as working out methods to incorporate ideas that I thought might be beneficial to the resutling app. For Example:
 1. A spelling checker on the front end for text entry in the app. Any analysis of n-grams from supplied texts only work if they have something to match. Mispellings throw all predictions, regardless of how they are determined, out the window.
 2. My feeble skills were not up to the task of creating an app that adjusted to the user, learning from their own idiosyncratic usage of language. 
 3. Exploration of some modeling techniques designed to take into account parts of speech or sentence structure! I briefly explored some of the work [Google Books Ngram Viewer](http://storage.googleapis.com/books/ngrams/books/datasetsv2.html) has been doing developing an n-gram corpus but quickly got overwhelmed. I do not know if "diagramming sentences" can work efficently in a predictive environment.</small>

