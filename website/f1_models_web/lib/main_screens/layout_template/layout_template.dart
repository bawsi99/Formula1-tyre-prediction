import 'package:f1_models_web/locator.dart';
import 'package:f1_models_web/routing/route_names.dart';
import 'package:f1_models_web/routing/router.dart';
import 'package:f1_models_web/services/navigation_service.dart';
import 'package:f1_models_web/widgets/call_to_action/call_to_action1.dart';
import 'package:f1_models_web/widgets/centered_view/centered_view.dart';
import 'package:f1_models_web/widgets/models_details/model_detail.dart';
import 'package:f1_models_web/widgets/navigation_bar/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LayoutTemplate extends StatelessWidget {
  const LayoutTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CenteredView(
        child: Column(
          children: <Widget>[
            const NavigationBar1(),
            Expanded(
              child: Navigator(
                key: locator<NavigationService>().navigatorKey,
                onGenerateRoute: generateRoute,
                initialRoute: HomeRoute,
              ),
            ),
          ],
        ),
      ),
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
  const StickySliver({Widget? child, Key? key}) : super(child: child,key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderStickySliver();
  }

}
