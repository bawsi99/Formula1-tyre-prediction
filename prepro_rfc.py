class Preprocessing:
    def __init__(self) -> None:
        pass
    def callingfromsheetthroughapi(SAMPLE_SPREADSHEET_ID, SERVICE_ACCOUNT_FILE):
        from googleapiclient.discovery import build
        from google.oauth2 import service_account
        import pandas as pd
        SCOPES = ['https://www.googleapis.com/auth/spreadsheets']

        creds = None
        creds = service_account.Credentials.from_service_account_file(
                SERVICE_ACCOUNT_FILE, scopes=SCOPES)

        # The ID and range of a sample spreadsheet.
        service = build('sheets', 'v4', credentials=creds)

        # Call the Sheets API
        sheet = service.spreadsheets()
        result = sheet.values().get(spreadsheetId=SAMPLE_SPREADSHEET_ID,range='maindataset_2022!A1:M963').execute()
        values = result.get('values', [])
        dataset = pd.DataFrame(values)
        return dataset
    
    def commonpre(dataset):
        dataset = dataset.iloc[1:,3:]
        dataset.columns =['laps_completed', 'pitstop_no.', 'tyre_age', 'laps_left', 'position', 'race_track', 'total_laps', 'year', 'tyre', 'tyre_changed']
        dataset.replace(' ', '_', inplace = True)
        dict={
            'belgian':0.5,
            'silverstone':0.3,
            'monza':0.5,
            'australian':0.1,
            'dutch':0.3,
            'austrian':0.2,
            'bahrain':0.3,
            'austin':0.3,
            'canada':0.2,
            'miami':0.3,
            'hungary':0.3,
            'spanish':0.4,
            'abu_dhabi':0.3,
            'french':0.4,
            'united_states':0.3,
            'styrian':0.2,
            'portuguese':0.4,
            'russian':0.2,
            'eifel':0.2,
            'emilia_romagna':0.5,
            'italian':0.5,
            'bahrain':0.3,
            'tuscany':0.5,
            'azerbaijan':0.1,
            'saudi_arabian':0.2,
            'japanese':0.5,
            'chinese':0.4,
            'monaco':0.1,
            'mexican':0.1,
            'brazilian':0.3,
            'singapore':0.2
        }
        
        for racetrack,val in dict.items():
            dataset.replace(racetrack,val,inplace=True)

        #coverting medium soft and hard values
        dataset.replace("medium",2,inplace=True)
        dataset.replace("soft",1,inplace=True)
        dataset.replace("hard",3,inplace=True)

        # using dictionary to convert specific columns
        convert_dict = {
                        'laps_completed':int, 
                        'pitstop_no.':int, 
                        'tyre_age':int, 
                        'laps_left':int, 
                        'position':int, 
                        'race_track':float, 
                        'total_laps':int, 
                        'year':int, 
                        'tyre':int, 
                        'tyre_changed':int
                        }
        
        dataset = dataset.astype(convert_dict)

        dataset=dataset[dataset['tyre_age'] > 9]
        dataset=dataset[dataset['position'] < 18]
        #removing all pitstops made after 80% of a race as it is very unlikely that a pitstop is made after that 
        dataset=dataset[dataset['laps_left']>13]
        #end of cleaning and common preprocessing phase for all models
        #dropping laps completed and year as they are not affecting the accuracy of the models
        dataset.drop(columns='laps_completed',axis=1,inplace=True)
        dataset.drop(columns='year',axis=1,inplace=True)
        return dataset 


