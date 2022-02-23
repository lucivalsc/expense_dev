const String tabelaCompras = 'COMPRAS';
const String colunaComprasUserId = 'userId';
const String colunaComprasPhotoId = 'photosId';
const String colunaComprasPhotoTitle = 'photoTitle';
const String colunaComprasAlbumId = 'albumId';
const String colunaComprasAlbumTitle = 'albumTitle';
const String colunaComprasValor = 'valor';
const String colunaComprasUrl = 'url';
const String colunaComprasThumbnailUrl = 'thumbnailUrl';

class ComprasDetalhesModel {
  int? userId;
  int? photosId;
  String? photoTitle;
  int? albumId;
  String? albumTitle;
  String? valor;
  String? url;
  String? thumbnailUrl;

  ComprasDetalhesModel();

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'photosId': photosId,
      'photoTitle': photoTitle,
      'albumId': albumId,
      'albumTitle': albumTitle,
      'valor': valor,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  ComprasDetalhesModel.fromJson(Map json) {
    userId = json['userId'];
    photosId = json['photosId'];
    photoTitle = json['photoTitle'];
    albumId = json['albumId'];
    albumTitle = json['albumTitle'];
    valor = json['valor'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }
}
