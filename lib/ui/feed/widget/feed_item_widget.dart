import 'package:flutter/material.dart';
import 'package:tide/ui/feed/model/photo.dart';
import 'package:tide/ui/feed/widget/photo_widget.dart';

class FeedItemWidget extends StatelessWidget {

  final Photo photo;

  FeedItemWidget({Key key, this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SliverToBoxAdapter(
        child: new GestureDetector(
          onTap: () { PhotoView.navigateTo(context, photo.url); },
            child: new Hero(
                tag: photo.url,
                child: new Image.network(photo.url,
                    fit: BoxFit.cover, height: 250.0))));
  }

}