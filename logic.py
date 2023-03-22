class Logic:
    #for particular model 
    #adding 1 to the values vowpal wabbit expects labels to start from 1 , can try for change in accuraccy 
    def implementation(dataset1):
        import vowpalwabbit as vw
        import pandas as pd
        import numpy as np
        dataset1['tyre_changed']=dataset1['tyre_changed']+1
        dataset1['tyre']=dataset1['tyre']+1
        
        def to_vw_format(row):
            res = f"{int(row['tyre_changed'])} |"
            for idx, value in row.drop(["tyre_changed"]).items():
                res += f" {idx}:{value}"
            return res

        #clearing the text file 
        with open("rlgit/input.vw",'w') as file:
            pass
        with open("rlgit/training.vw",'w') as file:
            pass
        with open("rlgit/testing.vw",'w') as file:
            pass

        #adding the input data into a text file 
        for ex in dataset1.apply(to_vw_format, axis=1):
            with open("rlgit/input.vw", "a+") as file_object:
                # Move read cursor to the start of file.
                file_object.seek(0)
                # If file is not empty then append '\n'
                data = file_object.read(100)
                if len(data) > 0 :
                    file_object.write("\n")
                # Append text at the end of file
                file_object.write(ex)

        from sklearn import model_selection
        training_data, testing_data = model_selection.train_test_split(
            dataset1, test_size=0.2
        )
        for ex in training_data.apply(to_vw_format, axis=1):
  
            with open("rlgit/training.vw", "a+") as file_object:
                # Move read cursor to the start of file.
                file_object.seek(0)
                # If file is not empty then append '\n'
                data = file_object.read(100)
                if len(data) > 0 :
                    file_object.write("\n")
                # Append text at the end of file
                file_object.write(ex)

        for ex in testing_data.apply(to_vw_format, axis=1):
            with open("rlgit/testing.vw", "a+") as file_object:
                # Move read cursor to the start of file.
                file_object.seek(0)
                # If file is not empty then append '\n'
                data = file_object.read(100)
                if len(data) > 0 :
                    file_object.write("\n")
                # Append text at the end of file
                file_object.write(ex)

        #training
        # learn from training set with multiple passes
        model = vw.Workspace("-c --passes 25 --oaa 3 --quiet ")
        model.learn('rlgit/training.vw')

        # predict from the testing set
        predictions = []
        # for example in testing_data.apply(to_vw_format, axis=1):
        predicted_class = model.predict('rlgit/testing.vw')
        predictions.append(predicted_class)

        #accuracy
        accuracy = len(testing_data[testing_data.iloc[:,-1].values == predictions]) / len(testing_data)
        return accuracy