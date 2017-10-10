import 'package:flutter/material.dart';
import 'package:tide/ui/feed/photo_feed_view.dart';
import 'package:tide/ui/model/photo_type.dart';
import 'package:tide/resources/strings.dart';

class FeedsWidget extends StatefulWidget {

  static const String routeName = '/material/drawer';

  @override
  _FeedsWidgetState createState() => new _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget>
    with TickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AnimationController _controller;
  Animation<double> _drawerContentsOpacity;
  Animation<FractionalOffset> _drawerDetailsPosition;

  static const List<String> _signInDrawerContents = const <String>[
    'Sign in'
  ];

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _drawerContentsOpacity = new CurvedAnimation(
      parent: new ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = new Tween<FractionalOffset>(
      begin: const FractionalOffset(0.0, -1.0),
      end: const FractionalOffset(0.0, 0.0),
    ).animate(new CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      key: _scaffoldKey,
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
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text(''),
                accountEmail: new Text(''),
              ),
              new ClipRect(
                child: new Stack(
                  children: <Widget>[
                    new FadeTransition(
                      opacity: _drawerContentsOpacity,
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _signInDrawerContents.map((String id) {
                          return new ListTile(
                            title: new Text(id)
                          );
                        }).toList(),
                      ),
                    ),
                    new SlideTransition(
                      position: _drawerDetailsPosition,
                      child: new FadeTransition(
                        opacity: new ReverseAnimation(_drawerContentsOpacity),
                        child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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