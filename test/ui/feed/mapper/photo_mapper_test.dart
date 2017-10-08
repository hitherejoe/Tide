import 'package:test/test.dart';
import 'package:tidal/data/model/photo_model.dart';
import 'package:tidal/ui/feed/mapper/photo_mapper.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:math' show Random;

void main() {

  PhotoMapper photoMapper = new PhotoMapper();

  test('map to photo view maps data', () {
    var url = "${new Random().nextInt(10000)}";

    var photoModel = new PhotoModel(url);
    expect(url, photoMapper.mapToPhotoView(photoModel).url);
  });

}