import 'package:flutter/material.dart';

class DetailsFormat extends StatelessWidget {
  final String modelNo,modelName,modelAccuracy,modelDesc;
  const DetailsFormat(this.modelNo,this.modelName,this.modelAccuracy,this.modelDesc);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          modelNo,
          style: const TextStyle(fontWeight: FontWeight.w800, height: 0.9, fontSize: 25,color: Colors.black),
        ),
        Text(
          modelName,
          style: const TextStyle(fontWeight: FontWeight.w800, height: 0.9, fontSize: 40, color: Colors.black),
        ),
        const SizedBox(height: 20,),
        Text(
          modelAccuracy,
          style: const TextStyle(fontWeight: FontWeight.w700, height: 1.7, fontSize: 20,color: Colors.black),
        ),
        const SizedBox(height: 10,),
        Text(
          modelDesc,
          style: const TextStyle(fontSize:18,height: 1.5 , color: Colors.black),
        ),
      ],
    );
  }
}


class ModelDetail1 extends StatelessWidget {
  const ModelDetail1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
      child: const DetailsFormat(
        'Model 1',
        'Decision Tree',
        'ACCURACY OBTAINED 85.44%',
        'Working of decision tree algorithm\nA decision tree algorithm is a machine learning algorithm used for classification and regression tasks. It works by recursively partitioning the feature space into smaller and smaller subsets based on the value of the input features, ultimately producing a tree-like structure where each internal node represents a decision based on a feature and each leaf node represents a predicted class or value.\n\nOverall, the decision tree algorithm is a powerful and interpretable machine learning algorithm that can be used for a wide range of classification and regression tasks. Its main advantage is that it can capture complex nonlinear relationships between the input features and the output variable, while also providing insight into the decision-making process'
      ),
    );
  }
}

class ModelDetail2 extends StatelessWidget {
  const ModelDetail2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
      child: const DetailsFormat(
          'Model 2',
          'Random Forest',
          'ACCURACY OBTAINED 91.14%',
          'Random forest is an ensemble learning algorithm that combines multiple decision trees to improve the predictive accuracy and reduce overfitting.\n\nOverall, the random forest algorithm is a powerful and robust machine learning algorithm that can be used for a wide range of classification and regression tasks. Its main advantage is that it can capture complex nonlinear relationships between the input features and the output variable, while also reducing overfitting and providing insight into the decision-making process'
      ),
    );
  }
}

class ModelDetail3 extends StatelessWidget {
  const ModelDetail3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
      child: const DetailsFormat(
          'Model 3',
          'Reinforcement Learning',
          'ACCURACY OBTAINED 47.88%',
          'Reinforcement learning is a type of machine learning algorithm that learns through interaction with an environment to maximize a reward signal.\n\nOverall, reinforcement learning is a powerful and flexible machine learning algorithm that can be used for a wide range of tasks, such as game playing, robotics, and optimization. Its main advantage is that it can learn from experience and adapt to changing environments, while also providing insight into the decision-making process'

      ),
    );
  }
}

class ModelDetail4 extends StatelessWidget {
  const ModelDetail4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
      child: const DetailsFormat(
          'Model 4',
          'ANN',
          'ACCURACY OBTAINED 75.06%',
          'Artificial Neural Networks (ANNs) are a type of machine learning algorithm inspired by the structure and function of biological neurons in the human brain. ANNs consist of layers of interconnected nodes, called neurons, that process and transform information to produce a desired output.\n\nOverall, the ANN algorithm is a powerful and flexible machine learning algorithm that can be used for a wide range of classification, regression, and other tasks. Its main advantage is that it can learn complex nonlinear relationships between the input features and the output variable, while also providing insight into the decision-making process'
      ),
    );
  }
}
