from pre import Processing
from logic import Logic
def main():
    dataset = Processing.callingfromsheetthroughapi('1xTxPTnJM6kPVqOeIg6yNL7ktvbpLTgDMXhwZJByq0YY','rl/vrse-preprocessing-3a95b11cc6fd.json')#key file address
    #to access without api , less secure as data has to made public for viewing
    #dataset = Processing.throughsheet()
    dataset=Processing.commonpre(dataset)
    accuracy = Logic.implementation(dataset)
    print(accuracy)
    
main()
