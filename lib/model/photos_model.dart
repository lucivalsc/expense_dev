import 'dart:math';

const String tabelaPhotos = 'PHOTOS';
const String colunaPhotosAlbumId = 'albumId';
const String colunaPhotosId = 'id';
const String colunaPhotosTitle = 'title';
const String colunaPhotosUrl = 'url';
const String colunaPhotosThumbnailUrl = 'thumbnailUrl';
const String colunaValor = 'valor';

class PhotosModel {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;
  String? valor;
  PhotosModel();

  Map<String, dynamic> toMap() {
    return {
      'albumId': albumId,
      'id': id,
      'title': title,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
      'valor': valor,
    };
  }

  PhotosModel.fromJson(Map json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
    valor = Random(999).nextDouble().toString();
  }
}
