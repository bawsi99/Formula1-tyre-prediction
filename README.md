# Formula1-tyre-prediction

This project is part of our college project, 
We have build a formula 1 tyre predictor , which predicts what type of tyre should a driver use next(soft/mdeium/hard)
Lack of public data and publicly available research on how a team decides stratergy , we have developed a model on the basis parameters which affects tyre stratergy.
After deciding on the paramters, we have collected data using a web scrapping model primarily from the FIA website of the last four seasons(2022-2019)
Certain assumptions have been made
and data cleaning has been done to only train the model on data that is a pure stratergy call and not due to some incident.
We have then used this data on several models to build a comparision study.
Data from the model is fetched directly from google sheets using the google sheets api, anyone who wants to do the same can create a copy of the sheet and enable the api, we have also provided the csv file.
We are also working on building a website to deploy the models.

pre.py file is the common extraction and cleaning of data for all models 
main.py file is to  run th model 
each model is contained in a separate file 

models used:
Reinforcement Learning - Vowpal Wabbit (posted in repo)
 
yet to be committed on repo-
Deep Learning - Artificial Neural Network
Machine Learning - Random Forest 


We will be updating this repo as and when new models are ready or we if find new preprocessing and cleaning techinques which improve accuracy
We are also working on a an Recurrent Neural Network based solution with time stamped data , which will be trained on the 1st and 2nd pitstop data and will predict
the 2nd and 3rd pitstop respectively.

Code also has been mentioned to access data through sheet without using api and can also be accessed through csv file from local machine
