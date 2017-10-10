import 'package:flutter/material.dart';
import 'package:tide/ui/main/tabbed_feeds_widget.dart';
import 'package:tide/resources/strings.dart';

void main() {
  runApp(new TidalApp());
}

class TidalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: Strings.appName,
        theme: new ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blueGrey,
        ),
        home: new FeedsWidget());
  }

}