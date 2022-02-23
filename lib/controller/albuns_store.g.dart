// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albuns_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlbunsStore on _AlbunsStoreBase, Store {
  final _$emailLogadoAtom = Atom(name: '_AlbunsStoreBase.emailLogado');

  @override
  String get emailLogado {
    _$emailLogadoAtom.reportRead();
    return super.emailLogado;
  }

  @override
  set emailLogado(String value) {
    _$emailLogadoAtom.reportWrite(value, super.emailLogado, () {
      super.emailLogado = value;
    });
  }

  final _$nomeLogadoAtom = Atom(name: '_AlbunsStoreBase.nomeLogado');

  @override
  String get nomeLogado {
    _$nomeLogadoAtom.reportRead();
    return super.nomeLogado;
  }

  @override
  set nomeLogado(String value) {
    _$nomeLogadoAtom.reportWrite(value, super.nomeLogado, () {
      super.nomeLogado = value;
    });
  }

  final _$idLogadoAtom = Atom(name: '_AlbunsStoreBase.idLogado');

  @override
  String get idLogado {
    _$idLogadoAtom.reportRead();
    return super.idLogado;
  }

  @override
  set idLogado(String value) {
    _$idLogadoAtom.reportWrite(value, super.idLogado, () {
      super.idLogado = value;
    });
  }

  final _$inLoadingAtom = Atom(name: '_AlbunsStoreBase.inLoading');

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

  final _$retornarAlbunsAsyncAction =
      AsyncAction('_AlbunsStoreBase.retornarAlbuns');

  @override
  Future retornarAlbuns() {
    return _$retornarAlbunsAsyncAction.run(() => super.retornarAlbuns());
  }

  @override
  String toString() {
    return '''
emailLogado: ${emailLogado},
nomeLogado: ${nomeLogado},
idLogado: ${idLogado},
inLoading: ${inLoading}
    ''';
  }
}
