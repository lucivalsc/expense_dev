import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_dev/controller/banco_controller.dart';
import 'package:expense_dev/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  Databasepadrao banco = Databasepadrao.instance;

  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();

  @observable
  bool inLogin = false;

  @observable
  bool inLoading = false;

  @observable
  bool emailValido = false;

  @observable
  bool senhaValida = false;

  @action
  void validarEmail(String value) {
    emailValido = RegExp(r'^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$')
        .hasMatch(value);
  }

  @action
  void validarSenha(String value) {
    senhaValida = RegExp(
            r'(?=.*[}{,.^?~=+\-_\/@*\-+.\|$@])(?=.*[a-zA-Z])(?=.*[0-9]).{8,}')
        .hasMatch(value);
  }

  @action
  retornarLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    inLoading = true;
    if (isValidarAcesso) {
      var url = Uri.parse(baseUrl + 'users?email=${email.text}');
      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> lista = await jsonDecode(response.body);
        if (lista.isNotEmpty && lista[0]['email'] == email.text) {
          await prefs.setString('name', lista[0]['name']);
          await prefs.setString('email', email.text);
          await prefs.setString('id', lista[0]['id'].toString());
          banco.deletarTudo(tabelaUser);
          for (var item in lista) {
            await banco.inserir(tabelaUser, UserModel.fromJson(item));
          }
          inLogin = true;
        }
      }
    }
    inLoading = false;
  }

  @computed
  bool get isValidarAcesso {
    if (emailValido && senhaValida) {
      return true;
    } else {
      return false;
    }
  }
}
