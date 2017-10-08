import 'package:tidal/data/photos_repository.dart';
import 'package:tidal/data/model/photo_model.dart';
import 'package:tidal/ui/feed/photo_feed_contract.dart';
import 'package:tidal/ui/feed/photo_feed_presenter.dart';
import 'package:tidal/ui/model/photo_type.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';
import 'dart:math' show Random;
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

PhotosFeedViewContract mockViewContract = new MockPhotosFeedViewContract();
PhotosRepository mockDataRepository = new MockPhotosDataRepository();
PhotoFeedPresenter photoFeedPresenter = new PhotoFeedPresenter(
    mockViewContract, mockDataRepository);

void main() {
  test('load photos shows progress', () async {
    reset(mockViewContract);
    stubDataRepositoryGetPhotos(new Observable.just(createPhotoModelList()));

    await photoFeedPresenter.loadPhotos(PhotoType.CURATED);
    verify(mockViewContract.setStateForLoading()).called(1);
  });

  test('load photos never shows error when photos returned', () async {
    reset(mockViewContract);
    stubDataRepositoryGetPhotos(new Observable.just(createPhotoModelList()));

    await photoFeedPresenter.loadPhotos(PhotoType.CURATED);
    verifyNever(mockViewContract.setStateForError());
  });

  test('load photos never shows error when empty photos returned', () async {
    reset(mockViewContract);
    stubDataRepositoryGetPhotos(new Observable.just(createPhotoModelList()));

    await photoFeedPresenter.loadPhotos(PhotoType.CURATED);
    verifyNever(mockViewContract.setStateForError());
  });

  test('load photos sets states for photos', () async {
    reset(mockViewContract);
    stubDataRepositoryGetPhotos(new Observable.just(createPhotoModelList()));

    await photoFeedPresenter.loadPhotos(PhotoType.CURATED);
    verify(mockViewContract.setStateForPhotos(captureAny)).called(1);
  });

  test('load photos sets states for empty', () async {
    reset(mockViewContract);
    stubDataRepositoryGetPhotos(new Observable.just([]));

    await photoFeedPresenter.loadPhotos(PhotoType.CURATED);
    verify(mockViewContract.setStateForEmpty()).called(1);
  });

  test('load photos never sets state for photos when empty', () async {
    reset(mockViewContract);
    stubDataRepositoryGetPhotos(new Observable.just([]));

    await photoFeedPresenter.loadPhotos(PhotoType.CURATED);
    verifyNever(mockViewContract.setStateForPhotos(captureAny));
  });

  test('load photos never sets state for error when empty', () async {
    reset(mockViewContract);
    stubDataRepositoryGetPhotos(new Observable.just([]));

    await photoFeedPresenter.loadPhotos(PhotoType.CURATED);
    verifyNever(mockViewContract.setStateForError());
  });

  test('load photos sets states for error', () async {
    reset(mockViewContract);
    stubDataRepositoryGetPhotos(new Observable.error(null));

    await photoFeedPresenter.loadPhotos(PhotoType.CURATED);
    verify(mockViewContract.setStateForError()).called(1);
  });

  test('load photos never sets states for empty when error occurs', () async {
    reset(mockViewContract);
    stubDataRepositoryGetPhotos(new Observable.error(null));

    await photoFeedPresenter.loadPhotos(PhotoType.CURATED);
    verifyNever(mockViewContract.setStateForEmpty());
  });

  test('load photos never sets states for photos when error occurs', () async {
    reset(mockViewContract);
    stubDataRepositoryGetPhotos(new Observable.error(null));

    await photoFeedPresenter.loadPhotos(PhotoType.CURATED);
    verifyNever(mockViewContract.setStateForPhotos(captureAny));
  });
}

void stubDataRepositoryGetPhotos(Observable<List<PhotoModel>> observable) {
  when(mockDataRepository.getCuratedPhotos())
      .thenReturn(observable);
}

List<PhotoModel> createPhotoModelList() {
  List<PhotoModel> photos = [];
  photos.add(new PhotoModel("${new Random().nextInt(10000)}"));
  photos.add(new PhotoModel("${new Random().nextInt(10000)}"));
  return photos;
}

class MockPhotosFeedViewContract extends Mock
    implements PhotosFeedViewContract {}

class MockPhotosDataRepository extends Mock implements PhotosRepository {}