import 'dart:js_util';

import 'package:f1_models_web/main_screens/layout_template/layout_template.dart';
import 'package:f1_models_web/widgets/call_to_action/call_to_action1.dart';
import 'package:f1_models_web/widgets/centered_view/centered_view.dart';
import 'package:f1_models_web/widgets/models_details/model_detail.dart';
import 'package:f1_models_web/widgets/navigation_bar/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: [
          ...List<int>.generate(1, (index) => index).map(
                (e) => SliverToBoxAdapter(
              child: Expanded(
                child: Card(
                  elevation: 50,
                  margin: const EdgeInsets.all(60),
                  color: Colors.redAccent,
                  //color: Colors.white30,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.redAccent,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(children: [
                    ModelDetail1(),
                    Expanded(child: Center(child: CallAction1(),),)
                  ],),),
              ),
            ),
          ),
          ...List<int>.generate(1, (index) => index).map(
                (e) => SliverToBoxAdapter(
              child: Expanded(
                child: Card(
                  elevation: 50,
                  margin: const EdgeInsets.all(60),
                  color: Colors.redAccent,
                  //color: Colors.white30,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.redAccent,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(children: [
                    ModelDetail2(),
                    Expanded(child: Center(child: CallAction2(),),)
                  ],),),
              ),
            ),
          ),
          ...List<int>.generate(1, (index) => index).map(
                (e) => SliverToBoxAdapter(
              child: Expanded(
                child: Card(
                  elevation: 50,
                  margin: const EdgeInsets.all(60),
                  color: Colors.redAccent,
                  //color: Colors.white30,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.redAccent,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(children: [
                    ModelDetail3(),
                    Expanded(child: Center(child: CallAction3(),),)
                  ],),),
              ),
            ),
          ),
          ...List<int>.generate(1, (index) => index).map(
                (e) => SliverToBoxAdapter(
              child: Expanded(
                child: Card(
                  elevation: 50,
                  margin: const EdgeInsets.all(60),
                  color: Colors.redAccent,
                  //color: Colors.white30,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.redAccent,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(children: [
                    ModelDetail4(),
                    Expanded(child: Center(child: CallAction4(),),)
                  ],),),
              ),
            ),
          ),
          ...List<int>.generate(1, (index) => index).map(
                (e) => SliverToBoxAdapter(
              child: Container(
                height: 200,
                color: Colors.black,
              ),
            ),
          ),

        ]
    );
  }
}

class RenderStickySliver extends RenderSliverSingleBoxAdapter{
  RenderStickySliver ({RenderBox? child}) : super(child: child);

  @override
  void performLayout() {
    // TODO: implement performLayout
    var myCurrentConstraints = constraints;

    geometry = SliverGeometry.zero;

    child?.layout(
      constraints.asBoxConstraints(),
      parentUsesSize: true,
    );

    double childExtent = child?.size.height ?? 0;

    geometry = SliverGeometry(
      paintExtent: childExtent,
      maxPaintExtent: childExtent,
      paintOrigin: constraints.scrollOffset,
    );
    setChildParentData(child!, constraints, geometry!);
  }
}

class StickySliver extends SingleChildRenderObjectWidget{
  StickySliver({Widget? child, Key? key}) : super(child: child,key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderStickySliver();
  }

}
