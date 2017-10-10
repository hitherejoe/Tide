import 'dart:convert';

import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tide/data/photos_repository.dart';
import 'package:tide/data/model/photo_model.dart';

class PhotosDataRepository implements PhotosRepository {

  static const _kbaseUrl = "https://api.unsplash.com/";
  static const _klatestPhotos = "photos";
  static const _kcuratedPhotos = "photos/curated";
  static const _kApiKey = "your_api_key";
  final Client client;

  PhotosDataRepository(this.client);

  @override
  Observable<List<PhotoModel>> getCuratedPhotos() {
    return retrievePhotos(_kcuratedPhotos);
  }

  @override
  Observable<List<PhotoModel>> getLatestPhotos() {
    return retrievePhotos(_klatestPhotos);
  }

  Observable<List<PhotoModel>> retrievePhotos(String from) {
    return new Observable<Response>.fromFuture(client.get("$_kbaseUrl" + from,
        headers: <String, String>{"Authorization": "Client-ID $_kApiKey"}))
        .where((Response response) => response != null)
        .map((Response response) => JSON.decode(response.body))
        .map((dynamic body) => body)
        .map((dynamic items) => items.map(
            (dynamic item) => new PhotoModel(
            item["urls"]["regular"].toString())));
  }

}