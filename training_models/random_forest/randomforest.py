import numpy as np
from googleapiclient.discovery import build
from google.oauth2 import service_account
import pandas as pd

SCOPES = ['https://www.googleapis.com/auth/spreadsheets']
SERVICE_ACCOUNT_FILE = '../vrse-preprocessing-3a95b11cc6fd.json'

creds = None
creds = service_account.Credentials.from_service_account_file(
    SERVICE_ACCOUNT_FILE, scopes=SCOPES)

# The ID and range of a sample spreadsheet.
SAMPLE_SPREADSHEET_ID = '1xTxPTnJM6kPVqOeIg6yNL7ktvbpLTgDMXhwZJByq0YY'
service = build('sheets', 'v4', credentials=creds)

# Call the Sheets API
sheet = service.spreadsheets()
result = sheet.values().get(spreadsheetId=SAMPLE_SPREADSHEET_ID, range='maindataset_2022!A1:M963').execute()
values = result.get('values', [])
dataset = pd.DataFrame(values)
dataset = dataset.iloc[1:, 3:]
dataset.columns = ['laps_completed', 'pitstop_no.', 'tyre_age', 'laps_left', 'position', 'race_track', 'total_laps',
                   'year', 'tyre', 'tyre_changed']

dict = {
    'belgian': 0.5,
    'silverstone': 0.3,
    'monza': 0.5,
    'australian': 0.1,
    'dutch': 0.3,
    'austrian': 0.2,
    'bahrain': 0.3,
    'austin': 0.3,
    'canada': 0.2,
    'miami': 0.3,
    'hungary': 0.3,
    'spanish': 0.4,
    'abu_dhabi': 0.3,
    'french': 0.4,
    'united states': 0.3,
    'styrian': 0.2,
    'portuguese': 0.4,
    'russian': 0.2,
    'eifel': 0.2,
    'emilia_romagna': 0.5,
    'italian': 0.5,
    'bahrain': 0.3,
    'tuscany': 0.5,
    'azerbaijan': 0.1,
    'saudi_arabian': 0.2
}

for racetrack, val in dict.items():
    dataset.replace(racetrack, val, inplace=True)

# coverting medium soft and hard values
dataset.replace("medium", 2, inplace=True)
dataset.replace("soft", 1, inplace=True)
dataset.replace("hard", 3, inplace=True)

# using dictionary to convert specific columns
convert_dict = {
    'laps_completed': int,
    'pitstop_no.': int,
    'tyre_age': int,
    'laps_left': int,
    'position': int,
    'race_track': float,
    'total_laps': int,
    'year': int,
    'tyre': int,
    'tyre_changed': int
}

dataset = dataset.astype(convert_dict)

dataset = dataset[dataset['tyre_age'] > 9]
dataset = dataset[dataset['position'] < 18]
# removing all pitstops made after 80% of a race as it is very unlikely that a pitstop is made after that
dataset = dataset[dataset['laps_left'] > 13]
# end of cleaning and common preprocessing phase for all models
# dropping laps completed and year as they are not affecting the accuracy of the models
dataset.drop(columns='laps_completed', axis=1, inplace=True)
dataset.drop(columns='year', axis=1, inplace=True)

# spliting data into dependent and independent variables(x2=dependent variables ,y2=independent variable)
x2 = dataset.iloc[:, 0:7].values
y2 = dataset.iloc[:, 7].values

# importing train test split for spliting data for training and testing


# from sklearn importing randomforest classifier
from sklearn.ensemble import RandomForestClassifier

# import accuracy score for measuring models accuracy


# splting data into 100 samples(n_estimators=100)
rfc = RandomForestClassifier(n_estimators=100)

# training input dataset
rfc.fit(x2, y2)

import joblib

# Save the model as a pickle in a file
joblib.dump(rfc, '../rfc.sav')

# for taking input from user
A = int(input("pitstop_no.: "))
B = int(input("tyre_age: "))
C = int(input("laps_left:"))
D = int(input("position:"))
E = float(input("race_track:"))
F = int(input("total_laps:"))
G = int(input("tyre:"))

arr = np.array([[A, B, C, D, E, F, G]])

# Load the model from the file
rfc_from_joblib = joblib.load('../rfc.sav')

# Use the loaded model to make predictions
prediction = rfc_from_joblib.predict(arr)
print(prediction)
#
