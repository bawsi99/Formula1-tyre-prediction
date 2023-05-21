import 'package:f1_models_web/locator.dart';
import 'package:f1_models_web/routing/route_names.dart';
import 'package:f1_models_web/services/navigation_service.dart';
import 'package:flutter/material.dart';

class CallToActionBtn extends StatelessWidget {
  final String title;
  final String navigationPath;
  const CallToActionBtn(this.title,this.navigationPath);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        locator<NavigationService>().navigateTo(navigationPath);
      },
        child:Container(
          padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 15),
          decoration: BoxDecoration(color: const Color.fromARGB(200, 0, 0, 0),
          borderRadius: BorderRadius.circular(5)),
          child: Text(title,style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color: Colors.white),
                  ),
    ),
    );
  }
}

class CallAction1 extends StatelessWidget {
  const CallAction1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CallToActionBtn('Use Model 1',model1Route);
  }
}

class CallAction2 extends StatelessWidget {
  const CallAction2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CallToActionBtn('Use Model 2',model2Route);
  }
}

class CallAction3 extends StatelessWidget {
  const CallAction3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CallToActionBtn('Use Model 3',model3Route);
  }
}

class CallAction4 extends StatelessWidget {
  const CallAction4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CallToActionBtn('Use Model 4',model4Route);
  }
}
