import numpy as np
from googleapiclient.discovery import build
from google.oauth2 import service_account
import pandas as pd
import vowpalwabbit as vw

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

from sklearn.preprocessing import LabelEncoder

le = LabelEncoder()

# encoding
dataset['tyre_changed'] = le.fit_transform(dataset['tyre_changed'])
dataset['tyre'] = le.fit_transform(dataset['tyre'])

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

dataset = dataset[dataset['tyre_age'] > 10]


# removing all pitstops made after 80% of a race as it is very unlikely that a pitstop is made after that
def completion(dataset, completion):
    dataset = dataset[(dataset['laps_completed']) < (completion / 100 * (dataset['total_laps']))]
    return dataset


dataset1 = completion(dataset, 80)

# end of cleaning and common preprocessing phase for all models

# for particular model
# adding 1 to the values vowpal wabbit expects labels to start from 1 , can try for change in accuraccy

dataset1['tyre_changed'] = dataset1['tyre_changed'] + 1
dataset1['tyre'] = dataset1['tyre'] + 1
dataset1 = dataset1.drop('laps_completed', axis=1)
dataset1 = dataset1.drop('year', axis=1)


def to_vw_format(row):
    res = f"{int(row['tyre_changed'])} |"
    for idx, value in row.drop(["tyre_changed"]).items():
        res += f" {idx}:{value}"
    return res


# clearing the text file
with open("../input.vw", 'w') as file:
    pass
with open("../training.vw", 'w') as file:
    pass
with open("../testing.vw", 'w') as file:
    pass

# adding the input data into a text file
for ex in dataset1.apply(to_vw_format, axis=1):
    # print(ex)
    with open("../input.vw", "a+") as file_object:
        # Move read cursor to the start of file.
        file_object.seek(0)
        # If file is not empty then append '\n'
        data = file_object.read(100)
        if len(data) > 0:
            file_object.write("\n")
        # Append text at the end of file
        file_object.write(ex)

from sklearn import model_selection

training_data, testing_data = model_selection.train_test_split(
    dataset1, test_size=0.2
)
for ex in training_data.apply(to_vw_format, axis=1):
    # print(ex)
    with open("../training.vw", "a+") as file_object:
        # Move read cursor to the start of file.
        file_object.seek(0)
        # If file is not empty then append '\n'
        data = file_object.read(100)
        if len(data) > 0:
            file_object.write("\n")
        # Append text at the end of file
        file_object.write(ex)

for ex in testing_data.apply(to_vw_format, axis=1):
    # print(ex)
    with open("../testing.vw", "a+") as file_object:
        # Move read cursor to the start of file.
        file_object.seek(0)
        # If file is not empty then append '\n'
        data = file_object.read(100)
        if len(data) > 0:
            file_object.write("\n")
        # Append text at the end of file
        file_object.write(ex)

# training
# learn from training set with multiple passes
model = vw.Workspace(" -c --passes 20 --oaa 3 --quiet -f model1.vw")
model.learn('training.vw')

# predict from the testing set
predictions = []
# for example in testing_data.apply(to_vw_format, axis=1):
predicted_class = model.predict('testing.vw')
predictions.append(predicted_class)

# accuracy
accuracy = len(testing_data[testing_data.iloc[:, -1].values == predictions]) / len(testing_data)

print(f"Model accuracy {accuracy}")

# loading model from disk and testing AGAIN
from vowpalwabbit import pyvw

pred = []
mod = pyvw.vw(initial_regressor='model1.vw')
result = mod.predict('testing.vw')
print('rsult: ',result)
pred.append(result)
acc = len(testing_data[testing_data.iloc[:, -1].values == pred]) / len(testing_data)
print(acc)
