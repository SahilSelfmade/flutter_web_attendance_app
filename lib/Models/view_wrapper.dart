import 'package:flutter/material.dart';

class ViewWrapper extends StatelessWidget {
  final Widget desktopView;
  final Widget mobileView;

  const ViewWrapper({Key? key, required this.desktopView, required this.mobileView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 715 && MediaQuery.of(context).size.height >550) {
        return desktopView;
      } else {
        return mobileView;
      }
    });
  }
}
