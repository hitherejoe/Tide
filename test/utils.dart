import 'package:flutter/material.dart';

class MockableApp extends StatelessWidget {
  final Widget drawer;
  final Widget body;
  final AppBar appBar;
  final Widget scaffold;

  MockableApp({this.drawer, this.body, this.appBar, this.scaffold});

  @override
  Widget build(BuildContext context) {
    if (scaffold != null) {
      return new MaterialApp(home: scaffold);
    }
    return new MaterialApp(
        home: new Scaffold(drawer: drawer, body: body, appBar: appBar));
  }
}