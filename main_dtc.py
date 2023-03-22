from prepro_dtc import Preprocessing
from dtc import DecisionTree
def main():
    dataset = Preprocessing.callingfromsheetthroughapi('1xTxPTnJM6kPVqOeIg6yNL7ktvbpLTgDMXhwZJByq0YY','rl/vrse-preprocessing-3a95b11cc6fd.json')
    dataset=Preprocessing.commonpre(dataset)
    accuracy = DecisionTree.Dtc(dataset)
    print(accuracy)
    
main()