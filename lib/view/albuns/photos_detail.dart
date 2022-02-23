import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:expense_dev/controller/banco_controller.dart';
import 'package:expense_dev/model/albuns_model.dart';
import 'package:expense_dev/model/compras_model.dart';
import 'package:expense_dev/model/photos_model.dart';
import 'package:expense_dev/theme/cores.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class PhotosDetail extends StatefulWidget {
  final AlbunsModel albuns;
  final PhotosModel photos;
  const PhotosDetail({
    Key? key,
    required this.albuns,
    required this.photos,
  }) : super(key: key);

  @override
  State<PhotosDetail> createState() => _PhotosDetailState();
}

class _PhotosDetailState extends State<PhotosDetail> {
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  Databasepadrao banco = Databasepadrao.instance;
  final TextEditingController _title = TextEditingController();
  final ComprasDetalhesModel _compras = ComprasDetalhesModel();
  final PhotosModel photosEditar = PhotosModel();

  @override
  void initState() {
    super.initState();
    _title.text = widget.photos.title!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Venda de Fotos',
          style: TextStyle(
            color: Cores.azulEscuro,
          ),
        ),
        actions: [
          InkWell(
            onTap: _showModalDelete,
            child: Lottie.asset(
              'images/delete.json',
              repeat: false,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            const SizedBox(height: 25),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.photos.url!,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: _title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 25),
            Text(
              formatter.format(double.parse(widget.photos.valor!)),
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 75,
        color: Cores.cinzaBar,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Row(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Cores.azulEscuro,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Cores.azulEscuro),
                  child: const Text(
                    'COMPRAR FOTO',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: _salvarCompra,
                ),
              ),
              Expanded(child: Container()),
              FloatingActionButton(
                heroTag: 0,
                child: const Icon(
                  Icons.save,
                ),
                onPressed: () {
                  photosEditar.albumId = widget.photos.albumId;
                  photosEditar.id = widget.photos.id;
                  photosEditar.title = _title.text;
                  photosEditar.url = widget.photos.url;
                  photosEditar.thumbnailUrl = widget.photos.thumbnailUrl;
                  photosEditar.valor = widget.photos.valor;
                  banco.atualizarFotos(photosEditar);
                  Navigator.pop(context, true);
                },
                backgroundColor: Cores.rosa,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  _asyncMethod() async {
    var url = Uri.parse(widget.photos.url!);
    var response = await http.get(url);
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = documentDirectory.path + "/images";
    var filePathAndName = documentDirectory.path + '/images/pic.jpg';
    await Directory(firstPath).create(recursive: true);
    File file2 = File(filePathAndName);
    file2.writeAsBytesSync(response.bodyBytes);
  }

  _salvarCompra() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    _compras.userId = int.parse(userId.toString());
    _compras.photosId = widget.photos.id;
    _compras.photoTitle = widget.photos.title;
    _compras.albumId = widget.albuns.id;
    _compras.albumTitle = widget.albuns.title;
    _compras.valor = widget.photos.valor;
    _compras.url = widget.photos.url;
    _compras.thumbnailUrl = widget.photos.thumbnailUrl;
    await banco.inserir(tabelaCompras, _compras);
    _showVendido();
  }

  _showVendido() {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Foto comprada com sucesso!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 175,
                child: Lottie.asset('images/feliz.json'),
              ),
              const Text('Deseja baixar a foto para galeria?'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                var status = await Permission.storage.status;
                Navigator.pop(context);
                Navigator.pop(context);

                if (status.isGranted) {
                  _asyncMethod();
                }
              },
              child: const Text('Baixar foto'),
            ),
          ],
        );
      },
    );
  }

  _showModalDelete() {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Deseja realmente excluir este item?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCELAR'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Cores.rosa,
              ),
              onPressed: () {
                banco.deletar(
                  tabelaPhotos,
                  colunaPhotosId,
                  widget.photos.id!,
                );
                Navigator.pop(context);
                Navigator.pop(context, true);
              },
              child: const Text('EXCLUIR'),
            ),
          ],
        );
      },
    );
  }
}
