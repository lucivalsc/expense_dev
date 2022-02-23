// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photos_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PhotosStore on _PhotosStoreBase, Store {
  final _$inLoadingAtom = Atom(name: '_PhotosStoreBase.inLoading');

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

  final _$retornarPhotosAsyncAction =
      AsyncAction('_PhotosStoreBase.retornarPhotos');

  @override
  Future<void> retornarPhotos(String id) {
    return _$retornarPhotosAsyncAction.run(() => super.retornarPhotos(id));
  }

  @override
  String toString() {
    return '''
inLoading: ${inLoading}
    ''';
  }
}
