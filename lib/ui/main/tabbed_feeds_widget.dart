import 'package:flutter/material.dart';
import 'package:tidal/ui/feed/photo_feed_view.dart';
import 'package:tidal/ui/model/photo_type.dart';
import 'package:tidal/resources/strings.dart';

class FeedsWidget extends StatelessWidget {

  const FeedsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: choices.length,
      child: new Scaffold(
        body: new NestedScrollView(
          headerSliverBuilder: (BuildContext context,
              bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                title: const Text(Strings.appName),
                backgroundColor: Colors.teal[600],
                forceElevated: innerBoxIsScrolled,
                bottom: new TabBar(
                  isScrollable: true,
                  tabs: choices.map((TabChoice choice) {
                    return new Tab(
                        text: choice.title
                    );
                  }).toList(),
                ),
              ),
            ];
          },
          body: _buildBody(context),
        ),
      ),
    );
  }

}

Widget _buildBody(BuildContext context) {
  return new TabBarView(
      children: new List<Widget>.generate(choices.length, (int index) {
        return new Container(
          child: new PhotoFeedView(photoType: choices[index].photoType),
          key: new ValueKey<String>('Page $index'),
        );
      }).toList());
}

class TabChoice {
  const TabChoice({ this.title, this.photoType });

  final String title;
  final PhotoType photoType;
}

const List<TabChoice> choices = const <TabChoice>[
  const TabChoice(title: Strings.latestPhotosTab, photoType: PhotoType.LATEST),
  const TabChoice(title: Strings.curatedPhotosTab, photoType: PhotoType.CURATED)
];