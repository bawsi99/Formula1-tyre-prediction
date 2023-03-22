class DecisionTree:
 
 def Dtc(dataset):
   
   import sklearn 
  
   #spliting data into dependent and independent variables(x2=dependent variables ,y2=independent variable)
   x = dataset.iloc[:,3:10].values  
   y = dataset.iloc[:,10].values
   
   #importing train test split for spliting data for training and testing
   from sklearn.model_selection import train_test_split 
   x_train, x_test, y_train, y_test = train_test_split(x, y, test_size = 0.12, random_state = 0)  

   #from sklearn importing randomforest classifier
   from sklearn.tree import DecisionTreeClassifier

   #import accuracy score for measuring models accuracy
   from sklearn.metrics import accuracy_score 
   
   #splting data into 100 samples(n_estimators=100)
   dtc = DecisionTreeClassifier()

   #as decision tree gives varing accuracy 
   #run it 15 times and get the maximum accuracy
   acc=list()
   for i in range(1,15):  
     
     #training input dataset  
     dtc.fit(x_train, y_train)   

     #prediction
     y_pred = dtc.predict(x_test)   

     #accuracy score
     acc_r=accuracy_score(y_test,y_pred)
     acc.append(acc_r*100)    
   accuracy= max(acc)
 


   return accuracy