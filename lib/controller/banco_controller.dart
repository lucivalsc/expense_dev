import 'dart:async';
import 'dart:io';
import 'package:expense_dev/controller/photos_store.dart';
import 'package:expense_dev/model/albuns_model.dart';
import 'package:expense_dev/model/compras_model.dart';
import 'package:expense_dev/model/photos_model.dart';
import 'package:expense_dev/model/script_sql.dart';
import 'package:expense_dev/model/user_model.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

const String databaseName = 'bd6';
const int databaseVersion = 1;

String baseUrl = 'https://jsonplaceholder.typicode.com/';

class Databasepadrao {
  Databasepadrao._privateConstructor();
  static final Databasepadrao instance = Databasepadrao._privateConstructor();
  static Database? _database;

  Future<Database?> get db async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(ScriptSql.sqlUser);
    await db.execute(ScriptSql.sqlAlbuns);
    await db.execute(ScriptSql.sqlPhotos);
    await db.execute(ScriptSql.sqlCompras);
  }

  Future<void> inserir(String tabela, emprestar) async {
    Database? dbPadrao = await db;
    await dbPadrao!.insert(tabela, emprestar.toMap());
  }

  Future<int?> validarUsuario() async {
    Database? dbPadrao = await db;
    return Sqflite.firstIntValue(
        await dbPadrao!.rawQuery('SELECT COUNT(*) FROM $tabelaUser'));
  }

  Future<List<Map>> retornarUser() async {
    Database? dbPadrao = await db;
    List<Map> listMap = await dbPadrao!.rawQuery(' SELECT * FROM $tabelaUser ');
    return listMap;
  }

  Future<bool> albumExist(String userId) async {
    Database? dbPadrao = await db;
    List<Map> listMap = await dbPadrao!
        .rawQuery(' SELECT * FROM $tabelaAlbuns WHERE USERID = $userId ');
    if (listMap.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<AlbunsModel>> retornarAlbuns() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');

    Database? dbPadrao = await db;
    List<Map> listMap = await dbPadrao!
        .rawQuery(' SELECT * FROM $tabelaAlbuns WHERE USERID = $id ');
    List<AlbunsModel> lista = [];
    for (Map m in listMap) {
      lista.add(AlbunsModel.fromJson(m));
    }
    return lista;
  }

  Future<bool> photosExist(String albumId) async {
    Database? dbPadrao = await db;
    List<Map> listMap = await dbPadrao!
        .rawQuery(' SELECT * FROM $tabelaPhotos WHERE ALBUMID = $albumId');
    if (listMap.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<PhotosModel>> retornarPhotos(String id) async {
    PhotosStore storePhotos = PhotosStore();
    Database? dbPadrao = await db;
    await storePhotos.retornarPhotos(id);
    List<Map> listMap = await dbPadrao!
        .rawQuery(' SELECT * FROM $tabelaPhotos WHERE ALBUMID = $id ');
    List<PhotosModel> lista = [];
    for (Map m in listMap) {
      lista.add(PhotosModel.fromJson(m));
    }
    return lista;
  }

  Future<List<ComprasDetalhesModel>> retornarCompras(String id) async {
    Database? dbPadrao = await db;
    List<Map> listMap = await dbPadrao!.rawQuery(''' 
                    SELECT * FROM $tabelaCompras''');
    List<ComprasDetalhesModel> lista = [];
    for (Map m in listMap) {
      lista.add(ComprasDetalhesModel.fromJson(m));
    }
    return lista;
  }

  Future<int> atualizarFotos(PhotosModel photos) async {
    Database? dbPadrao = await db;
    return await dbPadrao!.update(
      tabelaPhotos,
      photos.toMap(),
      where: "$colunaPhotosId = ?",
      whereArgs: [photos.id],
    );
  }

  Future deletarTudo(String tabela) async {
    Database? dbPadrao = await db;
    await dbPadrao!.delete(tabela);
  }

  Future deletar(String tabela, String coluna, int id) async {
    Database? dbPadrao = await db;
    await dbPadrao!.rawQuery(''' 
                    DELETE FROM $tabela WHERE $coluna = $id ''');
  }

  Future close() async {
    Database? dbPadrao = await db;
    dbPadrao!.close();
  }
}
