import 'package:tide/data/photos_repository.dart';
import 'package:tide/data/model/photo_model.dart';
import 'package:tide/ui/feed/photo_feed_contract.dart';
import 'package:tide/ui/model/photo_type.dart';
import 'package:tide/ui/feed/mapper/photo_mapper.dart';
import 'package:tide/ui/feed/model/photo.dart';
import 'package:rxdart/rxdart.dart';

class PhotoFeedPresenter {
  PhotosFeedViewContract _view;
  PhotosRepository _repository;
  PhotoMapper _photoMapper;

  PhotoFeedPresenter(this._view, this._repository) {
    _photoMapper = new PhotoMapper();
  }

  void loadPhotos(PhotoType photoType) {
    assert(_view != null);

    Observable<List<PhotoModel>> observable;
    if (photoType == PhotoType.CURATED) {
      observable = _repository.getCuratedPhotos();
    } else {
      observable = _repository.getLatestPhotos();
    }

    observable.call(onData: (Iterable<PhotoModel> latestValue) {
      _view.setStateForLoading();
    }).listen((Iterable<PhotoModel> latestResult) {
      if (latestResult.isNotEmpty) {
        List<Photo> photos = [];
        latestResult.forEach((photoModel) =>
            photos.add(_photoMapper.mapToPhotoView(photoModel)));
        _view.setStateForPhotos(photos);
      } else {
        _view.setStateForEmpty();
      }
    }, onError: (dynamic e) {
      _view.setStateForError();
    }, cancelOnError: false);
  }

}