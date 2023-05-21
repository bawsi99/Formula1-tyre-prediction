import 'package:f1_models_web/locator.dart';
import 'package:f1_models_web/routing/route_names.dart';
import 'package:flutter/material.dart';

import '../../services/navigation_service.dart';

class NavigationBar1 extends StatelessWidget {
  const NavigationBar1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      color: Colors.black,
      child: Container(
        height: 85,
        padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
        child:const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(height: 80, width: 150, child: Text("F1\nVRSE",style: TextStyle(color: Colors.red,fontSize: 30,fontFamily: 'Impact'),),),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _NavBarItem('Home',HomeRoute),
              SizedBox(width: 60,),
              _NavBarItem('About',AboutRoute),
            ],)
        ],
      ),)
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final String navigationPath;
  const _NavBarItem(this.title,this.navigationPath);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        locator<NavigationService>().navigateTo(navigationPath);
      },
        child:Text(
          title,
      style: const TextStyle(fontSize: 18,color: Colors.white),
    ),
    );
  }
}


