import 'package:flutter/material.dart';
import 'package:tidal/ui/feed/model/photo.dart';
import 'package:tidal/ui/feed/photo_feed_contract.dart';
import 'package:tidal/ui/feed/photo_feed_presenter.dart';
import 'package:tidal/ui/feed/widget/feed_list_widget.dart';
import 'package:tidal/ui/model/photo_type.dart';
import 'package:tidal/ui/widget/loading_widget.dart';
import 'package:tidal/data/photos_data_repository.dart';
import 'package:http/http.dart';

class PhotoFeedView extends StatefulWidget {
  final PhotoType photoType;

  PhotoFeedView({ Key key, this.photoType }) : super(key: key);

  @override
  _PhotoFeedViewState createState() => new _PhotoFeedViewState(photoType);
}

class _PhotoFeedViewState extends State<PhotoFeedView>
    implements PhotosFeedViewContract {

  List<Photo> result;
  PhotoType photoType;
  bool hasError = false;
  bool isLoading = true;
  bool isEmpty = false;

  PhotoFeedPresenter _presenter;

  _PhotoFeedViewState(this.photoType) {
    _presenter = new PhotoFeedPresenter(this,
        new PhotosDataRepository(new Client()));
  }

  @override
  void initState() {
    super.initState();
    _presenter.loadPhotos(this.photoType);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return new SearchLoadingWidget(isLoading);
    } else {
      return new FeedListWidget(result);
    }
  }

  @override
  void setStateForEmpty() {
    setState(() {
      isEmpty = true;
      isLoading = false;
      hasError = false;
      result = null;
    });
  }

  @override
  void setStateForError() {
    setState(() {
      isEmpty = false;
      isLoading = false;
      hasError = true;
      result = null;
    });
  }

  @override
  void setStateForLoading() {
    setState(() {
      isEmpty = false;
      isLoading = true;
      hasError = false;
      result = null;
    });
  }

  @override
  void setStateForPhotos(List<Photo> photos) {
    setState(() {
      isEmpty = false;
      isLoading = false;
      hasError = false;
      result = photos;
    });
  }

}
