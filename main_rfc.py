from prepro_rfc import Preprocessing
from rfc import RandomForest
def main():
    dataset = Preprocessing.callingfromsheetthroughapi('1xTxPTnJM6kPVqOeIg6yNL7ktvbpLTgDMXhwZJByq0YY','rl/vrse-preprocessing-3a95b11cc6fd.json')
    dataset=Preprocessing.commonpre(dataset)
    accuracy = RandomForest.Rfc(dataset)
    print(accuracy)
    
main()
