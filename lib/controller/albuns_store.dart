import 'dart:convert';

import 'package:expense_dev/controller/banco_controller.dart';
import 'package:expense_dev/model/albuns_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
part 'albuns_store.g.dart';

class AlbunsStore = _AlbunsStoreBase with _$AlbunsStore;

abstract class _AlbunsStoreBase with Store {
  Databasepadrao banco = Databasepadrao.instance;

  @observable
  String emailLogado = '';

  @observable
  String nomeLogado = '';

  @observable
  String idLogado = '';

  @observable
  bool inLoading = false;

  @action
  retornarAlbuns() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');

    inLoading = true;

    bool valor = await banco.albumExist(id.toString());
    if (valor == false) {
      await banco.deletarTudo(tabelaAlbuns);
      var url = Uri.parse(baseUrl + 'users/$id/albums');
      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> lista = jsonDecode(response.body);
        for (var item in lista) {
          await banco.inserir(tabelaAlbuns, AlbunsModel.fromJson(item));
        }
      }
    }

    inLoading = false;
  }
}
