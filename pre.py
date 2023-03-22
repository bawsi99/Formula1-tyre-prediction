class Processing:
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
        result = sheet.values().get(spreadsheetId=SAMPLE_SPREADSHEET_ID,range='maindataset_2022').execute()
        values = result.get('values', [])
        dataset = pd.DataFrame(values)
        
        # modify the function to read from a local csv file 
        
        return dataset
    
    def throughsheet():
        import pandas as pd
        sheet_id = '1fd9M8bw-SE93f2njshp003e9xbCr_CzKOw0_K6OMOJ4'
        sheet_name = 'maindataset_2022'
        url = f'https://docs.google.com/spreadsheets/d/{sheet_id}/gviz/tq?tqx=out:csv&sheet={sheet_name}'
        
    
    def commonpre(dataset):
        import pandas as pd
        dataset = dataset.iloc[1:,3:]
        dataset.columns =['laps_completed', 'pitstop_no.', 'tyre_age', 'laps_left', 'position', 'race_track', 'total_laps', 'year', 'tyre', 'tyre_changed']
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
            'chinese':0.4,
            'japanese':0.5,
            'monaco':0.1,
            'mexican':0.1,
            'brazilian':0.3,
            'singapore':0.2
        }
        
        for racetrack,val in dict.items():
            dataset.replace(racetrack,val,inplace=True)


        from sklearn.preprocessing import LabelEncoder
        le=LabelEncoder()

        #encoding  
        dataset['tyre_changed']=le.fit_transform(dataset['tyre_changed'])
        dataset['tyre']=le.fit_transform(dataset['tyre'])

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

        #removing all pitstops made after 80% of a race as it is very unlikely that a pitstop is made after that 
        def completion(dataset,completion):
            dataset = dataset[(dataset['laps_completed']) < (completion/100*(dataset['total_laps']))]
            return dataset

        dataset=completion(dataset,80)
        return(dataset)
        #end of cleaning and common preprocessing phase for all models 


