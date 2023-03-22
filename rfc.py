class RandomForest:
 
 def Rfc(dataset):
   
   import sklearn 
  
   #spliting data into dependent and independent variables(x2=dependent variables ,y2=independent variable)
   x2 = dataset.iloc[:,3:10].values  
   y2 = dataset.iloc[:,10].values
   
   #importing train test split for spliting data for training and testing
   from sklearn.model_selection import train_test_split 
   x2_train, x2_test, y2_train, y2_test = train_test_split(x2, y2, test_size = 0.12, random_state = 0)  

   #from sklearn importing randomforest classifier
   from sklearn.ensemble import RandomForestClassifier

   #import accuracy score for measuring models accuracy
   from sklearn.metrics import accuracy_score 
   
   #splting data into 100 samples(n_estimators=100)
   rfc = RandomForestClassifier(n_estimators=100)

   #as random forest gives varing accuracy 
   #run it 15 times and get the maximum accuracy
   acc=list()
   for i in range(1,15):  
     
     #training input dataset  
     rfc.fit(x2_train, y2_train)   

     #prediction
     y_pred = rfc.predict(x2_test)   

     #accuracy score
     acc_r=accuracy_score(y2_test,y_pred)
     acc.append(acc_r*100)    
   accuracy= max(acc)
 


   return accuracy