import 'package:expense_dev/model/albuns_model.dart';
import 'package:expense_dev/model/compras_model.dart';
import 'package:expense_dev/model/photos_model.dart';
import 'package:expense_dev/model/user_model.dart';

class ScriptSql {
  static const sqlUser = '''CREATE TABLE $tabelaUser (
                                $colunaId INTEGER, 			
                                $colunaName TEXT,		
                                $colunaUsername TEXT,	 	
                                $colunaEmail TEXT,	 		
                                $colunaStreet TEXT,	 		
                                $colunaSuite TEXT,	 		
                                $colunaCity TEXT,	 		
                                $colunaZipcode TEXT,	 		
                                $colunaLat TEXT,	 			
                                $colunaLog TEXT,	 			
                                $colunaPhone TEXT,	 		
                                $colunaWebsite TEXT,	 		
                                $colunaNameCompany TEXT,	 	
                                $colunaCathPhrese TEXT,	 	
                                $colunaBs TEXT);
                          ''';

  static const sqlAlbuns = '''CREATE TABLE $tabelaAlbuns (
                                  $colunaAlbunsId INTEGER,
                                  $colunaAlbunsUserId INTEGER,
                                  $colunaAlbunsTitle TEXT); 
                            ''';

  static const sqlPhotos = ''' CREATE TABLE $tabelaPhotos (
                                  $colunaPhotosAlbumId INTEGER,   
                                  $colunaPhotosId INTEGER,         
                                  $colunaPhotosTitle TEXT,      
                                  $colunaPhotosUrl TEXT,        
                                  $colunaPhotosThumbnailUrl TEXT,
                                  $colunaValor TEXT
                                  );
                            ''';
  static const sqlCompras = '''CREATE TABLE $tabelaCompras (
                                  $colunaComprasUserId INTEGER,
                                  $colunaComprasPhotoId INTEGER,
                                  $colunaComprasPhotoTitle TEXT,
                                  $colunaComprasAlbumId INTEGER,
                                  $colunaComprasAlbumTitle TEXT,
                                  $colunaComprasValor TEXT,
                                  $colunaComprasUrl TEXT,
                                  $colunaComprasThumbnailUrl TEXT
                                  ); 
                            ''';
}
