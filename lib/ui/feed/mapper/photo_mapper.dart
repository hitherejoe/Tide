import 'package:tide/data/model/photo_model.dart';
import 'package:tide/ui/feed/model/photo.dart';

class PhotoMapper {

  Photo mapToPhotoView(PhotoModel photoModel) {
    return new Photo(photoModel.url);
  }

}