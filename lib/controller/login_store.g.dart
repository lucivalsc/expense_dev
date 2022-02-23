// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStoreBase, Store {
  Computed<bool>? _$isValidarAcessoComputed;

  @override
  bool get isValidarAcesso =>
      (_$isValidarAcessoComputed ??= Computed<bool>(() => super.isValidarAcesso,
              name: '_LoginStoreBase.isValidarAcesso'))
          .value;

  final _$inLoginAtom = Atom(name: '_LoginStoreBase.inLogin');

  @override
  bool get inLogin {
    _$inLoginAtom.reportRead();
    return super.inLogin;
  }

  @override
  set inLogin(bool value) {
    _$inLoginAtom.reportWrite(value, super.inLogin, () {
      super.inLogin = value;
    });
  }

  final _$inLoadingAtom = Atom(name: '_LoginStoreBase.inLoading');

  @override
  bool get inLoading {
    _$inLoadingAtom.reportRead();
    return super.inLoading;
  }

  @override
  set inLoading(bool value) {
    _$inLoadingAtom.reportWrite(value, super.inLoading, () {
      super.inLoading = value;
    });
  }

  final _$emailValidoAtom = Atom(name: '_LoginStoreBase.emailValido');

  @override
  bool get emailValido {
    _$emailValidoAtom.reportRead();
    return super.emailValido;
  }

  @override
  set emailValido(bool value) {
    _$emailValidoAtom.reportWrite(value, super.emailValido, () {
      super.emailValido = value;
    });
  }

  final _$senhaValidaAtom = Atom(name: '_LoginStoreBase.senhaValida');

  @override
  bool get senhaValida {
    _$senhaValidaAtom.reportRead();
    return super.senhaValida;
  }

  @override
  set senhaValida(bool value) {
    _$senhaValidaAtom.reportWrite(value, super.senhaValida, () {
      super.senhaValida = value;
    });
  }

  final _$retornarLoginAsyncAction =
      AsyncAction('_LoginStoreBase.retornarLogin');

  @override
  Future retornarLogin() {
    return _$retornarLoginAsyncAction.run(() => super.retornarLogin());
  }

  final _$_LoginStoreBaseActionController =
      ActionController(name: '_LoginStoreBase');

  @override
  void validarEmail(String value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.validarEmail');
    try {
      return super.validarEmail(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validarSenha(String value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.validarSenha');
    try {
      return super.validarSenha(value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
inLogin: ${inLogin},
inLoading: ${inLoading},
emailValido: ${emailValido},
senhaValida: ${senhaValida},
isValidarAcesso: ${isValidarAcesso}
    ''';
  }
}
