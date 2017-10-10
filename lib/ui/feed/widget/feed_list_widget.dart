import 'package:flutter/material.dart';
import 'package:tide/ui/feed/widget/feed_item_widget.dart';
import 'package:tide/ui/feed/model/photo.dart';

class FeedListWidget extends StatelessWidget {
  final List<Photo> result;

  FeedListWidget(this.result);

  @override
  Widget build(BuildContext context) {
    return new CustomScrollView(
        slivers: _buildEntriesList(context));
  }

  List<Widget> _buildEntriesList(BuildContext context) {
    List<Widget> feedItems = [];
    if (result != null) {
      for (Photo photo in result) {
        feedItems
          ..add(
            new FeedItemWidget(photo: photo),
          );
      }
    }
    return feedItems;
  }

}