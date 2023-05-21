import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(50),
        child: const Text('There is a wide range of machine learning models available to build such a model, hence we have prepared a comparison study.\nWe have implemented various models across various categories of machine learning: Deep Learning, Reinforcement Learning and Supervised Learning.\nThe model will be used to help us choose the best tyre compound based on our research on the Formula 1 racing series. The outcomes demonstrate that the model makes logical choices and responds to the specific racial issue. This study will help us determine which model gives us the best result for such a complex sport.',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w200),),
      );
  }
}
