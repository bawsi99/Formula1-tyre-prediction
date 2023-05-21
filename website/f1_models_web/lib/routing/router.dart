import 'dart:js';

import 'package:f1_models_web/main_screens/about/about_view.dart';
import 'package:f1_models_web/main_screens/home_screen.dart';
import 'package:f1_models_web/main_screens/model1/model1_view.dart';
import 'package:f1_models_web/main_screens/model2/model2_view.dart';
import 'package:f1_models_web/main_screens/model3/model3_view.dart';
import 'package:f1_models_web/main_screens/model4/model4_view.dart';
import 'package:f1_models_web/routing/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case HomeRoute:
      return _getPageRoute(HomeScreen());
    case model1Route:
      return _getPageRoute(Model1View());
    case model2Route:
      return _getPageRoute(Model2View());
    case model3Route:
      return _getPageRoute(Model3View());
    case model4Route:
      return _getPageRoute(Model4View());
    case AboutRoute:
      return _getPageRoute(AboutView());
    default:
      return _getPageRoute(AboutView());
  }
}

PageRoute _getPageRoute(Widget child) {
  return _FadeRoute(child: child);
}

class _FadeRoute extends PageRouteBuilder{
  final Widget child;
  _FadeRoute({required this.child}):
      super(
        pageBuilder: (
        BuildContext context,
            Animation<double> animation,
            Animation<double> secAnimation,
        ) => child,
        transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secAnimation,
            Widget child,
        ) => FadeTransition(opacity: animation,child: child,)
      );
}