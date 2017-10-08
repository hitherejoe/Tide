import 'package:flutter/material.dart';
import 'package:tidal/utils.dart';

class PhotoView extends StatelessWidget {
  static const String path = "/settings";
  final String url;

  PhotoView({Key key, this.url}) : super(key: key);

  static void navigateTo(BuildContext context, String url, {bool replace: false}) {
    materialNavigateTo(context, new PhotoView(url: url),
        path: PhotoView.path, replace: replace);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new Hero(
            key: new Key(url),
            tag: url,
            child: new Image.network(url, fit: BoxFit.cover)));
  }

}