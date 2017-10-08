import 'package:tidal/ui/feed/model/photo.dart';

abstract class PhotosFeedViewContract {
  void setStateForPhotos(List<Photo> photos);

  void setStateForEmpty();

  void setStateForError();

  void setStateForLoading();
}