import 'dart:convert';
import 'package:expense_dev/controller/banco_controller.dart';
import 'package:expense_dev/model/photos_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
part 'photos_store.g.dart';

class PhotosStore = _PhotosStoreBase with _$PhotosStore;

abstract class _PhotosStoreBase with Store {
  Databasepadrao banco = Databasepadrao.instance;

  @observable
  bool inLoading = false;

  @action
  Future<void> retornarPhotos(String id) async {
    inLoading = true;
    bool valor = await banco.photosExist(id);
    if (valor == false) {
      banco.deletarTudo(tabelaPhotos);
      var url = Uri.parse(baseUrl + 'albums/$id/photos');
      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> lista = jsonDecode(response.body);
        for (var item in lista) {
          await banco.inserir(tabelaPhotos, PhotosModel.fromJson(item));
        }
      }
    }

    inLoading = false;
  }
}
