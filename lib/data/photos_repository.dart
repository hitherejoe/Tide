import 'package:tidal/data/model/photo_model.dart';
import 'package:rxdart/rxdart.dart';

abstract class PhotosRepository {
  Observable<List<PhotoModel>> getLatestPhotos();
  Observable<List<PhotoModel>> getCuratedPhotos();
}