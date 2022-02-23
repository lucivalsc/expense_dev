const String tabelaAlbuns = 'ALBUNS';
const String colunaAlbunsUserId = 'userId';
const String colunaAlbunsId = 'id';
const String colunaAlbunsTitle = 'title';

class AlbunsModel {
  int? userId;
  int? id;
  String? title;
  AlbunsModel();

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
    };
  }

  AlbunsModel.fromJson(Map json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
  }
}
