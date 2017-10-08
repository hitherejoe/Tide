import 'package:flutter/material.dart';

class SearchLoadingWidget extends StatelessWidget {
  final bool isLoading;

  SearchLoadingWidget(this.isLoading);

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new CircularProgressIndicator());
  }

}