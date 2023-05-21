from flask import Flask, jsonify, request
import numpy as np
import pandas as pd
from vowpalwabbit import pyvw
from tensorflow import keras
import os
import joblib

app = Flask(__name__)


@app.route('/model1', methods=['POST'])
def model1():
    data = request.get_json()
    new_data = [[int(data["pitstop_no"]), int(data["tyre_age"]),
                int(data["laps_left"]), int(data["position"]),
                float(data["race_track"]), int(data["total_laps"]),
                int(data["tyre"])]]
    new_data = np.array(new_data)
    model_dt = joblib.load('decisiontree.sav')
    pred_dt = model_dt.predict(new_data)
    if pred_dt[0] == 1:
        response = {"result": "soft"}
    elif pred_dt[0] == 2:
        response = {"result": "medium"}
    elif pred_dt[0] == 3:
        response = {"result": "hard"}
    else:
        tyre = "model_error"
        response = {"result": tyre}
    res_json = jsonify(response)
    return res_json

@app.route('/model2', methods=['POST'])
def model2():
    data = request.get_json()
    new_data = [[int(data["pitstop_no"]), int(data["tyre_age"]),
                int(data["laps_left"]), int(data["position"]),
                float(data["race_track"]), int(data["total_laps"]),
                int(data["tyre"])]]
    new_data = np.array(new_data)
    model_rf = joblib.load('rfc.sav')
    pred_rf = model_rf.predict(new_data)
    if pred_rf[0] == 1:
        response = {"result": "soft"}
    elif pred_rf[0] == 2:
        response = {"result": "medium"}
    elif pred_rf[0] == 3:
        response = {"result": "hard"}
    else:
        tyre = "model_error"
        response = {"result": tyre}
    res_json = jsonify(response)
    return res_json


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

@app.route('/model3', methods=['POST'])
def model3():
    data = request.get_json()
    new_data = [[int(data["pitstop_no"]), int(data["tyre_age"]),
                int(data["laps_left"]), int(data["position"]),
                float(data["race_track"]), int(data["total_laps"]),
                int(data["tyre"])]]
    new_data = np.array(new_data)
    df = pd.DataFrame(new_data, columns=['pitstop_no.', 'tyre_age', 'laps_left', 'position', 'race_track', 'total_laps', 'tyre'])
    inputFile(df)

    mod = pyvw.vw(initial_regressor='model.vw')
    r = mod.predict('inputfile.vw')

    if r == 1:
        response = {"result": "soft"}
    elif r == 2:
        response = {"result": "medium"}
    elif r == 3:
        response = {"result": "hard"}
    else:
        response = {"result": "model_error"}

    res_json = jsonify(response)
    os.remove("inputfile.vw")
    return res_json

@app.route('/model4', methods=['POST'])
def model4():
    data = request.get_json()
    new_data = [[int(data["H"]), int(data["I"]), int(data["J"]),
                 int(data["tyre_age"]), int(data["pitstop_no"]),
                 int(data["laps_completed"]), int(data["laps_left"]),
                 int(data["position"]), float(data["race_track"]),
                 int(data["total_laps"]), 2023]]

    new_data = np.array(new_data)

    scale_model = joblib.load('scaler.sav')

    # arr = np.array([[H, I, J, A, B, C, D, E, F, G, K]])
    data = scale_model.transform(new_data)
    model = keras.models.load_model('ann4.h5')

    op = model.predict(data)
    for i in op:
        i[i == max(i)] = 1
        i[i < 1] = 0

    if op[0][0] == 1:
        response = {"result": "hard"}
    elif op[0][1] == 1:
        response = {"result": "medium"}
    elif op[0][2] == 1:
        response = {"result": "soft"}
    else:
        response = {"result": "model_error"}

    res_json = jsonify(response)
    return res_json

@app.route('/')
def hello_model():
    return 'Hello Model'


if __name__ == "__main__":
    app.run(debug=True)
