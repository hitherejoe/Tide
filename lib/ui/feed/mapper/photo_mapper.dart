import 'package:tidal/data/model/photo_model.dart';
import 'package:tidal/ui/feed/model/photo.dart';

class PhotoMapper {

  Photo mapToPhotoView(PhotoModel photoModel) {
    return new Photo(photoModel.url);
  }

}