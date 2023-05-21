from bs4 import BeautifulSoup
import csv
import requests
from random import randint
import time

race_track="Emilia_Romagna"
# urls[0] : pitstop, urls[1] : lapchart
urls = ["https://fiaresultsandstatistics.motorsportstats.com/results/2021-pirelli-gran-premio-del-made-in-italy-e-dell-emilia-romagna/session-facts/6da3b886-b062-45ac-b972-1b138e6d998a?fact=PitStop","https://fiaresultsandstatistics.motorsportstats.com/results/2021-pirelli-gran-premio-del-made-in-italy-e-dell-emilia-romagna/session-facts/6da3b886-b062-45ac-b972-1b138e6d998a?fact=LapChart"]
# number of laps in the race
no_of_laps = 63

def pit_info():
    pitstop_html = requests.get(urls[0])
    soup = BeautifulSoup(pitstop_html.text,'lxml')

    lapchart_html = requests.get(urls[1])
    soup2 = BeautifulSoup(lapchart_html.text,'lxml')

    driver_pits = soup.find_all('tr',class_ = '_3AoAU')
    #slick-list

    tire_age=0
    
    lapchart_pos2 = soup2.find('div',class_ = 'IJtmy').find('div',class_ = 'slick-list').find('div', class_='slick-track')
    #,class_='slick-slide slick-active slick-current',class_='slick-slide slick-active',class_='slick-slide')
    with open(f'{race_track}_2021.csv', 'w') as f:
        f.write("No.,Driver,Team,Laps Completed,Pit Stop No.,Tire age,Laps Left,avg_life_of_compund,Position,Race track,red flag,driver incident,FCY,tyre,tyre changed\n")
        for driver_pit in driver_pits:
            driver_no = driver_pit.find('div',class_ = '_1TRrV _6Jxl2').text
            driver_name_team = driver_pit.find_all('a',class_ = '_1TRrV')
            driver_name = driver_name_team[0].text
            driver_team = driver_name_team[1].text
            driver_pitno_lapc = driver_pit.find_all('div',class_='_1TRrV _6Jxl2')
            driver_lapc = driver_pitno_lapc[1].text
            driver_pit_no = driver_pitno_lapc[2].text
            i=0
            index_laps=-1
            count_pos=1
            if int(driver_pit_no)>=2:
                tire_age = int(driver_lapc) - tire_age
            else:
                tire_age = int(driver_lapc)

            for xpos_drivers_laps in lapchart_pos2.children:
                xpos = xpos_drivers_laps.find('div',class_="_3QkVN")
                no_drivers_lap =xpos.find_all('div',class_='_1BvfV')
                for no_driver in (no_drivers_lap):
                    no_driver_str = str(no_driver.text)
                    index_laps=index_laps+1
                    if(index_laps==0):
                        continue
                    if((driver_no == no_driver_str) and (index_laps == int(driver_lapc))):
                        driver_pit_pos = xpos.find_previous_sibling('div',class_='_3DVzL').text
                        break

                    if(index_laps) >= no_of_laps:
                        index_laps=-1
                        count_pos=count_pos+1
                    # i=i+1
                    # xpos_drivers_laps.find('div',class_='_3DVzL').text
            #print(f'''{driver_no},{driver_name},{driver_team},{driver_pit_no},{tire_age},{driver_lapc},{driver_pit_pos}\n''')
            f.write(f'''{driver_no},{driver_name},{driver_team},{driver_lapc},{driver_pit_no},{tire_age},{no_of_laps-int(driver_lapc)},0,{driver_pit_pos},{race_track},0,0,0\n''')
            time_wait = randint(1,10)
            print(f'Waiting for {time_wait} sec')
            time.sleep(time_wait)
    

if __name__== '__main__':
    pit_info()
        