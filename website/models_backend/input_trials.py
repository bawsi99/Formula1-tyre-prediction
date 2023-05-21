# model 1 : ann.sav
# model 2 : model.vw
# model 3 : rfc.sav
# model 4 : decisiontree.sav
import joblib
import numpy as np
import pandas as pd
import os
from flask import jsonify
from sklearn.ensemble import RandomForestClassifier
from sklearn.tree import DecisionTreeClassifier
import vowpalwabbit as vw
from vowpalwabbit import pyvw

from sklearn.preprocessing import StandardScaler
sc = StandardScaler()

#model_dt = joblib.load('decisiontree.sav')
#model_rf = joblib.load('rfc.sav')
# model_ann = joblib.load('ann.sav')
#model_rl = pyvw.load('model.vw')

dict = {
    'belgian': 0.5, 'monza': 0.5, 'emilia_romagna': 0.5, 'italian': 0.5, 'tuscany': 0.5,
    'spanish': 0.4, 'french': 0.4, 'portuguese': 0.4,
    'silverstone': 0.3, 'dutch': 0.3, 'bahrain': 0.3, 'austin': 0.3, 'miami': 0.3, 'hungary': 0.3, 'abu_dhabi': 0.3, 'united states': 0.3, 'bahrain': 0.3,
    'austrian': 0.2, 'canada': 0.2, 'styrian': 0.2, 'russian': 0.2, 'eifel': 0.2, 'saudi_arabian': 0.2,
    'australian': 0.1, 'azerbaijan': 0.1
}


def to_vw_format(input):
    res = ""
    for idx, value in input.items():
        res += f" {idx}:{value}"
    return res

def inputFile(input):
    res = to_vw_format(input)
    with open("inputfile.vw", "a+") as file_object:
        # Move read cursor to the start of file.
        file_object.seek(0)
        # If file is not empty then append '\n'
        data = file_object.read(100)
        if len(data) > 0:
            file_object.write("\n")
        # Append text at the end of file
        file_object.write(res)

H = int(input("hard:"))
I = int(input("med:"))
J = int(input("soft:"))
A = int(input("tyre_age: "))
B = int(input("pitstop_no.: "))
C = int(input("laps_completed:"))
D = int(input("laps_left:"))
E = int(input("position:"))
F = float(input("race_track:"))
G = int(input("total_laps:"))
K = int(input("year:"))


scale_model = joblib.load('scaler.sav')

arr = np.array([[H,I,J,A, B, C, D, E, F, G, K]])
data = scale_model.transform(arr)

from tensorflow import keras
model = keras.models.load_model('ann4.h5')
op=model.predict(data)
for i in op:
  i[i == max(i)] = 1
  i[i<1] = 0

if op[0][0]==1:
    print('hard')
if op[0][1]==1:
    print('medium')
if op[0][2]==1:
    print('soft')
print(op)

# convert numpy array to dataframe
# df = pd.DataFrame(input, columns=['pitstop_no.', 'tyre_age', 'laps_left', 'position', 'race_track', 'total_laps', 'tyre'])
# inputFile(df)
#
#
# mod = pyvw.vw(initial_regressor='model.vw')
# r = mod.predict('inputfile.vw')
# print(arr)
# if r[0] == 1:
#     response = {"result": "soft"}
# elif r[0] == 2:
#     response = {"result": "medium"}
# elif r[0] == 3:
#     response = {"result": "hard"}
# else:
#     response = {"result": "model_error"}
# print(response)
#os.remove("inputfile.vw")
#pred_dt = model_dt.predict(arr)
#pred_rf = model_rf.predict(arr)
# pred_ann = model_ann.predict(arr)
# if pred_dt[0]==2:
#     print('Medium')
# if pred_rf[0]==2:
#     print('Medium')
# if pred_ann[0]==2:
#     print('Medium')
# print(type(pred_dt[0]))
# print(type(pred_rf[0]))
# print(pred_ann)